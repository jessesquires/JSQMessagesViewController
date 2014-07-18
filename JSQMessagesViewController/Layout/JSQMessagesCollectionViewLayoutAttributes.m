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

#import "JSQMessagesCollectionViewLayoutAttributes.h"


@implementation JSQMessagesCollectionViewLayoutAttributes

#pragma mark - Lifecycle

- (void)dealloc
{
    _messageBubbleFont = nil;
}

#pragma mark - Setters

- (void)setMessageBubbleFont:(UIFont *)messageBubbleFont
{
    NSParameterAssert(messageBubbleFont != nil);
    _messageBubbleFont = messageBubbleFont;
}

- (void)setMessageBubbleLeftRightMargin:(CGFloat)messageBubbleLeftRightMargin
{
    NSParameterAssert(messageBubbleLeftRightMargin >= 0.0f);
    _messageBubbleLeftRightMargin = ceilf(messageBubbleLeftRightMargin);
}

- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    NSParameterAssert(incomingAvatarViewSize.width >= 0.0f && incomingAvatarViewSize.height >= 0.0f);
    _incomingAvatarViewSize = CGSizeMake(ceil(incomingAvatarViewSize.width), ceilf(incomingAvatarViewSize.height));
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    NSParameterAssert(outgoingAvatarViewSize.width >= 0.0f && outgoingAvatarViewSize.height >= 0.0f);
    _outgoingAvatarViewSize = CGSizeMake(ceil(outgoingAvatarViewSize.width), ceilf(outgoingAvatarViewSize.height));
}

- (void)setIncomingThumbnailImageSize:(CGSize)incomingThumbnailImageSize
{
    NSParameterAssert(incomingThumbnailImageSize.width > 0.0f && incomingThumbnailImageSize.height > 0.0f);
    _incomingThumbnailImageSize = CGSizeMake(ceil(incomingThumbnailImageSize.width), ceilf(incomingThumbnailImageSize.height));
}

- (void)setOutgoingThumbnailImageSize:(CGSize)outgoingThumbnailImageSize
{
    NSParameterAssert(outgoingThumbnailImageSize.width > 0.0f && outgoingThumbnailImageSize.height > 0.0f);
    _outgoingThumbnailImageSize = CGSizeMake(ceil(outgoingThumbnailImageSize.width), ceilf(outgoingThumbnailImageSize.height));
}

- (void)setIncomingVideoThumbnailSize:(CGSize)incomingVideoThumbnailSize
{
    NSParameterAssert(incomingVideoThumbnailSize.width > 0.0f && incomingVideoThumbnailSize.height > 0.0f);
    _incomingVideoThumbnailSize = CGSizeMake(ceil(incomingVideoThumbnailSize.width), ceilf(incomingVideoThumbnailSize.height));
}

- (void)setOutgoingVideoThumbnailSize:(CGSize)outgoingVideoThumbnailSize
{
    NSParameterAssert(outgoingVideoThumbnailSize.width > 0.0f && outgoingVideoThumbnailSize.height > 0.0f);
    _outgoingVideoThumbnailSize = CGSizeMake(ceil(outgoingVideoThumbnailSize.width), ceilf(outgoingVideoThumbnailSize.height));
}

- (void)setIncomingAudioPlayerViewSize:(CGSize)incomingAudioPlayerViewSize
{
    NSParameterAssert(incomingAudioPlayerViewSize.width >= 0.0f && incomingAudioPlayerViewSize.height >= 0.0f);
    _incomingAudioPlayerViewSize = CGSizeMake(ceil(incomingAudioPlayerViewSize.width), ceilf(incomingAudioPlayerViewSize.height));
}

- (void)setOutgoingAudioPlayerViewSize:(CGSize)outgoingAudioPlayerViewSize
{
    NSParameterAssert(outgoingAudioPlayerViewSize.width >= 0.0f && outgoingAudioPlayerViewSize.height >= 0.0f);
    _outgoingAudioPlayerViewSize = CGSizeMake(ceil(outgoingAudioPlayerViewSize.width), ceilf(outgoingAudioPlayerViewSize.height));
}

- (void)setIncomingVideoOverlayViewSize:(CGSize)incomingVideoOverlayViewSize
{
    NSParameterAssert(incomingVideoOverlayViewSize.width >= 0.0f && incomingVideoOverlayViewSize.height >= 0.0f);
    _incomingVideoOverlayViewSize = CGSizeMake(ceil(incomingVideoOverlayViewSize.width), ceilf(incomingVideoOverlayViewSize.height));
}

