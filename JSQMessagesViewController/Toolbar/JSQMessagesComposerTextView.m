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

#import "JSQMessagesComposerTextView.h"


@interface JSQMessagesComposerTextView ()

@end



@implementation JSQMessagesComposerTextView

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGFloat cornerRadius = 6.0f;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = cornerRadius;
    
    self.scrollIndicatorInsets = UIEdgeInsetsMake(cornerRadius, 0.0f, cornerRadius, 0.0f);
    
    self.textContainerInset = UIEdgeInsetsMake(4.0f, 2.0f, 4.0f, 2.0f);
    self.contentInset = UIEdgeInsetsMake(2.0f, 0.0f, 2.0f, 0.0f);
    
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;
    
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentLeft;
    
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;
    
    self.text = nil;
}

@end
