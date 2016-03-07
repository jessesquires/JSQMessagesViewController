//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//
//
//  Ideas for keyboard controller taken from Daniel Amitay
//  DAKeyboardControl
//  https://github.com/danielamitay/DAKeyboardControl
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JSQMessagesKeyboardController;

/**
 *  Posted when the system keyboard frame changes.
 *  The object of the notification is the `JSQMessagesKeyboardController` object. 
 *  The `userInfo` dictionary contains the new keyboard frame for key
 *  `JSQMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame`.
 */
FOUNDATION_EXPORT NSString * const JSQMessagesKeyboardControllerNotificationKeyboardDidChangeFrame;

/**
 *  Contains the new keyboard frame wrapped in an `NSValue` object.
 */
FOUNDATION_EXPORT NSString * const JSQMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame;


/**
 *  The `JSQMessagesKeyboardControllerDelegate` protocol defines methods that 
 *  allow you to respond to the frame change events of the system keyboard.
 *
 *  A `JSQMessagesKeyboardController` object also posts the `JSQMessagesKeyboardControllerNotificationKeyboardDidChangeFrame`
 *  in response to frame change events of the system keyboard.
 */
@protocol JSQMessagesKeyboardControllerDelegate <NSObject>

@required

/**
 *  Tells the delegate that the keyboard frame has changed.
 *
 *  @param keyboardController The keyboard controller that is notifying the delegate.
 *  @param keyboardFrame      The new frame of the keyboard in the coordinate system of the `contextView`.
 */
- (void)keyboardController:(JSQMessagesKeyboardController *)keyboardController keyboardDidChangeFrame:(CGRect)keyboardFrame;

@end


/**
 *  An instance of `JSQMessagesKeyboardController` manages responding to the hiding and showing 
 *  of the system keyboard for editing its `textView` within its specified `contextView`. 
 *  It also controls user interaction with the system keyboard via its `panGestureRecognizer`, 
 *  allow the user to interactively pan the keyboard up and down in the `contextView`.
 *  
 *  When the system keyboard frame changes, it posts the `JSQMessagesKeyboardControllerNotificationKeyboardDidChangeFrame`.
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
 *  Specifies the distance from the keyboard at which the `panGestureRecognizer`
 *  should trigger user interaction with the keyboard by panning.
 *
 *  @discussion The x value of the point is not used.
 */
@property (assign, nonatomic) CGPoint keyboardTriggerPoint;

/**
 *  Returns `YES` if the keyboard is currently visible, `NO` otherwise.
 */
@property (assign, nonatomic, readonly) BOOL keyboardIsVisible;

/**
 *  Returns the current frame of the keyboard if it is visible, otherwise `CGRectNull`.
 */
@property (assign, nonatomic, readonly) CGRect currentKeyboardFrame;

/**
 *  Not a valid initializer.
 */
- (id)init NS_UNAVAILABLE;

/**
 *  Creates a new keyboard controller object with the specified textView, contextView, panGestureRecognizer, and delegate.
 *
 *  @param textView             The text view in which the user is editing with the system keyboard. This value must not be `nil`.
 *  @param contextView          The view in which the keyboard will be shown. This should be the parent or a sibling of `textView`. This value must not be `nil`.
 *  @param panGestureRecognizer The pan gesture recognizer responsible for handling user interaction with the system keyboard. This value must not be `nil`.
 *  @param delegate             The object that acts as the delegate of the keyboard controller.
 *
 *  @return An initialized `JSQMessagesKeyboardController` if created successfully, `nil` otherwise.
 */
- (instancetype)initWithTextView:(UITextView *)textView
                     contextView:(UIView *)contextView
            panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
                        delegate:(id<JSQMessagesKeyboardControllerDelegate>)delegate NS_DESIGNATED_INITIALIZER;

/**
 *  Tells the keyboard controller that it should begin listening for system keyboard notifications.
 */
- (void)beginListeningForKeyboard;

/**
 *  Tells the keyboard controller that it should end listening for system keyboard notifications.
 */
- (void)endListeningForKeyboard;

@end
