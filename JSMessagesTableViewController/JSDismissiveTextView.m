//
//  JSDismissiveTextView.m
//
//  Taken from MADismissiveTextView
//  https://github.com/mikeahmarani/MADismissiveTextView
//
//  Created by Mike Ahmarani on 12-02-18.
//  Copyright (c) 2012 Mike Ahmarani. All rights reserved.
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "JSDismissiveTextView.h"

@interface JSDismissiveTextView ()

@property (strong, nonatomic) UIView *keyboard;
@property (assign, nonatomic) CGFloat originalKeyboardY;

- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification;
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan;

@end



@implementation JSDismissiveTextView

@synthesize dismissivePanGestureRecognizer;

#pragma mark - Initialization
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.editable = YES;
        self.inputAccessoryView = [[UIView alloc] init]; // empty view to get a handle on the keyboard when it appears
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardWillShowHideNotification:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardWillShowHideNotification:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleKeyboardWillShowHideNotification:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.dismissivePanGestureRecognizer removeTarget:self action:@selector(panning:)];
    self.dismissivePanGestureRecognizer = nil;
    self.keyboardDelegate = nil;
}

#pragma mark - Setters
- (void)setDismissivePanGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    dismissivePanGestureRecognizer = pan;
    [dismissivePanGestureRecognizer addTarget:self action:@selector(handlePanGesture:)];
}

#pragma mark - Notifications
- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        self.keyboard.hidden = NO;
    }
    else if([notification.name isEqualToString:UIKeyboardDidShowNotification]) {
        self.keyboard = self.inputAccessoryView.superview;
        self.keyboard.hidden = NO;
        
        if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidShow)])
            [self.keyboardDelegate keyboardDidShow];
    }
    else if([notification.name isEqualToString:UIKeyboardDidHideNotification]) {
        self.keyboard.hidden = NO;
        [self resignFirstResponder];
    }
}

#pragma mark - Gestures
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    if(!self.keyboard || self.keyboard.hidden)
        return;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    UIWindow *panWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint location = [pan locationInView:panWindow];
    CGPoint velocity = [pan velocityInView:panWindow];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.originalKeyboardY = self.keyboard.frame.origin.y;
            break;
        case UIGestureRecognizerStateEnded:
            if(velocity.y > 0 && self.keyboard.frame.origin.y > self.originalKeyboardY) {
                
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     self.keyboard.frame = CGRectMake(0.0f,
                                                                      screenHeight,
                                                                      self.keyboard.frame.size.width,
                                                                      self.keyboard.frame.size.height);
                                     
                                     if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillBeDismissed)])
                                         [self.keyboardDelegate keyboardWillBeDismissed];
                                 }
                                 completion:^(BOOL finished) {
                                     self.keyboard.hidden = YES;
                                     self.keyboard.frame = CGRectMake(0.0f,
                                                                      self.originalKeyboardY,
                                                                      self.keyboard.frame.size.width,
                                                                      self.keyboard.frame.size.height);
                                     [self resignFirstResponder];
                                 }];
            }
            else { // gesture ended with no flick or a flick upwards, snap keyboard back to original position
                [UIView animateWithDuration:0.2
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillSnapBackToPoint:)]) {
                                         [self.keyboardDelegate keyboardWillSnapBackToPoint:CGPointMake(0.0f, self.originalKeyboardY)];
                                     }
                                     
                                     self.keyboard.frame = CGRectMake(0.0f,
                                                                      self.originalKeyboardY,
                                                                      self.keyboard.frame.size.width,
                                                                      self.keyboard.frame.size.height);
                                 }
                                 completion:^(BOOL finished){
                                 }];
            }
            break;
        
        // gesture is currently panning, match keyboard y to touch y
        default:
            if(location.y > self.keyboard.frame.origin.y || self.keyboard.frame.origin.y != self.originalKeyboardY) {
                
                CGFloat newKeyboardY = self.originalKeyboardY + (location.y - self.originalKeyboardY);
                newKeyboardY = newKeyboardY < self.originalKeyboardY ? self.originalKeyboardY : newKeyboardY;
                newKeyboardY = newKeyboardY > screenHeight ? screenHeight : newKeyboardY;
                
                self.keyboard.frame = CGRectMake(0.0f,
                                                 newKeyboardY,
                                                 self.keyboard.frame.size.width,
                                                 self.keyboard.frame.size.height);
                
                if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidScrollToPoint:)])
                    [self.keyboardDelegate keyboardDidScrollToPoint:CGPointMake(0.0f, newKeyboardY)];
            }
            break;
    }
}

@end
