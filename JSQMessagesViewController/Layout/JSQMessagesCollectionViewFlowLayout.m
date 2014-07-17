//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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
//
//  Ideas for springy collection view layout taken from Ash Furrow
//  ASHSpringyCollectionView
//  https://github.com/AshFurrow/ASHSpringyCollectionView
//

#import "JSQMessagesCollectionViewFlowLayout.h"

#import "JSQMessageData.h"

#import "JSQMessagesCollectionView.h"
#import "JSQMessagesCollectionViewCell.h"

#import "JSQMessagesCollectionViewLayoutAttributes.h"
#import "JSQMessagesCollectionViewFlowLayoutInvalidationContext.h"

const CGFloat kJSQMessagesCollectionViewCellLabelHeightDefault = 20.0f;


@interface JSQMessagesCollectionViewFlowLayout ()

@property (strong, nonatomic) NSMutableDictionary *messageBubbleSizes;

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) NSMutableSet *visibleIndexPaths;

@property (assign, nonatomic) CGFloat latestDelta;

- (void)jsq_configureFlowLayout;

- (void)jsq_didReceiveApplicationMemoryWarningNotification:(NSNotification *)notification;
- (void)jsq_didReceiveDeviceOrientationDidChangeNotification:(NSNotification *)notification;

- (void)jsq_configureMessageCellLayoutAttributes:(JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;

- (CGFloat)jsq_messageBubbleTextContainerInsetsTotal;

- (CGSize)jsq_avatarSizeForIndexPath:(NSIndexPath *)indexPath;

- (UIAttachmentBehavior *)jsq_springBehaviorWithLayoutAttributesItem:(UICollectionViewLayoutAttributes *)item;

- (void)jsq_addNewlyVisibleBehaviorsFromVisibleItems:(NSArray *)visibleItems;

- (void)jsq_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:(NSSet *)visibleItemsIndexPaths;

- (void)jsq_adjustSpringBehavior:(UIAttachmentBehavior *)springBehavior forTouchLocation:(CGPoint)touchLocation;

@end



@implementation JSQMessagesCollectionViewFlowLayout

#pragma mark - Initialization

- (void)jsq_configureFlowLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 4.0f, 10.0f, 4.0f);
    self.minimumLineSpacing = 4.0f;
    
    _messageBubbleSizes = [NSMutableDictionary new];
    
    _messageBubbleFont = [UIFont systemFontOfSize:15.0f];
    _messageBubbleLeftRightMargin = 40.0f;
    _messageBubbleTextViewFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
    _messageBubbleTextViewTextContainerInsets = UIEdgeInsetsMake(10.0f, 8.0f, 10.0f, 8.0f);
    
    CGSize defaultAvatarSize = CGSizeMake(34.0f, 34.0f);
    _incomingAvatarViewSize = defaultAvatarSize;
    _outgoingAvatarViewSize = defaultAvatarSize;
    
    CGSize defaultMediaThumbnailImageSize = CGSizeMake(120.0f, 160.0f);
    _incomingThumbnailImageSize = defaultMediaThumbnailImageSize;
    _outgoingThumbnailImageSize = defaultMediaThumbnailImageSize;
    
    _incomingVideoThumbnailSize = defaultMediaThumbnailImageSize;
    _outgoingVideoThumbnailSize = defaultMediaThumbnailImageSize;
    
    CGSize defaultAudioPlayerViewSize = CGSizeMake(150.f, 40.f);
    _incomingAudioPlayerViewSize = defaultAudioPlayerViewSize;
    _outgoingAudioPlayerViewSize = defaultAudioPlayerViewSize;
    
    
    CGSize defaultOverlayViewSize = CGSizeMake(40.f, 40.f);
    _incomingVideoOverlayViewSize = defaultOverlayViewSize;
    _outgoingVideoOverlayViewSize = defaultOverlayViewSize;
    
    CGSize defaultActivityIndicatorViewSize = CGSizeMake(20.f, 20.f);
    _incomingPhotoActivityIndicatorViewSize = defaultActivityIndicatorViewSize;
    _outgoingPhotoActivityIndicatorViewSize = defaultActivityIndicatorViewSize;
    _incomingVideoActivityIndicatorViewSize = defaultActivityIndicatorViewSize;
    _outgoingVideoActivityIndicatorViewSize = defaultActivityIndicatorViewSize;
    _incomingAudioActivityIndicatorViewSize = defaultActivityIndicatorViewSize;
    _outgoingAudioActivityIndicatorViewSize = defaultActivityIndicatorViewSize;
    
    _springinessEnabled = NO;
    _springResistanceFactor = 1000;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveApplicationMemoryWarningNotification:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveDeviceOrientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jsq_configureFlowLayout];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self jsq_configureFlowLayout];
}

