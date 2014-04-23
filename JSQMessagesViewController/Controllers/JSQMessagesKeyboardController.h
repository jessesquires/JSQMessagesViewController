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
//
//
//  Ideas for keyboard controller taken from Daniel Amitay
//  DAKeyboardControl
//
//  The MIT License
//  Copyright (c) 2012 Daniel Amitay
//  https://github.com/danielamitay/DAKeyboardControl
//

#import <Foundation/Foundation.h>

/**
 *  The `JSQMessagesKeyboardControllerDelegate` protocol defines methods that 
 *  allow you to respond to the frame change events of the system keyboard.
 */
@protocol JSQMessagesKeyboardControllerDelegate <NSObject>

@required

/**
 *  Tells the delegate that the keyboard frame has changed.
 *
 *  @param keyboardFrame The new (current) frame of the keyboard.
 */
- (void)keyboardDidChangeFrame:(CGRect)keyboardFrame;

@end


/**
 *  An instance of `JSQMessagesKeyboardController` manages responding to the hiding and showing 
 *  of the system keyboard for editing its `textView` within its specified `contextView`. It also controls user interaction with
 *  the system keyboard via its `panGestureRecognizer`, allow the user to interactively pan the keyboard up and down in the `contextView`.
 */
@interface JSQMessagesKeyboardController : NSObject

/**
 *  The object that acts as the delegate of the keyboard controller.
 */
@property (weak, nonatomic) id<JSQMessagesKeyboardControllerDelegate> delegate;

/**
 *  The text view in which the user is editing with the system keyboard.
 */
@property (weak, nonatomic, readonly) UITextView *textView;

/**
 *  The view in which the keyboard will be shown. This should be the parent or a sibling of `textView`.
 */
@property (weak, nonatomic, readonly) UIView *contextView;

/**
 *  The pan gesture recognizer responsible for handling user interaction with the system keyboard.
 */
@property (weak, nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer;

/**
 *  Specifies the point in the `contextView` at which the `panGestureRecognizer` 
 *  should trigger user interaction with the keyboard by panning.
 */
@property (assign, nonatomic) CGPoint keyboardTriggerPoint;

/**
 *  Creates a new keyboard controller object with the specified textView, contextView, panGestureRecognizer, and delegate.
 *
 *  @param textView             The text view in which the user is editing with the system keyboard. 
 *                              This value must not be `nil`.
 *  @param contextView          The view in which the keyboard will be shown. This should be the parent or a sibling of `textView`. 
                                This value must not be `nil`.
 *  @param panGestureRecognizer The pan gesture recognizer responsible for handling user interaction with the system keyboard.
                                This value must not be `nil`.
 *  @param delegate             The object that acts as the delegate of the keyboard controller.
 *
 *  @return An initialized `JSQMessagesKeyboardController` if created successfully, `nil` otherwise.
 */
- (instancetype)initWithTextView:(UITextView *)textView
                     contextView:(UIView *)contextView
            panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
                        delegate:(id<JSQMessagesKeyboardControllerDelegate>)delegate;

/**
 *  Tells the keyboard controller that it should begin listening for system keyboard notifications.
 */
- (void)beginListeningForKeyboard;

/**
 *  Tells the keyboard controller that it should end listening for system keyboard notifications.
 */
- (void)endListeningForKeyboard;

@end
