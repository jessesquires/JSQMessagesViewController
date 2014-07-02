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
    _incomingVideoOverlayView = nil;
    _outgoingVideoOverlayView = nil;
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

- (void)setIncomingMediaImageSize:(CGSize)incomingMediaImageSize {
    NSParameterAssert(incomingMediaImageSize.width >= 0.0f && incomingMediaImageSize.height >= 0.0f);
    _incomingMediaImageSize = CGSizeMake(ceil(incomingMediaImageSize.width), ceilf(incomingMediaImageSize.height));;
}

- (void)setOutgoingMediaImageSize:(CGSize)outgoingMediaImageSize {
    NSParameterAssert(outgoingMediaImageSize.width >= 0.0f && outgoingMediaImageSize.height >= 0.0f);
    _outgoingMediaImageSize = CGSizeMake(ceil(outgoingMediaImageSize.width), ceilf(outgoingMediaImageSize.height));;
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

- (void)setIncomingVideoOverlayView:(UIView *)incomingVideoOverlayView
{
    _incomingVideoOverlayView = incomingVideoOverlayView;
}

- (void)setOutgoingVideoOverlayView:(UIView *)outgoingVideoOverlayView
{
    _outgoingVideoOverlayView = outgoingVideoOverlayView;
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
        || !CGSizeEqualToSize(layoutAttributes.incomingMediaImageSize, self.incomingMediaImageSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingMediaImageSize, self.outgoingMediaImageSize)
        || ![layoutAttributes.incomingVideoOverlayView isEqual:self.incomingVideoOverlayView]
        || ![layoutAttributes.outgoingVideoOverlayView isEqual:self.outgoingVideoOverlayView]
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
    copy.incomingMediaImageSize = self.incomingMediaImageSize;
    copy.outgoingMediaImageSize = self.outgoingMediaImageSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    copy.incomingVideoOverlayView = self.incomingVideoOverlayView;
    copy.outgoingVideoOverlayView = self.outgoingVideoOverlayView;
    
    return copy;
}

@end
