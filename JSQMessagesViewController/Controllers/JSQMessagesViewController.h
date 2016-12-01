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

#import <UIKit/UIKit.h>

#import "JSQMessagesCollectionView.h"
#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessagesInputToolbar.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `JSQMessagesViewController` class is an abstract class that represents a view controller whose content consists of
 *  a `JSQMessagesCollectionView` and `JSQMessagesInputToolbar` and is specialized to display a messaging interface.
 *
 *  @warning This class is intended to be subclassed. You should not use it directly.
 */
@interface JSQMessagesViewController : UIViewController <JSQMessagesCollectionViewDataSource,
                                                         JSQMessagesCollectionViewDelegateFlowLayout,
                                                         UITextViewDelegate>

/**
 *  Returns the collection view object managed by this view controller.
 *  This view controller is the collection view's data source and delegate.
 */
@property (weak, nonatomic, readonly, nullable) JSQMessagesCollectionView *collectionView;

/**
 *  Returns the input toolbar view object managed by this view controller.
 *  This view controller is the toolbar's delegate.
 */
@property (strong, nonatomic, readonly) JSQMessagesInputToolbar *inputToolbar;

/**
 *  Specifies whether or not the view controller should automatically scroll to the most recent message
 *  when the view appears and when sending, receiving, and composing a new message.
 *
 *  @discussion The default value is `YES`, which allows the view controller to scroll automatically to the most recent message.
 *  Set to `NO` if you want to manage scrolling yourself.
 */
@property (assign, nonatomic) BOOL automaticallyScrollsToMostRecentMessage;

/**
 *  The collection view cell identifier to use for dequeuing outgoing message collection view cells 
 *  in the collectionView for text messages.
 *
 *  @discussion This cell identifier is used for outgoing text message data items.
 *  The default value is the string returned by `[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]`.
 *  This value must not be `nil`.
 *
 *  @see JSQMessagesCollectionViewCellOutgoing.
 *
 *  @warning Overriding this property's default value is *not* recommended. 
 *  You should only override this property's default value if you are proividing your own cell prototypes.
 *  These prototypes must be registered with the collectionView for reuse and you are then responsible for 
 *  completely overriding many delegate and data source methods for the collectionView, 
 *  including `collectionView:cellForItemAtIndexPath:`.
 */
@property (copy, nonatomic) NSString *outgoingCellIdentifier;

/**
 *  The collection view cell identifier to use for dequeuing outgoing message collection view cells
 *  in the collectionView for media messages.
 *
 *  @discussion This cell identifier is used for outgoing media message data items.
 *  The default value is the string returned by `[JSQMessagesCollectionViewCellOutgoing mediaCellReuseIdentifier]`.
 *  This value must not be `nil`.
 *
 *  @see JSQMessagesCollectionViewCellOutgoing.
 *
 *  @warning Overriding this property's default value is *not* recommended.
 *  You should only override this property's default value if you are proividing your own cell prototypes.
 *  These prototypes must be registered with the collectionView for reuse and you are then responsible for
 *  completely overriding many delegate and data source methods for the collectionView,
 *  including `collectionView:cellForItemAtIndexPath:`.
 */
@property (copy, nonatomic) NSString *outgoingMediaCellIdentifier;

/**
 *  The collection view cell identifier to use for dequeuing incoming message collection view cells 
 *  in the collectionView for text messages.
 *
 *  @discussion This cell identifier is used for incoming text message data items.
 *  The default value is the string returned by `[JSQMessagesCollectionViewCellIncoming cellReuseIdentifier]`.
 *  This value must not be `nil`.
 *
 *  @see JSQMessagesCollectionViewCellIncoming.
 *
 *  @warning Overriding this property's default value is *not* recommended. 
 *  You should only override this property's default value if you are proividing your own cell prototypes. 
 *  These prototypes must be registered with the collectionView for reuse and you are then responsible for 
 *  completely overriding many delegate and data source methods for the collectionView, 
 *  including `collectionView:cellForItemAtIndexPath:`.
 */
@property (copy, nonatomic) NSString *incomingCellIdentifier;

/**
 *  The collection view cell identifier to use for dequeuing incoming message collection view cells 
 *  in the collectionView for media messages.
 *
 *  @discussion This cell identifier is used for incoming media message data items.
 *  The default value is the string returned by `[JSQMessagesCollectionViewCellIncoming mediaCellReuseIdentifier]`.
 *  This value must not be `nil`.
 *
 *  @see JSQMessagesCollectionViewCellIncoming.
 *
 *  @warning Overriding this property's default value is *not* recommended.
 *  You should only override this property's default value if you are proividing your own cell prototypes.
 *  These prototypes must be registered with the collectionView for reuse and you are then responsible for
 *  completely overriding many delegate and data source methods for the collectionView,
 *  including `collectionView:cellForItemAtIndexPath:`.
 */
@property (copy, nonatomic) NSString *incomingMediaCellIdentifier;

/**
 *  Specifies whether or not the view controller should show the typing indicator for an incoming message.
 *
 *  @discussion Setting this property to `YES` will animate showing the typing indicator immediately.
 *  Setting this property to `NO` will animate hiding the typing indicator immediately. You will need to scroll
 *  to the bottom of the collection view in order to see the typing indicator. You may use `scrollToBottomAnimated:` for this.
 */
@property (assign, nonatomic) BOOL showTypingIndicator;

