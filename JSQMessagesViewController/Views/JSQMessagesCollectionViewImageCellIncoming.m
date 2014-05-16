//
//  JSQMessagesCollectionViewImageCellIncoming.m
//  SquadUp
//
//  Created by Adam Cumiskey on 4/24/14.
//  Copyright (c) 2014 JAKT. All rights reserved.
//

#import "JSQMessagesCollectionViewImageCellIncoming.h"

@implementation JSQMessagesCollectionViewImageCellIncoming

#pragma mark - Overrides

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesCollectionViewImageCellIncoming class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([JSQMessagesCollectionViewImageCellIncoming class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentLeft;
    self.cellBottomLabel.textAlignment = NSTextAlignmentLeft;
}

@end

