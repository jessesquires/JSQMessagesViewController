//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesBubblesSizeCalculator.h"

#import "JSQMessagesCollectionView.h"
#import "JSQMessagesCollectionViewDataSource.h"
#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessageData.h"

#import "UIImage+JSQMessages.h"


@interface JSQMessagesBubblesSizeCalculator ()

@property (strong, nonatomic, readonly) NSCache *cache;

@property (assign, nonatomic, readonly) NSUInteger minimumBubbleWidth;

@property (assign, nonatomic, readonly) BOOL usesFixedWidthMessageBubbles;

@property (assign, nonatomic) NSInteger rotationIndependentLayoutWidth;

@end


@implementation JSQMessagesBubblesSizeCalculator

#pragma mark - Init

- (instancetype)initWithCache:(NSCache *)cache minimumBubbleWidth:(NSUInteger)minimumBubbleWidth usesFixedWidthMessageBubbles:(BOOL)fixedWidthMessageBubbles
{
    NSParameterAssert(cache != nil);
    NSParameterAssert(minimumBubbleWidth > 0);

    self = [super init];
    if (self) {
        _cache = cache;
        _minimumBubbleWidth = minimumBubbleWidth;
        _usesFixedWidthMessageBubbles = fixedWidthMessageBubbles;
    }
    return self;
}

- (instancetype)init
{
    NSCache *cache = [NSCache new];
    cache.name = @"JSQMessagesBubblesSizeCalculator.cache";
    cache.countLimit = 200;
	return [self initWithCache:cache
			minimumBubbleWidth:[UIImage jsq_bubbleCompactImage].size.width
  usesFixedWidthMessageBubbles:NO
			];
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: cache=%@, minimumBubbleWidth=%@>",
            [self class], self.cache, @(self.minimumBubbleWidth)];
}

#pragma mark - JSQMessagesBubbleSizeCalculating

- (void)prepareForResettingLayout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    [self.cache removeAllObjects];
}

- (CGSize)messageBubbleSizeForMessageData:(id<JSQMessageData>)messageData
                              atIndexPath:(NSIndexPath *)indexPath
                               withLayout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    NSValue *cachedSize = [self.cache objectForKey:@([messageData messageHash])];
    if (cachedSize != nil) {
        return [cachedSize CGSizeValue];
    }

    CGSize finalSize = CGSizeZero;

    if ([messageData isMediaMessage]) {
        finalSize = [[messageData media] mediaViewDisplaySize];
    }
    else {
        CGSize avatarSize = [self jsq_avatarSizeForMessageData:messageData withLayout:layout];

        //  from the cell xibs, there is a 2 point space between avatar and bubble
        CGFloat spacingBetweenAvatarAndBubble = 2.0f;
        CGFloat horizontalContainerInsets = layout.messageBubbleTextViewTextContainerInsets.left + layout.messageBubbleTextViewTextContainerInsets.right;
        CGFloat horizontalFrameInsets = layout.messageBubbleTextViewFrameInsets.left + layout.messageBubbleTextViewFrameInsets.right;

        CGFloat horizontalInsetsTotal = horizontalContainerInsets + horizontalFrameInsets + spacingBetweenAvatarAndBubble;
        CGFloat maximumTextWidth = [self textBubbleWidth:layout] - avatarSize.width - layout.messageBubbleLeftRightMargin - horizontalInsetsTotal;

        CGRect stringRect = [[messageData text] boundingRectWithSize:CGSizeMake(maximumTextWidth, CGFLOAT_MAX)
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:@{ NSFontAttributeName : layout.messageBubbleFont }
                                                             context:nil];

        CGSize stringSize = CGRectIntegral(stringRect).size;

        CGFloat verticalContainerInsets = layout.messageBubbleTextViewTextContainerInsets.top + layout.messageBubbleTextViewTextContainerInsets.bottom;
        CGFloat verticalFrameInsets = layout.messageBubbleTextViewFrameInsets.top + layout.messageBubbleTextViewFrameInsets.bottom;

        //  add extra 2 points of space, because `boundingRectWithSize:` is slightly off
        //  not sure why. magix. (shrug) if you know, submit a PR
        CGFloat verticalInsets = verticalContainerInsets + verticalFrameInsets + [self magixInsetAddition];

        //  same as above, an extra 2 points of magix
        CGFloat finalWidth = MAX(stringSize.width + horizontalInsetsTotal, self.minimumBubbleWidth) + [self magixInsetAddition];

        finalSize = CGSizeMake(finalWidth, stringSize.height + verticalInsets);
    }

    [self.cache setObject:[NSValue valueWithCGSize:finalSize] forKey:@([messageData messageHash])];

    return finalSize;
}

- (CGSize)jsq_avatarSizeForMessageData:(id<JSQMessageData>)messageData
                            withLayout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    NSString *messageSender = [messageData senderId];

    if ([messageSender isEqualToString:[layout.collectionView.dataSource senderId]]) {
        return layout.outgoingAvatarViewSize;
    }
    
    return layout.incomingAvatarViewSize;
}

- (NSInteger)magixInsetAddition {
    //  Creating a getter for this magix value because we are using it in a couple of places.
    //
    //  add extra 2 points of space, because `boundingRectWithSize:` is slightly off
    //  not sure why. magix. (shrug) if you know, submit a PR
    return 2;
}

- (CGFloat)textBubbleWidth:(JSQMessagesCollectionViewFlowLayout *)layout
{
    if (_usesFixedWidthMessageBubbles) {
        if (_rotationIndependentLayoutWidth == 0) {
            //  Adding the magix here because we're using it in messageBubbleSizeForItemAtIndexPath
            NSInteger sectionInset = layout.sectionInset.left + layout.sectionInset.right + [self magixInsetAddition];
            CGFloat width = CGRectGetWidth([(UICollectionView *)[layout collectionView] bounds]) - sectionInset;
            CGFloat height = CGRectGetHeight([(UICollectionView *)[layout collectionView] bounds]) - sectionInset;
            CGFloat minValue = (width<height)?width:height;
            _rotationIndependentLayoutWidth = minValue;
        }
        return _rotationIndependentLayoutWidth;
    }
    return layout.itemWidth;
}

@end
