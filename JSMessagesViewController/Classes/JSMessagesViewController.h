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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>
#import "JSBubbleMessageCell.h"
#import "JSMessageInputView.h"
#import "JSAvatarImageFactory.h"
#import "JSBubbleImageViewFactory.h"
#import "JSMessageSoundEffect.h"
#import "UIColor+JSMessagesView.h"

/**
 *  The frequency with which timestamps are displayed in the messages table view.
 */
typedef NS_ENUM(NSUInteger, JSMessagesViewTimestampPolicy) {
    /**
     *  Displays a timestamp above every message bubble.
     */
    JSMessagesViewTimestampPolicyAll,
    /**
     *  Displays a timestamp above every second message bubble.
     */
    JSMessagesViewTimestampPolicyAlternating,
    /**
     *  Displays a timestamp above every third message bubble.
     */
    JSMessagesViewTimestampPolicyEveryThree,
    /**
     *  Displays a timestamp above every fifth message bubble.
     */
    JSMessagesViewTimestampPolicyEveryFive,
    /**
     *  Displays a timestamp based on the result of the optional delegate method `hasTimestampForRowAtIndexPath:`. 
     *  @see JSMessagesViewDelegate.
     */
    JSMessagesViewTimestampPolicyCustom
};

/**
 *  The method by which avatars are displayed in the messages table view.
 */
typedef NS_ENUM(NSUInteger, JSMessagesViewAvatarPolicy) {
    /**
     *  Displays an avatar for all incoming and all outgoing messages.
     */
    JSMessagesViewAvatarPolicyAll,
    /**
     *  Displays an avatar for incoming messages only.
     */
    JSMessagesViewAvatarPolicyIncomingOnly,
    /**
     *  Display an avatar for outgoing messages only.
     */
    JSMessagesViewAvatarPolicyOutgoingOnly,
    /**
     *  Does not display any avatars.
     */
    JSMessagesViewAvatarPolicyNone
};

/**
 *  The method by which subtitles are displayed in the messages table view.
 */
typedef NS_ENUM(NSUInteger, JSMessagesViewSubtitlePolicy) {
    /**
     *  Displays a subtitle for all incoming and all outgoing messages.
     */
    JSMessagesViewSubtitlePolicyAll,
    /**
     *  Displays a subtitle for incoming messages only.
     */
    JSMessagesViewSubtitlePolicyIncomingOnly,
    /**
     *  Displays a subtitle for outgoing messages only.
     */
    JSMessagesViewSubtitlePolicyOutgoingOnly,
    /**
     *  Does not display any subtitles.
     */
    JSMessagesViewSubtitlePolicyNone
};

/**
 *  The delegate of a `JSMessagesViewController` must adopt the `JSMessagesViewDelegate` protocol.
 */
@protocol JSMessagesViewDelegate <NSObject>

@required

/**
 *  Tells the delegate that the specified text has been sent. Hook into your own backend here.
 *
 *  @param text A string containing the text that was present in the messageInputView's textView when the send button was pressed.
 */
- (void)didSendText:(NSString *)text;

/**
 *  Asks the delegate for the message type for the row at the specified index path.
 *
 *  @param indexPath The index path of the row to be displayed.
 *
 *  @return A constant describing the message type. 
 *  @see JSBubbleMessageType.
 */
- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate for the bubble image view for the row at the specified index path with the specified type.
 *
 *  @param type      The type of message for the row located at indexPath.
 *  @param indexPath The index path of the row to be displayed.
 *
 *  @return A `UIImageView` with both `image` and `highlightedImage` properties set. 
 *  @see JSBubbleImageViewFactory.
 */
- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate for the timestamp policy.
 *
 *  @return A constant describing the timestamp policy. 
 *  @see JSMessagesViewTimestampPolicy.
 */
- (JSMessagesViewTimestampPolicy)timestampPolicy;

/**
 *  Asks the delegate for the avatar policy.
 *
 *  @return A constant describing the avatar policy. 
 *  @see JSMessagesViewAvatarPolicy.
 */
- (JSMessagesViewAvatarPolicy)avatarPolicy;

/**
 *  Asks the delegate for the subtitle policy.
 *
 *  @return A constant describing the subtitle policy. 
 *  @see JSMessagesViewSubtitlePolicy.
 */
- (JSMessagesViewSubtitlePolicy)subtitlePolicy;

