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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSMessageTextView.h"
#import "JSBubbleView.h"

@implementation JSMessageTextView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor whiteColor];
        self.scrollIndicatorInsets = UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f);
        self.contentInset = UIEdgeInsetsZero;
        self.scrollEnabled = YES;
        self.scrollsToTop = NO;
        self.userInteractionEnabled = YES;
        self.font = [UIFont systemFontOfSize:16.0f];
        self.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
        self.keyboardType = UIKeyboardTypeDefault;
        self.returnKeyType = UIReturnKeyDefault;
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

#pragma mark - Text view

- (NSUInteger)numberOfLinesOfText
{
    return [JSMessageTextView numberOfLinesForMessage:self.text];
}

+ (NSUInteger)maxCharactersPerLine
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 33 : 109;
}

+ (NSUInteger)numberOfLinesForMessage:(NSString *)text
{
    return (text.length / [JSMessageTextView maxCharactersPerLine]) + 1;
}

@end
