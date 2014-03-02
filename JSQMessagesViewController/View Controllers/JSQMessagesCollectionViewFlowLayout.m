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

- (void)jsq_configureFlowLayout;

@end



@implementation JSQMessagesCollectionViewFlowLayout

#pragma mark - Initialization

- (void)jsq_configureFlowLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jsq_configureFlowLayout];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self jsq_configureFlowLayout];
    }
    return self;
}

@end