/**
 *  Asks the delegate for the input view style.
 *
 *  @return A constant describing the input view style.
 *  @see JSMessageInputViewStyle.
 */
- (JSMessageInputViewStyle)inputViewStyle;

@optional

/**
 *  Tells the delegate to configure or further customize the given cell at the specified index path.
 *
 *  @param cell      The message cell to configure.
 *  @param indexPath The index path for cell.
 */
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate if the row at the specified index path should display a timestamp. You should only implement this method if using `JSMessagesViewTimestampPolicyCustom`. @see JSMessagesViewTimestampPolicy.
 *
 *  @param indexPath The index path of the row to be displayed.
 *
 *  @return `YES` if the row should display a timestamp, `NO` otherwise.
 */
- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate if should always scroll to bottom automatically when new messages are sent or received.
 *
 *  @return `YES` if you would like to prevent the table view from being scrolled to the bottom while the user is scrolling the table view manually, `NO` otherwise.
 */
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling;

/**
 *  Asks the delegate for the send button to be used in messageInputView. Implement this method if you wish to use a custom send button. The button must be a `UIButton` or a subclass of `UIButton`. The button's frame is set for you.
 *
 *  @return A custom `UIButton` to use in messageInputView.
 */
- (UIButton *)sendButtonForInputView;

@end



@protocol JSMessagesViewDataSource <NSObject>

@required

/**
 *  Asks the data source for the text to display for the row at the specified index path.
 *
 *  @param indexPath An index path locating a row in the table view.
 *
 *  @return A string containing text for a message. This value must not be `nil`.
 */
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the date to display in the timestamp label *above* the row at the specified index path.
 *
 *  @param indexPath An index path locating a row in the table view.
 *
 *  @return A date object specifying when the message at indexPath was sent. This value may be `nil`.
 */
- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the imageView to display for the row at the specified index path. The imageView must have its `image` property set.
 *
 *  @param indexPath An index path locating a row in the table view.
 *
 *  @return An image view specifying the avatar for the message at indexPath. This value may be `nil`.
 */
- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the text to display in the subtitle label *below* the row at the specified index path.
 *
 *  @param indexPath An index path locating a row in the table view.
 *
 *  @return A string containing the subtitle for the message at indexPath. This value may be `nil`.
 */
- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


/**
 *  An instance of `JSMessagesViewController` is a subclass of `UIViewController` specialized to display a messaging interface.
 */
@interface JSMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

/**
 *  The object that acts as the delegate of the receiving messages view.
 */
@property (weak, nonatomic) id<JSMessagesViewDelegate> delegate;

/**
 *  The object that acts as the data source of receiving messages view.
 */
@property (weak, nonatomic) id<JSMessagesViewDataSource> dataSource;

/**
 *  Returns the table view that displays the messages in `JSMessagesViewController`.
 */
@property (weak, nonatomic, readonly) UITableView *tableView;

/**
 *  Returns the message input view with which new messages are composed.
 */
@property (weak, nonatomic, readonly) JSMessageInputView *messageInputView;

#pragma mark - Messages view controller

/**
 *  Animates and resets the text view in messageInputView. Call this method at the end of the delegate method `didSendText:`. 
 *  @see JSMessagesViewDelegate.
 */
- (void)finishSend;


/**
 *  Sets the background color of the table view, the table view cells, and the table view separator.
 *
 *  @param color The color to be used as the new background color.
 */
- (void)setBackgroundColor:(UIColor *)color;

/**
 *  Scrolls the table view such that the bottom most cell is completely visible, above the messageInputView. 
 *
 *  This method respects the delegate method `shouldPreventScrollToBottomWhileUserScrolling`. 
 *
 *  @see JSMessagesViewDelegate.
 *
 *  @param animated `YES` if you want to animate scrolling, `NO` if it should be immediate.
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 *  Scrolls the receiver until a row identified by index path is at a particular location on the screen. 
 *
 *  This method respects the delegate method `shouldPreventScrollToBottomWhileUserScrolling`. 
 *
 *  @see JSMessagesViewDelegate.
 *
 *  @param indexPath An index path that identifies a row in the table view by its row index and its section index.
 *  @param position  A constant defined in `UITableViewScrollPosition` that identifies a relative position in the receiving table view.
 *  @param animated  `YES` if you want to animate the change in position, `NO` if it should be immediate.
 */
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
			  atScrollPosition:(UITableViewScrollPosition)position
					  animated:(BOOL)animated;

@end