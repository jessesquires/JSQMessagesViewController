//
//  JSQMessagesCollectionViewCellIncomingMedia.m
//  JSQMessages
//
//  Created by Pierluigi Cifani on 17/6/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellIncomingMedia.h"

@implementation JSQMessagesCollectionViewCellIncomingMedia

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesCollectionViewCellIncomingMedia class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier;
{
    return NSStringFromClass([JSQMessagesCollectionViewCellIncomingMedia class]);
}

#pragma mark - Initialization

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.mediaHandler = [JSQMessagesMediaHandler mediaHandlerWithCell:self];
}

@end
