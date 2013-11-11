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

/**
 *  The delegate of a `JSDismissiveTextView` object must adopt the `JSDismissiveTextViewDelegate` protocol.
 */
@protocol JSDismissiveTextViewDelegate <NSObject>

@optional
/**
 *  Tells the delegate that the keyboard has full appeared on screen.
 */
- (void)keyboardDidShow;

/**
 *  Tells the delegate that the keyboard origin has moved to the specified point.
 *
 *  @param point The origin of the keyboard's frame in its superview's coordinate system.
 */
- (void)keyboardDidScrollToPoint:(CGPoint)point;

/**
 *  Tells the delegate that the keyboard is about to be dismissed. The keyboard will be removed from from its superview and resign first responder.
 */
- (void)keyboardWillBeDismissed;

/**
 *  Tells the delegate that the keyboard origin is about to move back to the specified point.
 *
 *  @param point The new origin of the keyboard's frame after it has completed animation.
 */
- (void)keyboardWillSnapBackToPoint:(CGPoint)point;

@end


/**
 *  An instance of `JSDismissiveTextView` is a means for displaying a text view that is contained as a subview of the keyboard's `inputAccessoryView` and responds to a pan gesture to dismiss the keyboard and end editing.
 */
@interface JSDismissiveTextView : UITextView

/**
 *  The object that acts as the delegate of the receiving text view.
 */
@property (weak, nonatomic) id<JSDismissiveTextViewDelegate> keyboardDelegate;

/**
 *  The pan gesture recognizer for the text view.
 */
@property (strong, nonatomic) UIPanGestureRecognizer *dismissivePanGestureRecognizer;

@end
