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

#import "JSQMessagesLabel.h"
#import "JSQMessagesCellTextView.h"

@class JSQMessagesCollectionViewCell;

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `JSQMessagesCollectionViewCellDelegate` protocol defines methods that allow you to manage
 *  additional interactions within the collection view cell.
 */
@protocol JSQMessagesCollectionViewCellDelegate <NSObject>

@required

/**
 *  Tells the delegate that the avatarImageView of the cell has been tapped.
 *
 *  @param cell The cell that received the tap touch event.
 */
- (void)messagesCollectionViewCellDidTapAvatar:(JSQMessagesCollectionViewCell *)cell;

/**
 *  Tells the delegate that the message bubble of the cell has been tapped.
 *
 *  @param cell The cell that received the tap touch event.
 */
- (void)messagesCollectionViewCellDidTapMessageBubble:(JSQMessagesCollectionViewCell *)cell;

/**
 *  Tells the delegate that the cell has been tapped at the point specified by position.
 *
 *  @param cell The cell that received the tap touch event.
 *  @param position The location of the received touch in the cell's coordinate system.
 *
 *  @discussion This method is *only* called if position is *not* within the bounds of the cell's
 *  avatar image view or message bubble image view. In other words, this method is *not* called when the cell's
 *  avatar or message bubble are tapped.
 *
 *  @see `messagesCollectionViewCellDidTapAvatar:`
 *  @see `messagesCollectionViewCellDidTapMessageBubble:`
 */
- (void)messagesCollectionViewCellDidTapCell:(JSQMessagesCollectionViewCell *)cell atPosition:(CGPoint)position;

/**
 *  Tells the delegate that an actions has been selected from the menu of this cell.
 *  This method is automatically called for any registered actions.
 *
 *  @param cell The cell that displayed the menu.
 *  @param action The action that has been performed.
 *  @param sender The object that initiated the action.
 *
 *  @see `JSQMessagesCollectionViewCell`
 */
- (void)messagesCollectionViewCell:(JSQMessagesCollectionViewCell *)cell didPerformAction:(SEL)action withSender:(id)sender;

@end


/**
 *  The `JSQMessagesCollectionViewCell` is an abstract base class that presents the content for
 *  a single message data item when that item is within the collection view’s visible bounds.
 *  The layout and presentation of cells is managed by the collection view and its corresponding layout object.
 *
 *  @warning This class is intended to be subclassed. You should not use it directly.
 *
 *  @see JSQMessagesCollectionViewCellIncoming.
 *  @see JSQMessagesCollectionViewCellOutgoing.
 */
@interface JSQMessagesCollectionViewCell : UICollectionViewCell

/**
 *  The object that acts as the delegate for the cell.
 */
@property (weak, nonatomic, nullable) id<JSQMessagesCollectionViewCellDelegate> delegate;

/**
 *  Returns the label that is pinned to the top of the cell.
 *  This label is most commonly used to display message timestamps.
 */
@property (weak, nonatomic, readonly, nullable) JSQMessagesLabel *cellTopLabel;

/**
 *  Returns the label that is pinned just above the messageBubbleImageView, and below the cellTopLabel.
 *  This label is most commonly used to display the message sender.
 */
@property (weak, nonatomic, readonly, nullable) JSQMessagesLabel *messageBubbleTopLabel;

/**
 *  Returns the label that is pinned to the bottom of the cell.
 *  This label is most commonly used to display message delivery status.
 */
@property (weak, nonatomic, readonly, nullable) JSQMessagesLabel *cellBottomLabel;

/**
 *  Returns the text view of the cell. This text view contains the message body text.
 *
 *  @warning If mediaView returns a non-nil view, then this value will be `nil`.
 */
@property (weak, nonatomic, readonly, nullable) JSQMessagesCellTextView *textView;

/**
 *  Returns the bubble image view of the cell that is responsible for displaying message bubble images.
 *
 *  @warning If mediaView returns a non-nil view, then this value will be `nil`.
 */
@property (weak, nonatomic, readonly, nullable) UIImageView *messageBubbleImageView;

/**
 *  Returns the message bubble container view of the cell. This view is the superview of
 *  the cell's textView and messageBubbleImageView.
 *
 *  @discussion You may customize the cell by adding custom views to this container view.
 *  To do so, override `collectionView:cellForItemAtIndexPath:`
 *
 *  @warning You should not try to manipulate any properties of this view, for example adjusting
 *  its frame, nor should you remove this view from the cell or remove any of its subviews.
 *  Doing so could result in unexpected behavior.
 */
@property (weak, nonatomic, readonly, nullable) UIView *messageBubbleContainerView;

/**
 *  Returns the avatar image view of the cell that is responsible for displaying avatar images.
 */
@property (weak, nonatomic, readonly, nullable) UIImageView *avatarImageView;

/**
 *  Returns the avatar container view of the cell. This view is the superview of the cell's avatarImageView.
 *
 *  @discussion You may customize the cell by adding custom views to this container view.
 *  To do so, override `collectionView:cellForItemAtIndexPath:`
 *
 *  @warning You should not try to manipulate any properties of this view, for example adjusting
 *  its frame, nor should you remove this view from the cell or remove any of its subviews.
 *  Doing so could result in unexpected behavior.
 */
@property (weak, nonatomic, readonly, nullable) UIView *avatarContainerView;

/**
 *  The media view of the cell. This view displays the contents of a media message.
 *
 *  @warning If this value is non-nil, then textView and messageBubbleImageView will both be `nil`.
 */
@property (weak, nonatomic, nullable) UIView *mediaView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the avatarImageView of the cell.
 *  This gesture handles the tap event for the avatarImageView and notifies the cell's delegate.
 */
@property (weak, nonatomic, readonly, nullable) UITapGestureRecognizer *tapGestureRecognizer;

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for the cell.
 *
 *  @return The initialized `UINib` object.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify a reusable cell for text message items.
 *
 *  @return The string used to identify a reusable cell.
 */
+ (NSString *)cellReuseIdentifier;

/**
 *  Returns the default string used to identify a reusable cell for media message items.
 *
 *  @return The string used to identify a reusable cell.
 */
+ (NSString *)mediaCellReuseIdentifier;

/**
 *  Registers an action to be available in the cell's menu.
 *
 *  @param action The selector to register with the cell.
 *
 *  @discussion Non-standard or non-system actions must be added to the `UIMenuController` manually.
 *  You can do this by creating a new `UIMenuItem` and adding it via the controller's `menuItems` property.
 *
 *  @warning Note that all message cells share the all actions registered here.
 */
+ (void)registerMenuAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
