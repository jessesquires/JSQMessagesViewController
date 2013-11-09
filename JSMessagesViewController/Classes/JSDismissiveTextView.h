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

#import <UIKit/UIKit.h>

@protocol JSDismissiveTextViewDelegate <NSObject>

@optional
- (void)keyboardDidShow;
- (void)keyboardDidScrollToPoint:(CGPoint)point;
- (void)keyboardWillBeDismissed;
- (void)keyboardWillSnapBackToPoint:(CGPoint)point;

@end



@interface JSDismissiveTextView : UITextView

@property (weak, nonatomic) id<JSDismissiveTextViewDelegate> keyboardDelegate;
@property (strong, nonatomic) UIPanGestureRecognizer *dismissivePanGestureRecognizer;

@end
