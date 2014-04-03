//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQMessagesCollectionViewLayoutAttributes.h"


@implementation JSQMessagesCollectionViewLayoutAttributes

#pragma mark - Lifecycle

- (void)dealloc
{
    _messageBubbleFont = nil;
}

#pragma mark - Setters

- (void)setMessageBubbleLeftRightMargin:(CGFloat)messageBubbleLeftRightMargin
{
    _messageBubbleLeftRightMargin = ceilf(messageBubbleLeftRightMargin);
}

- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    _incomingAvatarViewSize = CGSizeMake(ceil(incomingAvatarViewSize.width), ceilf(incomingAvatarViewSize.height));
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    _outgoingAvatarViewSize = CGSizeMake(ceil(outgoingAvatarViewSize.width), ceilf(outgoingAvatarViewSize.height));
}

- (void)setCellTopLabelHeight:(CGFloat)cellTopLabelHeight
{
    _cellTopLabelHeight = floorf(cellTopLabelHeight);
}

- (void)setMessageBubbleTopLabelHeight:(CGFloat)messageBubbleTopLabelHeight
{
    _messageBubbleTopLabelHeight = floorf(messageBubbleTopLabelHeight);
}

- (void)setCellBottomLabelHeight:(CGFloat)cellBottomLabelHeight
{
    _cellBottomLabelHeight = floorf(cellBottomLabelHeight);
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    JSQMessagesCollectionViewLayoutAttributes *layoutAttributes = (JSQMessagesCollectionViewLayoutAttributes *)object;
    
    if ([layoutAttributes.messageBubbleFont isEqual:self.messageBubbleFont]
        || layoutAttributes.messageBubbleLeftRightMargin != self.messageBubbleLeftRightMargin
        || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.messageBubbleTextContainerInsets, self.messageBubbleTextContainerInsets)
        || !CGSizeEqualToSize(layoutAttributes.incomingAvatarViewSize, self.incomingAvatarViewSize)
        || !CGSizeEqualToSize(layoutAttributes.outgoingAvatarViewSize, self.outgoingAvatarViewSize)
        || layoutAttributes.cellTopLabelHeight != self.cellTopLabelHeight
        || layoutAttributes.messageBubbleTopLabelHeight != self.messageBubbleTopLabelHeight
        || layoutAttributes.cellBottomLabelHeight != self.cellBottomLabelHeight) {
        return NO;
    }
    
    return [super isEqual:object];
}

- (NSUInteger)hash
{
    NSUInteger customHash = [self.messageBubbleFont hash]
                            ^ (int)self.messageBubbleLeftRightMargin
                            ^ (int)(self.incomingAvatarViewSize.width + self.incomingAvatarViewSize.height)
                            ^ (int)(self.outgoingAvatarViewSize.width + self.outgoingAvatarViewSize.height)
                            ^ (int)self.cellTopLabelHeight
                            ^ (int)self.messageBubbleTopLabelHeight
                            ^ (int)self.cellBottomLabelHeight;
    
    return [super hash] ^ customHash;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQMessagesCollectionViewLayoutAttributes *copy = [super copyWithZone:zone];
    copy.messageBubbleFont = self.messageBubbleFont;
    copy.messageBubbleLeftRightMargin = self.messageBubbleLeftRightMargin;
    copy.messageBubbleTextContainerInsets = self.messageBubbleTextContainerInsets;
    copy.incomingAvatarViewSize = self.incomingAvatarViewSize;
    copy.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    return copy;
}

@end
