//
//  MADismissiveTextView.m
//  MADismissiveTextView
//
//  Created by Mike Ahmarani on 12-02-18.
//  Copyright (c) 2012 Mike Ahmarani. All rights reserved.
//

#import "JSMADismissiveTextView.h"

@interface JSMADismissiveTextView ()

@property (nonatomic, strong) UIView *keyboard;
@property (nonatomic, readwrite) float originalKeyboardY; 

- (void)keyboardWillShow;
- (void)keyboardDidShow;
- (void)panning:(UIPanGestureRecognizer *)pan;

@end

@implementation JSMADismissiveTextView

@synthesize keyboard, dismissivePanGestureRecognizer, originalKeyboardY, keyboardDelegate;

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];    
    [self.dismissivePanGestureRecognizer removeTarget:self action:@selector(panning:)];
    self.dismissivePanGestureRecognizer = nil;    
    self.keyboardDelegate = nil;    
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.editable = YES;
        self.inputAccessoryView = [[UIView alloc] init]; //Empty view, used to get a handle on the keyboard when it appears.       
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:@"UIKeyboardWillShowNotification" object:nil];                
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:@"UIKeyboardDidShowNotification" object:nil];
        
    }
    return self;
}

- (void)setDismissivePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
    dismissivePanGestureRecognizer = panGestureRecognizer;
    [dismissivePanGestureRecognizer addTarget:self action:@selector(panning:)];
}

- (void)keyboardWillShow{
    self.keyboard.hidden = NO;
}

- (void)keyboardDidShow{
    self.keyboard = self.inputAccessoryView.superview;
    if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidShow)]){
        [self.keyboardDelegate keyboardDidShow];
    }
}

- (void)panning:(UIPanGestureRecognizer *)pan{
    
    if(self.keyboard && !self.keyboard.hidden){
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenHeight = screenRect.size.height;
        
        
        UIWindow *panWindow = [[UIApplication sharedApplication] keyWindow];
        CGPoint location = [pan locationInView:panWindow];
        CGPoint velocity = [pan velocityInView:panWindow];
        
        if(pan.state == UIGestureRecognizerStateBegan){ //Gesture begining, grab origin of keyboard frame.
            
            self.originalKeyboardY = self.keyboard.frame.origin.y;
            
        }else if(pan.state == UIGestureRecognizerStateEnded){ //Gesture ending, complete animation of keyboard
            
            if(velocity.y > 0 && self.keyboard.frame.origin.y > self.originalKeyboardY){ //Gesture ended with a flick downwards, dismiss keyboard.
                
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.keyboard.frame = CGRectMake(0, screenHeight, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                    if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillBeDismissed)]){
                        [self.keyboardDelegate keyboardWillBeDismissed];
                    }
                }completion:^(BOOL finished){
                    self.keyboard.hidden = YES;
                    self.keyboard.frame = CGRectMake(0, self.originalKeyboardY, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                    [self resignFirstResponder];                          
                }];
                
            }else{ //Gesture ended with no flick or a flick upwards, snap keyboard back to original position.
                
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardWillSnapBackTo:)]){
                        [self.keyboardDelegate keyboardWillSnapBackTo:CGPointMake(0, self.originalKeyboardY)];
                    }
                    self.keyboard.frame = CGRectMake(0, self.originalKeyboardY, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                } completion:^(BOOL finished){
                }];
                
            }
            
        }else{ //Gesture is currently panning, match keyboard y to touch y.
            
            if(location.y > self.keyboard.frame.origin.y || self.keyboard.frame.origin.y != self.originalKeyboardY){
                
                float newKeyboardY = self.originalKeyboardY + (location.y-self.originalKeyboardY);
                newKeyboardY = newKeyboardY < self.originalKeyboardY ? self.originalKeyboardY:newKeyboardY;
                newKeyboardY = newKeyboardY > screenHeight ? screenHeight :newKeyboardY;
            
                self.keyboard.frame = CGRectMake(0, newKeyboardY, self.keyboard.frame.size.width, self.keyboard.frame.size.height);
                
                if(self.keyboardDelegate && [self.keyboardDelegate respondsToSelector:@selector(keyboardDidScroll:)]){
                    [self.keyboardDelegate keyboardDidScroll:CGPointMake(0, newKeyboardY)];
                }
                
            }
            
        }
    }
}

@end
