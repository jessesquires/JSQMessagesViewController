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

#pragma mark - Setters

- (void)setMessageBubbleHorizontalPadding:(CGFloat)messageBubbleHorizontalPadding
{
    _messageBubbleHorizontalPadding = ceilf(messageBubbleHorizontalPadding);
}

- (void)setAvatarViewSize:(CGSize)avatarViewSize
{
    _avatarViewSize = CGSizeMake(ceil(avatarViewSize.width), ceilf(avatarViewSize.height));
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
        || layoutAttributes.messageBubbleHorizontalPadding != self.messageBubbleHorizontalPadding
        || !UIEdgeInsetsEqualToEdgeInsets(layoutAttributes.messageBubbleTextContainerInsets, self.messageBubbleTextContainerInsets)
        || !CGSizeEqualToSize(layoutAttributes.avatarViewSize, self.avatarViewSize)
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
                            ^ (int)self.messageBubbleHorizontalPadding
                            ^ (int)(self.avatarViewSize.width + self.avatarViewSize.height)
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
    copy.messageBubbleHorizontalPadding = self.messageBubbleHorizontalPadding;
    copy.messageBubbleTextContainerInsets = self.messageBubbleTextContainerInsets;
    copy.avatarViewSize = self.avatarViewSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    return copy;
}

@end
