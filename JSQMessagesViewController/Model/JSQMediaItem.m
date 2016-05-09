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

#import "JSQMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"
#import "JSQMessagesCollectionView.h"

@implementation JSQMediaItem

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithMaskAsOutgoing:YES];
}

- (instancetype)initWithMaskAsOutgoing:(BOOL)maskAsOutgoing
{
    self = [super init];
    if (self) {
        _appliesMediaViewMaskAsOutgoing = maskAsOutgoing;
        _cachedPlaceholderView = nil;
        _cachedMediaView = nil;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarningNotification:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    _appliesMediaViewMaskAsOutgoing = appliesMediaViewMaskAsOutgoing;
    _cachedPlaceholderView = nil;
    _cachedMediaView = nil;
}

- (void)clearCachedMediaViews
{
    _cachedPlaceholderView = nil;
    _cachedMediaView = nil;
}

#pragma mark - Notifications

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification
{
    [self clearCachedMediaViews];
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaViewWithMessageData:(id<JSQMessageData>)messageData layout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
    return nil;
}

- (CGSize)mediaViewDisplaySizeWithMessageData:(id<JSQMessageData>)messageData layout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    CGSize avatarSize = CGSizeZero;
    if ([[messageData senderId] isEqualToString:[layout.collectionView.dataSource senderId]]) {
        avatarSize = layout.outgoingAvatarViewSize;
    } else {
        avatarSize = layout.incomingAvatarViewSize;
    }
    CGFloat spacingBetweenAvatarAndBubble = 2.0f;
    
    CGFloat maximumItemWidth = layout.itemWidth - avatarSize.width - layout.messageBubbleLeftRightMargin - spacingBetweenAvatarAndBubble;
    
    return CGSizeMake(maximumItemWidth, maximumItemWidth*0.7);
}

- (UIView *)mediaPlaceholderViewWithMessageData:(id<JSQMessageData>)messageData layout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    if (self.cachedPlaceholderView == nil) {
        CGSize size = [self mediaViewDisplaySizeWithMessageData:messageData layout:layout];
        UIView *view = [JSQMessagesMediaPlaceholderView viewWithActivityIndicator];
        view.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:view isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedPlaceholderView = view;
    }
    
    return self.cachedPlaceholderView;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    JSQMediaItem *item = (JSQMediaItem *)object;
    
    return self.appliesMediaViewMaskAsOutgoing == item.appliesMediaViewMaskAsOutgoing;
}

- (NSUInteger)hash
{
    return [NSNumber numberWithBool:self.appliesMediaViewMaskAsOutgoing].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: appliesMediaViewMaskAsOutgoing=%@>",
            [self class], @(self.appliesMediaViewMaskAsOutgoing)];
}

- (id)debugQuickLookObject
{
    return self.cachedMediaView ?: self.cachedPlaceholderView;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _appliesMediaViewMaskAsOutgoing = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(appliesMediaViewMaskAsOutgoing))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.appliesMediaViewMaskAsOutgoing forKey:NSStringFromSelector(@selector(appliesMediaViewMaskAsOutgoing))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithMaskAsOutgoing:self.appliesMediaViewMaskAsOutgoing];
}

@end
