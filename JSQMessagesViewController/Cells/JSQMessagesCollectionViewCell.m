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

#import "JSQMessagesCollectionViewCell.h"

@implementation JSQMessagesCollectionViewCell

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
}

#pragma mark - Class methods

+ (UINib *)nib
{
    return nil;
}

+ (NSString *)cellReuseIdentifier
{
    return nil;
}

@end
