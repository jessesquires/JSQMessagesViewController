//
//  JSQMessagesCollectionViewImageCellOutgoing.m
//  SquadUp
//
//  Created by Adam Cumiskey on 4/24/14.
//  Copyright (c) 2014 JAKT. All rights reserved.
//

#import "JSQMessagesCollectionViewImageCellOutgoing.h"

@implementation JSQMessagesCollectionViewImageCellOutgoing

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesCollectionViewImageCellOutgoing class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([JSQMessagesCollectionViewImageCellOutgoing class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentRight;
    self.cellBottomLabel.textAlignment = NSTextAlignmentRight;
}

@end
