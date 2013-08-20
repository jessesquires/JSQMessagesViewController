//
//  UIButton+JSMessagesView.m
//  MessagesDemo
//
//  Created by Jesse Squires on 3/24/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "UIButton+JSMessagesView.h"
#import "JSMessageInputView.h"

@implementation UIButton (JSMessagesView)

+ (UIButton *)defaultSendButton
{
    UIButton *sendButton;
    
    if ([JSMessageInputView inputBarStyle] == JSInputBarStyleFlat)
    {
        sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    else
    {
        sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 13.0f, 0.0f, 13.0f);
        UIImage *sendBack = [[UIImage imageNamed:@"send"] resizableImageWithCapInsets:insets];
        UIImage *sendBackHighLighted = [[UIImage imageNamed:@"send-highlighted"] resizableImageWithCapInsets:insets];
        [sendButton setBackgroundImage:sendBack forState:UIControlStateNormal];
        [sendButton setBackgroundImage:sendBack forState:UIControlStateDisabled];
        [sendButton setBackgroundImage:sendBackHighLighted forState:UIControlStateHighlighted];
        
        sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        
        UIColor *titleShadow = [UIColor colorWithRed:0.325f green:0.463f blue:0.675f alpha:1.0f];
        [sendButton setTitleShadowColor:titleShadow forState:UIControlStateNormal];
        [sendButton setTitleShadowColor:titleShadow forState:UIControlStateHighlighted];
        sendButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
        
        [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [sendButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    }
    
    NSString *title = NSLocalizedString(@"Send", nil);
    [sendButton setTitle:title forState:UIControlStateNormal];
    [sendButton setTitle:title forState:UIControlStateHighlighted];
    [sendButton setTitle:title forState:UIControlStateDisabled];
    sendButton.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin);
    
    return sendButton;
}

@end