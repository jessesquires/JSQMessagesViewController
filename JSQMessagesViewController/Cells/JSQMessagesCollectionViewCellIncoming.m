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

#import "JSQMessagesCollectionViewCellIncoming.h"

@implementation JSQMessagesCollectionViewCellIncoming

#pragma mark - Overrides

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesCollectionViewCellIncoming class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([JSQMessagesCollectionViewCellIncoming class]);
}

@end