- (void)setOutgoingVideoOverlayViewSize:(CGSize)outgoingVideoOverlayViewSize
{
    NSParameterAssert(outgoingVideoOverlayViewSize.width >= 0.0f && outgoingVideoOverlayViewSize.height >= 0.0f);
    _outgoingVideoOverlayViewSize = CGSizeMake(ceil(outgoingVideoOverlayViewSize.width), ceilf(outgoingVideoOverlayViewSize.height));
}

- (void)setIncomingPhotoActivityIndicatorViewSize:(CGSize)incomingPhotoActivityIndicatorViewSize
{
    NSParameterAssert(incomingPhotoActivityIndicatorViewSize.width >= 0.0f && incomingPhotoActivityIndicatorViewSize.height >= 0.0f);
    _incomingPhotoActivityIndicatorViewSize = CGSizeMake(ceil(incomingPhotoActivityIndicatorViewSize.width), ceilf(incomingPhotoActivityIndicatorViewSize.height));
}

- (void)setOutgoingPhotoActivityIndicatorViewSize:(CGSize)outgoingPhotoActivityIndicatorViewSize
{
    NSParameterAssert(outgoingPhotoActivityIndicatorViewSize.width >= 0.0f && outgoingPhotoActivityIndicatorViewSize.height >= 0.0f);
    _outgoingPhotoActivityIndicatorViewSize = CGSizeMake(ceil(outgoingPhotoActivityIndicatorViewSize.width), ceilf(outgoingPhotoActivityIndicatorViewSize.height));
}

- (void)setIncomingVideoActivityIndicatorViewSize:(CGSize)incomingVideoActivityIndicatorViewSize
{
    NSParameterAssert(incomingVideoActivityIndicatorViewSize.width >= 0.0f && incomingVideoActivityIndicatorViewSize.height >= 0.0f);
    _incomingVideoActivityIndicatorViewSize = CGSizeMake(ceil(incomingVideoActivityIndicatorViewSize.width), ceilf(incomingVideoActivityIndicatorViewSize.height));
}

- (void)setOutgoingVideoActivityIndicatorViewSize:(CGSize)outgoingVideoActivityIndicatorViewSize
{
    NSParameterAssert(outgoingVideoActivityIndicatorViewSize.width >= 0.0f && outgoingVideoActivityIndicatorViewSize.height >= 0.0f);
    _outgoingVideoActivityIndicatorViewSize = CGSizeMake(ceil(outgoingVideoActivityIndicatorViewSize.width), ceilf(outgoingVideoActivityIndicatorViewSize.height));
}

- (void)setIncomingAudioActivityIndicatorViewSize:(CGSize)incomingAudioActivityIndicatorViewSize
{
    NSParameterAssert(incomingAudioActivityIndicatorViewSize.width >= 0.0f && incomingAudioActivityIndicatorViewSize.height >= 0.0f);
    _incomingAudioActivityIndicatorViewSize = CGSizeMake(ceil(incomingAudioActivityIndicatorViewSize.width), ceilf(incomingAudioActivityIndicatorViewSize.height));
}

- (void)setOutgoingAudioActivityIndicatorViewSize:(CGSize)outgoingAudioActivityIndicatorViewSize
{
    NSParameterAssert(outgoingAudioActivityIndicatorViewSize.width >= 0.0f && outgoingAudioActivityIndicatorViewSize.height >= 0.0f);
    _outgoingAudioActivityIndicatorViewSize = CGSizeMake(ceil(outgoingAudioActivityIndicatorViewSize.width), ceilf(outgoingAudioActivityIndicatorViewSize.height));
}

- (void)setCellTopLabelHeight:(CGFloat)cellTopLabelHeight
{
    NSParameterAssert(cellTopLabelHeight >= 0.0f);
    _cellTopLabelHeight = floorf(cellTopLabelHeight);
}

- (void)setMessageBubbleTopLabelHeight:(CGFloat)messageBubbleTopLabelHeight
{
    NSParameterAssert(messageBubbleTopLabelHeight >= 0.0f);
    _messageBubbleTopLabelHeight = floorf(messageBubbleTopLabelHeight);
}

