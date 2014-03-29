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

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    JSQMessagesCollectionViewLayoutAttributes *layoutAttributes = (JSQMessagesCollectionViewLayoutAttributes *)object;
    
    if (!CGSizeEqualToSize(layoutAttributes.messageBubbleSize, self.messageBubbleSize)
        || layoutAttributes.cellTopLabelHeight != self.cellTopLabelHeight
        || layoutAttributes.messageBubbleTopLabelHeight != self.messageBubbleTopLabelHeight
        || layoutAttributes.cellBottomLabelHeight != self.cellBottomLabelHeight) {
        return NO;
    }
    
    return [super isEqual:object];
}

- (NSUInteger)hash
{
    NSUInteger customHash = self.cellTopLabelHeight ^ self.messageBubbleTopLabelHeight ^ self.cellBottomLabelHeight;
    customHash ^= ( (int)self.messageBubbleSize.width ^ (int)self.messageBubbleSize.height );
    return [super hash] ^ customHash;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQMessagesCollectionViewLayoutAttributes *copy = [super copyWithZone:zone];
    copy.messageBubbleSize = self.messageBubbleSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    return copy;
}

@end