/**
 *  Specifies whether or not the view controller should show the "load earlier messages" header view.
 *
 *  @discussion Setting this property to `YES` will show the header view immediately.
 *  Settings this property to `NO` will hide the header view immediately. You will need to scroll to
 *  the top of the collection view in order to see the header.
 */
@property (assign, nonatomic) BOOL showLoadEarlierMessagesHeader;

/**
 *  Specifies an additional inset amount to be added to the collectionView's `contentInset` and `scrollIndicatorInsets` value.
 *  Currently, the `.left` and `.right` insets are ignored.
 *
 *  @discussion Use this property to adjust the insets to account for a custom subview in your view controller.
 */
@property (assign, nonatomic) UIEdgeInsets additionalContentInset;

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for a `JSQMessagesViewController`.
 *
 *  @return The initialized `UINib` object.
 *
 *  @discussion You may override this method to provide a customized nib. If you do,
 *  you should also override `messagesViewController` to return your
 *  view controller loaded from your custom nib.
 */
+ (UINib *)nib;

/**
 *  Creates and returns a new `JSQMessagesViewController` object.
 *
 *  @discussion This is the designated initializer for programmatic instantiation.
 *
 *  @return An initialized `JSQMessagesViewController` object.
 */
+ (instancetype)messagesViewController;

#pragma mark - Messages view controller

/**
 *  This method is called when the user taps the send button on the inputToolbar
 *  after composing a message with the specified data.
 *
 *  @param button            The send button that was pressed by the user.
 *  @param text              The message text.
 *  @param senderId          The message sender identifier.
 *  @param senderDisplayName The message sender display name.
 *  @param date              The message date.
 */
- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date;

/**
 *  This method is called when the user taps the accessory button on the `inputToolbar`.
 *
 *  @param sender The accessory button that was pressed by the user.
 */
- (void)didPressAccessoryButton:(UIButton *)sender;

/**
 *  Animates the sending of a new message. See `finishSendingMessageAnimated:` for more details.
 *
 *  @see `finishSendingMessageAnimated:`.
 */
- (void)finishSendingMessage;

/**
 *  Completes the "sending" of a new message by resetting the `inputToolbar`, adding a new collection view cell in the collection view,
 *  reloading the collection view, and scrolling to the newly sent message as specified by `automaticallyScrollsToMostRecentMessage`.
 *  Scrolling to the new message can be animated as specified by the animated parameter.
 *
 *  @param animated Specifies whether the sending of a message should be animated or not. Pass `YES` to animate changes, `NO` otherwise.
 *
 *  @discussion You should call this method at the end of `didPressSendButton: withMessageText: senderId: senderDisplayName: date`
 *  after adding the new message to your data source and performing any related tasks.
 *
 *  @see `automaticallyScrollsToMostRecentMessage`.
 */
- (void)finishSendingMessageAnimated:(BOOL)animated;

/**
 *  Animates the receiving of a new message. See `finishReceivingMessageAnimated:` for more details.
 *
 *  @see `finishReceivingMessageAnimated:`.
 */
- (void)finishReceivingMessage;

/**
 *  Completes the "receiving" of a new message by showing the typing indicator, adding a new collection view cell in the collection view,
 *  reloading the collection view, and scrolling to the newly sent message as specified by `automaticallyScrollsToMostRecentMessage`.
 *  Scrolling to the new message can be animated as specified by the animated parameter.
 *
 *  @param animated Specifies whether the receiving of a message should be animated or not. Pass `YES` to animate changes, `NO` otherwise.
 *
 *  @discussion You should call this method after adding a new "received" message to your data source and performing any related tasks.
 *
 *  @see `automaticallyScrollsToMostRecentMessage`.
 */
- (void)finishReceivingMessageAnimated:(BOOL)animated;

/**
 *  Scrolls the collection view such that the bottom most cell is completely visible, above the `inputToolbar`.
 *
 *  @param animated Pass `YES` if you want to animate scrolling, `NO` if it should be immediate.
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 * Used to decide if a message is incoming or outgoing.
 *
 * @discussion The default implementation of this method compares the `senderId` of the message to the
 * value of the `senderId` property and returns `YES` if they are equal. Subclasses can override
 * this method to specialize the decision logic.
 */
- (BOOL)isOutgoingMessage:(id<JSQMessageData>)messageItem;

/**
 * Scrolls the collection view so that the cell at the specified indexPath is completely visible above the `inputToolbar`.
 *
 * @param indexPath The indexPath for the cell that will be visible.
 * @param animated Pass `YES` if you want to animate scrolling, `NO` otherwise.
 */
- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 Call to super required.
 */
- (void)viewDidLoad NS_REQUIRES_SUPER;

/**
 Call to super required.
 */
- (void)viewWillAppear:(BOOL)animated NS_REQUIRES_SUPER;

/**
 Call to super required.
 */
- (void)viewDidAppear:(BOOL)animated NS_REQUIRES_SUPER;

/**
 Call to super required.
 */
- (void)viewWillDisappear:(BOOL)animated NS_REQUIRES_SUPER;

/**
 Call to super required.
 */
- (void)viewDidDisappear:(BOOL)animated NS_REQUIRES_SUPER;

/**
 Called when `UIMenuControllerWillShowMenuNotification` is posted.

 @param notification The posted notification.
 */
- (void)didReceiveMenuWillShowNotification:(NSNotification *)notification;

/**
 Called when `UIMenuControllerWillHideMenuNotification` is posted.

 @param notification The posted notification.
 */
- (void)didReceiveMenuWillHideNotification:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END
