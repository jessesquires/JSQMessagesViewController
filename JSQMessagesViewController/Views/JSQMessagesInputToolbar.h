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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JSQMessagesToolbarContentView.h"

@class JSQMessagesInputToolbar;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JSQMessagesInputSendButtonLocation) {
    JSQMessagesInputSendButtonLocationNone,
    JSQMessagesInputSendButtonLocationRight,
    JSQMessagesInputSendButtonLocationLeft
};


/**
 *  The `JSQMessagesInputToolbarDelegate` protocol defines methods for interacting with
 *  a `JSQMessagesInputToolbar` object.
 */
@protocol JSQMessagesInputToolbarDelegate <UIToolbarDelegate>

@required

/**
 *  Tells the delegate that the toolbar's `rightBarButtonItem` has been pressed.
 *
 *  @param toolbar The object representing the toolbar sending this information.
 *  @param sender  The button that received the touch event.
 */
- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar
      didPressRightBarButton:(UIButton *)sender;

/**
 *  Tells the delegate that the toolbar's `leftBarButtonItem` has been pressed.
 *
 *  @param toolbar The object representing the toolbar sending this information.
 *  @param sender  The button that received the touch event.
 */
- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar
       didPressLeftBarButton:(UIButton *)sender;

@end


/**
 *  An instance of `JSQMessagesInputToolbar` defines the input toolbar for
 *  composing a new message. It is displayed above and follow the movement of the system keyboard.
 */
@interface JSQMessagesInputToolbar : UIToolbar

/**
 *  The object that acts as the delegate of the toolbar.
 */
@property (weak, nonatomic, nullable) id<JSQMessagesInputToolbarDelegate> delegate;

/**
 *  Returns the content view of the toolbar. This view contains all subviews of the toolbar.
 */
@property (weak, nonatomic, readonly, nullable) JSQMessagesToolbarContentView *contentView;

/**
 *  Indicates the location of the send button in the toolbar.
 *
 *  @discussion The default value is `JSQMessagesInputSendButtonLocationRight`, which indicates that the send button is the right-most subview of
 *  the toolbar's `contentView`. Set to `JSQMessagesInputSendButtonLocationLeft` to specify that the send button is on the left. Set to 'JSQMessagesInputSendButtonLocationNone' if there is no send button or if you want to take control of the send button actions. This
 *  property is used to determine which touch events correspond to which actions.
 *
 *  @warning Note, this property *does not* change the positions of buttons in the toolbar's content view.
 *  It only specifies whether the `rightBarButtonItem` or the `leftBarButtonItem` is the send button or there is no send button.
 *  The other button then acts as the accessory button.
 */
@property (assign, nonatomic) JSQMessagesInputSendButtonLocation sendButtonLocation;

/**
 *  Specify if the send button should be enabled automatically when the `textView` contains text.
 *  The default value is `YES`.
 *
 *  @discussion If `YES`, the send button will be enabled if the `textView` contains text. Otherwise,
 *  you are responsible for determining when to enable/disable the send button.
 */
@property (assign, nonatomic) BOOL enablesSendButtonAutomatically;

/**
 *  Specifies the default (minimum) height for the toolbar. The default value is `44.0f`. This value must be positive.
 */
@property (assign, nonatomic) CGFloat preferredDefaultHeight;

/**
 *  Specifies the maximum height for the toolbar. The default value is `NSNotFound`, which specifies no maximum height.
 */
@property (assign, nonatomic) NSUInteger maximumHeight;

/**
 *  Loads the content view for the toolbar.
 *
 *  @discussion Override this method to provide a custom content view for the toolbar.
 *
 *  @return An initialized `JSQMessagesToolbarContentView`.
 */
- (JSQMessagesToolbarContentView *)loadToolbarContentView;

@end

NS_ASSUME_NONNULL_END
