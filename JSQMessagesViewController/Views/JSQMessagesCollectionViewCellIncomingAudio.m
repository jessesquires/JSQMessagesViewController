//
//  JSQMessagesCollectionViewCellIncomingAudio.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellIncomingAudio.h"

@implementation JSQMessagesCollectionViewCellIncomingAudio

#pragma mark - Overrides

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
