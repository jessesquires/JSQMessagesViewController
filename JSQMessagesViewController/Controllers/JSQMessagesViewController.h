//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

@class JSQMessagesInputToolbar;

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
@property (weak, nonatomic, readonly) JSQMessagesCollectionView *collectionView;

/**
 *  Returns the input toolbar view object managed by this view controller. 
 *  This view controller is the toolbar's delegate.
 */
@property (weak, nonatomic, readonly) JSQMessagesInputToolbar *inputToolbar;

/**
 *  The name of the user sending messages. This value must not be `nil`. 
 *  The default value is `@"JSQDefaultSender"`.
 */
@property (copy, nonatomic) NSString *sender;

/**
 *  Specifies whether or not the view controller should automatically scroll to the most recent message 
 *  when the view appears and when sending, receiving, and composing a new message.
 *
 *  @discussion The default value is `YES`, which allows the view controller to scroll automatically to the most recent message. 
 *  Set to `NO` if you want to manage scrolling yourself.
 */
@property (assign, nonatomic) BOOL automaticallyScrollsToMostRecentMessage;

/**
 *  The collection view cell identifier to use for dequeuing outgoing message collection view cells in the collectionView.
 *
 *  @discussion The default value is the string returned by `[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]`. 
 *  This value must not be `nil`.
 *  
 *  @see `JSQMessagesCollectionViewCellOutgoing`.
 *
 *  @warning Overriding this property's default value is *not* recommended. 
 *  You should only override this property's default value if you are proividing your own cell prototypes.
 *  These prototypes must be registered with the collectionView for reuse and you are then responsible for 
 *  completely overriding many delegate and data source methods for the collectionView, 
 *  including `collectionView:cellForItemAtIndexPath:`.
 */
@property (copy, nonatomic) NSString *outgoingCellIdentifier;

/**
 *  The collection view cell identifier to use for dequeuing incoming message collection view cells in the collectionView.
 *
 *  @discussion The default value is the string returned by `[JSQMessagesCollectionViewCellIncoming cellReuseIdentifier]`. 
 *  This value must not be `nil`.
 *
 *  @see `JSQMessagesCollectionViewCellIncoming`.
 *
 *  @warning Overriding this property's default value is *not* recommended. 
 *  You should only override this property's default value if you are proividing your own cell prototypes. 
 *  These prototypes must be registered with the collectionView for reuse and you are then responsible for 
 *  completely overriding many delegate and data source methods for the collectionView, 
 *  including `collectionView:cellForItemAtIndexPath:`.
 */
@property (copy, nonatomic) NSString *incomingCellIdentifier;

/**
 *  The color for the typing indicator for incoming messages.
 *
 *  @discussion The color specified is used for the typing indicator bubble image color.
 *  This color is then slightly darkened and used to color the typing indicator ellipsis.
 *  The default value is the light gray color value return by `[UIColor jsq_messageBubbleLightGrayColor]`.
 */
@property (strong, nonatomic) UIColor *typingIndicatorColor;

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
 *  Specifies an additional inset amount to be added to the collectionView's contentInsets.top value.
 *
 *  @discussion Use this property to adjust the top content inset to account for a custom subview at the top of your view controller.
 */
@property (assign, nonatomic) CGFloat topContentAdditionalInset;

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for `JSQMessagesViewController`.
 *
 *  @return The initialized `UINib` object or `nil` if there were errors during initialization 
 *  or the nib file could not be located.
 */
+ (UINib *)nib;

/**
 *  Creates and returns a new `JSQMessagesViewController` object.
 *  
 *  @discussion This is the designated initializer for programmatic instantiation.
 *
 *  @return The initialized messages view controller if successful, otherwise `nil`.
 */
+ (instancetype)messagesViewController;

#pragma mark - Messages view controller

/**
 *  This method is called when the user taps the send button on the inputToolbar
 *  after composing a message with the specified data.
 *
 *  @param button The send button that was pressed by the user.
 *  @param text   The message text.
 *  @param sender The message sender.
 *  @param date   The message date.
 */
- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                    sender:(NSString *)sender
                      date:(NSDate *)date;

/**
 *  This method is called when the user taps the accessory button on the `inputToolbar`.
 *
 *  @param sender The accessory button that was pressed by the user.
 */
- (void)didPressAccessoryButton:(UIButton *)sender;

/**
 *  Completes the "sending" of a new message by animating and resetting the `inputToolbar`, 
 *  animating the addition of a new collection view cell in the collection view,
 *  reloading the collection view, and scrolling to the newly sent message 
 *  as specified by `automaticallyScrollsToMostRecentMessage`.
 *
 *  @discussion You should call this method at the end of `didPressSendButton:withMessage:` 
 *  after adding the new message to your data source and performing any related tasks.
 *
 *  @see `automaticallyScrollsToMostRecentMessage`.
 *  @see `didPressSendButton: withMessage:`.
 */
- (void)finishSendingMessage;

/**
 *  Completes the "receiving" of a new message by animating the typing indicator,
 *  animating the addition of a new collection view cell in the collection view,
 *  reloading the collection view, and scrolling to the newly sent message
 *  as specified by `automaticallyScrollsToMostRecentMessage`.
 *
 *  @discussion You should call this method after adding a new "received" message
 *  to your data source and performing any related tasks.
 *
 *  @see `automaticallyScrollsToMostRecentMessage`.
 */
- (void)finishReceivingMessage;

/**
 *  Scrolls the collection view such that the bottom most cell is completely visible, above the `inputToolbar`.
 *
 *  @param animated Pass `YES` if you want to animate scrolling, `NO` if it should be immediate.
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

@end
