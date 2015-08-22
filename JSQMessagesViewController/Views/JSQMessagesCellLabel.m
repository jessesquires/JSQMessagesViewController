//
// Created by Ivan Vavilov
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <CoreGraphics/CoreGraphics.h>
#import "JSQMessagesCellLabel.h"

@implementation JSQMessagesCellLabel

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }

    return self;
}

- (void)initialize
{
    self.textColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Setter

- (void)setText:(id)text
{
    [super setText:text];
}


@end