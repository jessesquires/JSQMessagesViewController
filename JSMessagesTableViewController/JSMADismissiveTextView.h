//
//  MADismissiveTextView.h
//  MADismissiveTextView
//
//  Created by Mike Ahmarani on 12-02-18.
//  Copyright (c) 2012 Mike Ahmarani. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MADismissiveKeyboardDelegate <NSObject>

@optional
- (void)keyboardDidShow;
- (void)keyboardDidScroll:(CGPoint)keyboardOrigin;
- (void)keyboardWillBeDismissed;
- (void)keyboardWillSnapBackTo:(CGPoint)keyboardOrigin;
@end

@interface JSMADismissiveTextView : UITextView

@property (nonatomic, weak) id <MADismissiveKeyboardDelegate> keyboardDelegate;
@property (nonatomic, strong) UIPanGestureRecognizer *dismissivePanGestureRecognizer;

@end
