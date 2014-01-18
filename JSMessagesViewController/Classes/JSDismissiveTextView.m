//
//  Taken from MADismissiveTextView
//  https://github.com/mikeahmarani/MADismissiveTextView
//
//  Created by Mike Ahmarani on 12-02-18.
//  Copyright (c) 2012 Mike Ahmarani. All rights reserved.
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

#import "JSDismissiveTextView.h"

@interface JSDismissiveTextView ()

@property (strong, nonatomic) UIView *keyboardView;
@property (assign, nonatomic) CGFloat previousKeyboardY;

- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification;
- (void)handlePanGesture:(UIPanGestureRecognizer *)pan;

@end



@implementation JSDismissiveTextView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.editable = YES;
        
        // FIXME: this is a hack
        // ---------------------
        // init an empty inputAccessoryView to get a reference to the keyboard when it appears
        // i.e., self.inputAccessoryView.superview <-- the keyboard (see notification handler below)
        // otherwise self.inputAccessoryView == nil, thus self.inputAccessoryView.superivew == nil
        // ---------------------
        // Can you fix this? Submit a PR! :)
        self.inputAccessoryView = [[UIView alloc] init];
        
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
    [_dismissivePanGestureRecognizer removeTarget:self action:@selector(handlePanGesture:)];
    _dismissivePanGestureRecognizer = nil;
    _keyboardDelegate = nil;
    _keyboardView = nil;
}

#pragma mark - Setters

- (void)setDismissivePanGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    _dismissivePanGestureRecognizer = pan;
    [_dismissivePanGestureRecognizer addTarget:self action:@selector(handlePanGesture:)];
}

#pragma mark - Notifications

- (void)handleKeyboardWillShowHideNotification:(NSNotification *)notification
{
    if([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        self.keyboardView.hidden = NO;
    }
    else if([notification.name isEqualToString:UIKeyboardDidShowNotification]) {
        self.keyboardView = self.inputAccessoryView.superview;
        self.keyboardView.hidden = NO;
        
        if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidShow)])
            [self.keyboardDelegate keyboardDidShow];
    }
    else if([notification.name isEqualToString:UIKeyboardDidHideNotification]) {
        self.keyboardView.hidden = NO;
        
        BOOL isPhone = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
        BOOL keyBoardWasSplitOnPad = [[notification userInfo][@"UIKeyboardFrameChangedByUserInteraction"] boolValue];
        
        if(isPhone || keyBoardWasSplitOnPad) {
            [self resignFirstResponder];
        }
    }
}

#pragma mark - Gestures

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan
{
    if(!self.keyboardView || self.keyboardView.hidden)
        return;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    UIWindow *panWindow = [[UIApplication sharedApplication] keyWindow];
    CGPoint location = [pan locationInView:panWindow];
    CGPoint velocity = [pan velocityInView:panWindow];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.previousKeyboardY = self.keyboardView.frame.origin.y;
            break;
        case UIGestureRecognizerStateEnded:
            if(velocity.y > 0 && self.keyboardView.frame.origin.y > self.previousKeyboardY) {
                
                [UIView animateWithDuration:0.3
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     self.keyboardView.frame = CGRectMake(0.0f,
                                                                          screenHeight,
                                                                          self.keyboardView.frame.size.width,
                                                                          self.keyboardView.frame.size.height);
                                     
                                     if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillBeDismissed)])
                                         [self.keyboardDelegate keyboardWillBeDismissed];
                                 }
                                 completion:^(BOOL finished) {
                                     self.keyboardView.hidden = YES;
                                     self.keyboardView.frame = CGRectMake(0.0f,
                                                                          self.previousKeyboardY,
                                                                          self.keyboardView.frame.size.width,
                                                                          self.keyboardView.frame.size.height);
                                     [self resignFirstResponder];
                                 }];
            }
            else {
                // gesture ended with no flick or a flick upwards, snap keyboard back to original position
                [UIView animateWithDuration:0.2
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillSnapBackToPoint:)]) {
                                         [self.keyboardDelegate keyboardWillSnapBackToPoint:CGPointMake(0.0f, self.previousKeyboardY)];
                                     }
                                     
                                     self.keyboardView.frame = CGRectMake(0.0f,
                                                                          self.previousKeyboardY,
                                                                          self.keyboardView.frame.size.width,
                                                                          self.keyboardView.frame.size.height);
                                 }
                                 completion:nil];
            }
            break;
        
        default:
            // gesture is currently panning, match keyboard y to touch y
            if(location.y > self.keyboardView.frame.origin.y || self.keyboardView.frame.origin.y != self.previousKeyboardY) {
                
                CGFloat newKeyboardY = self.previousKeyboardY + (location.y - self.previousKeyboardY);
                newKeyboardY = newKeyboardY < self.previousKeyboardY ? self.previousKeyboardY : newKeyboardY;
                newKeyboardY = newKeyboardY > screenHeight ? screenHeight : newKeyboardY;
                
                self.keyboardView.frame = CGRectMake(0.0f,
                                                     newKeyboardY,
                                                     self.keyboardView.frame.size.width,
                                                     self.keyboardView.frame.size.height);
                
                if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidScrollToPoint:)])
                    [self.keyboardDelegate keyboardDidScrollToPoint:CGPointMake(0.0f, newKeyboardY)];
            }
            break;
    }
}

@end