+ (Class)layoutAttributesClass
{
    return [JSQMessagesCollectionViewLayoutAttributes class];
}

+ (Class)invalidationContextClass
{
    return [JSQMessagesCollectionViewFlowLayoutInvalidationContext class];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    _messageBubbleFont = nil;
    
    _messageBubbleSizes = nil;
    
    _dynamicAnimator = nil;
    _visibleIndexPaths = nil;
}

#pragma mark - Setters

- (void)setSpringinessEnabled:(BOOL)springinessEnabled
{
    _springinessEnabled = springinessEnabled;
    
    if (!springinessEnabled) {
        [_dynamicAnimator removeAllBehaviors];
        [_visibleIndexPaths removeAllObjects];
    }
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setMessageBubbleFont:(UIFont *)messageBubbleFont
{
    NSParameterAssert(messageBubbleFont != nil);
    _messageBubbleFont = messageBubbleFont;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setMessageBubbleLeftRightMargin:(CGFloat)messageBubbleLeftRightMargin
{
    _messageBubbleLeftRightMargin = messageBubbleLeftRightMargin;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setMessageBubbleTextViewTextContainerInsets:(UIEdgeInsets)messageBubbleTextContainerInsets
{
    _messageBubbleTextViewTextContainerInsets = messageBubbleTextContainerInsets;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    _incomingAvatarViewSize = incomingAvatarViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    _outgoingAvatarViewSize = outgoingAvatarViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingThumbnailImageSize:(CGSize)incomingThumbnailImageSize
{
    _incomingThumbnailImageSize = incomingThumbnailImageSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingThumbnailImageSize:(CGSize)outgoingThumbnailImageSize
{
    _outgoingThumbnailImageSize = outgoingThumbnailImageSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingVideoThumbnailSize:(CGSize)incomingVideoThumbnailSize
{
    _incomingVideoThumbnailSize = incomingVideoThumbnailSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingVideoThumbnailSize:(CGSize)outgoingVideoThumbnailSize
{
    _outgoingVideoThumbnailSize = outgoingVideoThumbnailSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingAudioPlayerViewSize:(CGSize)incomingAudioPlayerSize
{
    _incomingAudioPlayerViewSize = incomingAudioPlayerSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingAudioPlayerViewSize:(CGSize)outgoingAudioPlayerSize
{
    _outgoingAudioPlayerViewSize = outgoingAudioPlayerSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingVideoOverlayViewSize:(CGSize )incomingVideoOverlayViewSize
{
    _incomingVideoOverlayViewSize = incomingVideoOverlayViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingVideoOverlayViewSize:(CGSize )outgoingVideoOverlayViewSize
{
    _outgoingVideoOverlayViewSize = outgoingVideoOverlayViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingPhotoActivityIndicatorViewSize:(CGSize)incomingPhotoActivityIndicatorViewSize
{
    _incomingPhotoActivityIndicatorViewSize = incomingPhotoActivityIndicatorViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingPhotoActivityIndicatorViewSize:(CGSize)outgoingPhotoActivityIndicatorViewSize
{
    _outgoingPhotoActivityIndicatorViewSize = outgoingPhotoActivityIndicatorViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingVideoActivityIndicatorViewSize:(CGSize)incomingVideoActivityIndicatorViewSize
{
    _incomingVideoActivityIndicatorViewSize = incomingVideoActivityIndicatorViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingVideoActivityIndicatorViewSize:(CGSize)outgoingVideoActivityIndicatorViewSize
{
    _outgoingVideoActivityIndicatorViewSize = outgoingVideoActivityIndicatorViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setIncomingAudioActivityIndicatorViewSize:(CGSize)incomingAudioActivityIndicatorViewSize
{
    _incomingAudioActivityIndicatorViewSize = incomingAudioActivityIndicatorViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)setOutgoingAudioActivityIndicatorViewSize:(CGSize)outgoingAudioActivityIndicatorViewSize
{
    _outgoingAudioActivityIndicatorViewSize = outgoingAudioActivityIndicatorViewSize;
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}


#pragma mark - Getters

- (CGFloat)itemWidth
{
    return CGRectGetWidth(self.collectionView.frame) - self.sectionInset.left - self.sectionInset.right;
}

- (UIDynamicAnimator *)dynamicAnimator
{
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    return _dynamicAnimator;
}

- (NSMutableSet *)visibleIndexPaths
{
    if (!_visibleIndexPaths) {
        _visibleIndexPaths = [NSMutableSet new];
    }
    return _visibleIndexPaths;
}

#pragma mark - Notifications

- (void)jsq_didReceiveApplicationMemoryWarningNotification:(NSNotification *)notification
{
    [self.messageBubbleSizes removeAllObjects];
    [self.dynamicAnimator removeAllBehaviors];
    [self.visibleIndexPaths removeAllObjects];
}

- (void)jsq_didReceiveDeviceOrientationDidChangeNotification:(NSNotification *)notification
{
    [self.dynamicAnimator removeAllBehaviors];
    [self.visibleIndexPaths removeAllObjects];
    [self invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

#pragma mark - Collection view flow layout

- (void)invalidateLayoutWithContext:(JSQMessagesCollectionViewFlowLayoutInvalidationContext *)context
{
    if (context.invalidateDataSourceCounts) {
        context.invalidateFlowLayoutAttributes = YES;
        context.invalidateFlowLayoutDelegateMetrics = YES;
    }
    
    if (context.invalidateFlowLayoutAttributes || context.invalidateFlowLayoutDelegateMetrics) {
        [self.messageBubbleSizes removeAllObjects];
    }
    
    [super invalidateLayoutWithContext:context];
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    if (self.springinessEnabled) {
        //  pad rect to avoid flickering
        CGFloat padding = -100.0f;
        CGRect visibleRect = CGRectInset(self.collectionView.bounds, padding, padding);
        
        NSArray *visibleItems = [super layoutAttributesForElementsInRect:visibleRect];
        NSSet *visibleItemsIndexPaths = [NSSet setWithArray:[visibleItems valueForKey:NSStringFromSelector(@selector(indexPath))]];
        
        [self jsq_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:visibleItemsIndexPaths];
        
        [self jsq_addNewlyVisibleBehaviorsFromVisibleItems:visibleItems];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes;
    
    if (self.springinessEnabled) {
        attributes = [self.dynamicAnimator itemsInRect:rect];
    }
    else {
        attributes = [super layoutAttributesForElementsInRect:rect];
    }
    
    [attributes enumerateObjectsUsingBlock:^(JSQMessagesCollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop) {
        [self jsq_configureMessageCellLayoutAttributes:attributes];
    }];
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    [self jsq_configureMessageCellLayoutAttributes:customAttributes];
    return customAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (self.springinessEnabled) {
        UIScrollView *scrollView = self.collectionView;
        CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
        
        self.latestDelta = delta;
        
        CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
        
        [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
            [self jsq_adjustSpringBehavior:springBehaviour forTouchLocation:touchLocation];
            [self.dynamicAnimator updateItemUsingCurrentState:[springBehaviour.items firstObject]];
        }];
    }
    
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    if (self.springinessEnabled) {
        [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger index, BOOL *stop) {
            if (updateItem.updateAction == UICollectionUpdateActionInsert) {
                
                if ([self.dynamicAnimator layoutAttributesForCellAtIndexPath:updateItem.indexPathAfterUpdate]) {
                    *stop = YES;
                }
                
                CGSize size = self.collectionView.bounds.size;
                JSQMessagesCollectionViewLayoutAttributes *attributes = [JSQMessagesCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:updateItem.indexPathAfterUpdate];
                [self jsq_configureMessageCellLayoutAttributes:attributes];
                attributes.frame = CGRectMake(0.0f,
                                              size.height - size.width,
                                              size.width,
                                              size.width);
                
                UIAttachmentBehavior *springBehaviour = [self jsq_springBehaviorWithLayoutAttributesItem:attributes];
                [self.dynamicAnimator addBehavior:springBehaviour];
            }
        }];
    }
}

#pragma mark - Message cell layout utilities

- (CGSize)messageBubbleSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSValue *cachedSize = [self.messageBubbleSizes objectForKey:indexPath];
    if (cachedSize) {
        return [cachedSize CGSizeValue];
    }
    
    id<JSQMessageData> messageData = [self.collectionView.dataSource collectionView:self.collectionView messageDataForItemAtIndexPath:indexPath];
    NSString *messageSender = [messageData sender];
    
    BOOL isOutgoingMessage = [messageSender isEqualToString:[self.collectionView.dataSource sender]];
    CGSize finalSize = CGSizeZero;
    
    switch ([messageData type]) {
        case JSQMessageText:
        {
            CGSize avatarSize = [self jsq_avatarSizeForIndexPath:indexPath];
            
            CGFloat maximumTextWidth = self.itemWidth - avatarSize.width - self.messageBubbleLeftRightMargin;
            
            CGFloat textInsetsTotal = [self jsq_messageBubbleTextContainerInsetsTotal];
            
            CGRect stringRect = [[messageData text] boundingRectWithSize:CGSizeMake(maximumTextWidth - textInsetsTotal, CGFLOAT_MAX)
                                                                 options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                              attributes:@{ NSFontAttributeName : self.messageBubbleFont }
                                                                 context:nil];
            
            CGSize stringSize = CGRectIntegral(stringRect).size;
            
            CGFloat verticalInsets = self.messageBubbleTextViewTextContainerInsets.top + self.messageBubbleTextViewTextContainerInsets.bottom;
            
            finalSize = CGSizeMake(stringSize.width, stringSize.height + verticalInsets);
        }
            break;
        case JSQMessagePhoto:
        case JSQMessageRemotePhoto:
            finalSize = isOutgoingMessage ? self.outgoingThumbnailImageSize : self.incomingThumbnailImageSize;
            break;
        case JSQMessageVideo:
        case JSQMessageRemoteVideo:
            finalSize = isOutgoingMessage ? self.outgoingVideoThumbnailSize : self.incomingVideoThumbnailSize;
            break;
        case JSQMessageAudio:
        case JSQMessageRemoteAudio:
            finalSize = isOutgoingMessage ? self.outgoingAudioPlayerViewSize : self.incomingAudioPlayerViewSize;
            break;
    }
    
    [self.messageBubbleSizes setObject:[NSValue valueWithCGSize:finalSize] forKey:indexPath];
    
    return finalSize;
}

- (void)jsq_configureMessageCellLayoutAttributes:(JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes
{
    NSIndexPath *indexPath = layoutAttributes.indexPath;
    
    CGSize messageBubbleSize = [self messageBubbleSizeForItemAtIndexPath:indexPath];
    CGFloat remainingItemWidthForBubble = self.itemWidth - [self jsq_avatarSizeForIndexPath:indexPath].width;
    CGFloat textPadding = [self jsq_messageBubbleTextContainerInsetsTotal];
    CGFloat messageBubblePadding = remainingItemWidthForBubble - messageBubbleSize.width - textPadding;
    
    layoutAttributes.messageBubbleLeftRightMargin = messageBubblePadding;
    layoutAttributes.textViewFrameInsets = self.messageBubbleTextViewFrameInsets;
    layoutAttributes.textViewTextContainerInsets = self.messageBubbleTextViewTextContainerInsets;
    layoutAttributes.messageBubbleFont = self.messageBubbleFont;
    layoutAttributes.incomingAvatarViewSize = self.incomingAvatarViewSize;
    layoutAttributes.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    layoutAttributes.incomingThumbnailImageSize = self.incomingThumbnailImageSize;
    layoutAttributes.outgoingThumbnailImageSize = self.outgoingThumbnailImageSize;
    layoutAttributes.incomingVideoThumbnailSize = self.incomingVideoThumbnailSize;
    layoutAttributes.outgoingVideoThumbnailSize = self.outgoingVideoThumbnailSize;
    layoutAttributes.incomingAudioPlayerViewSize = self.incomingAudioPlayerViewSize;
    layoutAttributes.outgoingAudioPlayerViewSize = self.outgoingAudioPlayerViewSize;
    layoutAttributes.incomingVideoOverlayViewSize = self.incomingVideoOverlayViewSize;
    layoutAttributes.outgoingVideoOverlayViewSize = self.outgoingVideoOverlayViewSize;
    layoutAttributes.incomingPhotoActivityIndicatorViewSize = self.incomingPhotoActivityIndicatorViewSize;
    layoutAttributes.outgoingPhotoActivityIndicatorViewSize = self.outgoingPhotoActivityIndicatorViewSize;
    layoutAttributes.incomingVideoActivityIndicatorViewSize = self.incomingVideoActivityIndicatorViewSize;
    layoutAttributes.outgoingVideoActivityIndicatorViewSize = self.outgoingVideoActivityIndicatorViewSize;
    layoutAttributes.incomingAudioActivityIndicatorViewSize = self.incomingAudioActivityIndicatorViewSize;
    layoutAttributes.outgoingAudioActivityIndicatorViewSize = self.outgoingAudioActivityIndicatorViewSize;
    
    layoutAttributes.cellTopLabelHeight = [self.collectionView.delegate collectionView:self.collectionView
                                                                                layout:self
                                                      heightForCellTopLabelAtIndexPath:indexPath];
    
    layoutAttributes.messageBubbleTopLabelHeight = [self.collectionView.delegate collectionView:self.collectionView
                                                                                         layout:self
                                                      heightForMessageBubbleTopLabelAtIndexPath:indexPath];
    
    layoutAttributes.cellBottomLabelHeight = [self.collectionView.delegate collectionView:self.collectionView
                                                                                   layout:self
                                                      heightForCellBottomLabelAtIndexPath:indexPath];
}

- (CGFloat)jsq_messageBubbleTextContainerInsetsTotal
{
    UIEdgeInsets insets = self.messageBubbleTextViewTextContainerInsets;
    return insets.left + insets.right + insets.bottom + insets.top;
}

- (CGSize)jsq_avatarSizeForIndexPath:(NSIndexPath *)indexPath
{
    id<JSQMessageData> messageData = [self.collectionView.dataSource collectionView:self.collectionView messageDataForItemAtIndexPath:indexPath];
    NSString *messageSender = [messageData sender];
   
    if ([messageSender isEqualToString:[self.collectionView.dataSource sender]]) {
        return self.outgoingAvatarViewSize;
    }
    
    return self.incomingAvatarViewSize;
}

#pragma mark - Spring behavior utilities

- (UIAttachmentBehavior *)jsq_springBehaviorWithLayoutAttributesItem:(UICollectionViewLayoutAttributes *)item
{
    UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
    springBehavior.length = 1.0f;
    springBehavior.damping = 1.0f;
    springBehavior.frequency = 1.0f;
    return springBehavior;
}

- (void)jsq_addNewlyVisibleBehaviorsFromVisibleItems:(NSArray *)visibleItems
{
    //  a "newly visible" item is in `visibleItems` but not in `self.visibleIndexPaths`
    NSIndexSet *indexSet = [visibleItems indexesOfObjectsPassingTest:^BOOL(UICollectionViewLayoutAttributes *item, NSUInteger index, BOOL *stop) {
        return ![self.visibleIndexPaths containsObject:item.indexPath];
    }];
    
    NSArray *newlyVisibleItems = [visibleItems objectsAtIndexes:indexSet];
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [newlyVisibleItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger index, BOOL *stop) {
        UIAttachmentBehavior *springBehaviour = [self jsq_springBehaviorWithLayoutAttributesItem:item];
        [self jsq_adjustSpringBehavior:springBehaviour forTouchLocation:touchLocation];
        [self.dynamicAnimator addBehavior:springBehaviour];
        [self.visibleIndexPaths addObject:item.indexPath];
    }];
}

- (void)jsq_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:(NSSet *)visibleItemsIndexPaths
{
    NSArray *behaviors = self.dynamicAnimator.behaviors;
    
    NSIndexSet *indexSet = [behaviors indexesOfObjectsPassingTest:^BOOL(UIAttachmentBehavior *springBehaviour, NSUInteger index, BOOL *stop) {
        UICollectionViewLayoutAttributes *layoutAttributes = [springBehaviour.items firstObject];
        return ![visibleItemsIndexPaths containsObject:layoutAttributes.indexPath];
    }];
    
    NSArray *behaviorsToRemove = [self.dynamicAnimator.behaviors objectsAtIndexes:indexSet];
    
    [behaviorsToRemove enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger index, BOOL *stop) {
        UICollectionViewLayoutAttributes *layoutAttributes = [springBehaviour.items firstObject];
        [self.dynamicAnimator removeBehavior:springBehaviour];
        [self.visibleIndexPaths removeObject:layoutAttributes.indexPath];
    }];
}

- (void)jsq_adjustSpringBehavior:(UIAttachmentBehavior *)springBehavior forTouchLocation:(CGPoint)touchLocation
{
    UICollectionViewLayoutAttributes *item = [springBehavior.items firstObject];
    CGPoint center = item.center;
    
    //  if touch is not (0,0) -- adjust item center "in flight"
    if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
        CGFloat distanceFromTouch = fabsf(touchLocation.y - springBehavior.anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / self.springResistanceFactor;
        
        if (self.latestDelta < 0.0f) {
            center.y += MAX(self.latestDelta, self.latestDelta * scrollResistance);
        }
        else {
            center.y += MIN(self.latestDelta, self.latestDelta * scrollResistance);
        }
        item.center = center;
    }
}

@end
