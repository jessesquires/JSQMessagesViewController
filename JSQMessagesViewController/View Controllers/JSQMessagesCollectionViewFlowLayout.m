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

#import "JSQMessagesCollectionViewFlowLayout.h"


@interface JSQMessagesCollectionViewFlowLayout ()

@end



@implementation JSQMessagesCollectionViewFlowLayout

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

@end
