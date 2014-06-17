//
//  JSQMessagesCollectionViewCellOutgoingMedia.m
//  JSQMessages
//
//  Created by Pierluigi Cifani on 17/6/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellOutgoingMedia.h"

@implementation JSQMessagesCollectionViewCellOutgoingMedia

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesCollectionViewCellOutgoingMedia class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier;
{
    return NSStringFromClass([JSQMessagesCollectionViewCellOutgoingMedia class]);
}

#pragma mark - Initialization

- (void) awakeFromNib
{
    [super awakeFromNib];

    self.mediaHandler = [JSQMessagesMediaHandler mediaHandlerWithCell:self];
}

@end