- (void)setCellBottomLabelHeight:(CGFloat)cellBottomLabelHeight
{
    NSParameterAssert(cellBottomLabelHeight >= 0.0f);
    _cellBottomLabelHeight = floorf(cellBottomLabelHeight);
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
    
    JSQMessagesCollectionViewLayoutAttributes *layoutAttributes = (JSQMessagesCollectionViewLayoutAttributes *)object;
    
    if (![layoutAttributes.messageBubbleFont isEqual:self.messageBubbleFont]
        || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.textViewFrameInsets, self.textViewFrameInsets)
        || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.textViewTextContainerInsets, self.textViewTextContainerInsets)
        || !CGSizeEqualToSize(layoutAttributes.incomingAvatarViewSize, self.incomingAvatarViewSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingAvatarViewSize, self.outgoingAvatarViewSize)
        || !CGSizeEqualToSize(layoutAttributes.incomingThumbnailImageSize, self.incomingThumbnailImageSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingThumbnailImageSize, self.outgoingThumbnailImageSize)
        || !CGSizeEqualToSize(layoutAttributes.incomingVideoThumbnailSize, self.incomingVideoThumbnailSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingVideoThumbnailSize, self.outgoingVideoThumbnailSize)
        || !CGSizeEqualToSize(layoutAttributes.incomingVideoOverlayViewSize, self.incomingVideoOverlayViewSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingVideoOverlayViewSize, self.outgoingVideoOverlayViewSize)
        || !CGSizeEqualToSize(layoutAttributes.incomingPhotoActivityIndicatorViewSize, self.incomingPhotoActivityIndicatorViewSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingPhotoActivityIndicatorViewSize, self.outgoingPhotoActivityIndicatorViewSize)
        || !CGSizeEqualToSize(layoutAttributes.incomingVideoActivityIndicatorViewSize, self.incomingVideoActivityIndicatorViewSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingVideoActivityIndicatorViewSize, self.outgoingVideoActivityIndicatorViewSize)
        || !CGSizeEqualToSize(layoutAttributes.incomingAudioActivityIndicatorViewSize, self.incomingAudioActivityIndicatorViewSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingAudioActivityIndicatorViewSize, self.outgoingAudioActivityIndicatorViewSize)
        || (int)layoutAttributes.messageBubbleLeftRightMargin != (int)self.messageBubbleLeftRightMargin
        || (int)layoutAttributes.cellTopLabelHeight != (int)self.cellTopLabelHeight
        || (int)layoutAttributes.messageBubbleTopLabelHeight != (int)self.messageBubbleTopLabelHeight
        || (int)layoutAttributes.cellBottomLabelHeight != (int)self.cellBottomLabelHeight) {
        return NO;
    }
    
    return [super isEqual:object];
}

- (NSUInteger)hash
{
    return [self.indexPath hash]
            ^ (NSUInteger)self.cellTopLabelHeight
            ^ (NSUInteger)self.messageBubbleTopLabelHeight
            ^ (NSUInteger)self.cellBottomLabelHeight;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQMessagesCollectionViewLayoutAttributes *copy = [super copyWithZone:zone];
    copy.messageBubbleFont = self.messageBubbleFont;
    copy.messageBubbleLeftRightMargin = self.messageBubbleLeftRightMargin;
    copy.textViewFrameInsets = self.textViewFrameInsets;
    copy.textViewTextContainerInsets = self.textViewTextContainerInsets;
    copy.incomingAvatarViewSize = self.incomingAvatarViewSize;
    copy.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    copy.incomingThumbnailImageSize = self.incomingThumbnailImageSize;
    copy.outgoingThumbnailImageSize = self.outgoingThumbnailImageSize;
    copy.incomingVideoThumbnailSize = self.incomingVideoThumbnailSize;
    copy.outgoingVideoThumbnailSize = self.outgoingVideoThumbnailSize;
    copy.incomingAudioPlayerViewSize = self.incomingAudioPlayerViewSize;
    copy.outgoingAudioPlayerViewSize = self.outgoingAudioPlayerViewSize;
    copy.incomingVideoOverlayViewSize = self.incomingVideoOverlayViewSize;
    copy.outgoingVideoOverlayViewSize = self.outgoingVideoOverlayViewSize;
    copy.incomingPhotoActivityIndicatorViewSize = self.incomingPhotoActivityIndicatorViewSize;
    copy.outgoingPhotoActivityIndicatorViewSize = self.outgoingPhotoActivityIndicatorViewSize;
    copy.incomingVideoActivityIndicatorViewSize = self.incomingVideoActivityIndicatorViewSize;
    copy.outgoingVideoActivityIndicatorViewSize = self.outgoingVideoActivityIndicatorViewSize;
    copy.incomingAudioActivityIndicatorViewSize = self.incomingAudioActivityIndicatorViewSize;
    copy.outgoingAudioActivityIndicatorViewSize = self.outgoingAudioActivityIndicatorViewSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    
    return copy;
}

@end
