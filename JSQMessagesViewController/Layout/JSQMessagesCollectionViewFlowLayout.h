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
//  Initial code for springy collection view layout taken from Ash Furrow
//  ASHSpringyCollectionView
//
//  The MIT License
//  Copyright (c) 2013 Ash Furrow
//  https://github.com/AshFurrow/ASHSpringyCollectionView
//

#import <UIKit/UIKit.h>

@class JSQMessagesCollectionView;

/**
 *  A constant that describes the default height for all label subviews in a `JSQMessagesCollectionViewCell`.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellLabelHeightDefault;


/**
 *  The `JSQMessagesCollectionViewFlowLayout` is a concrete layout object that inherits 
 *  from `UICollectionViewFlowLayout` and organizes message items in a vertical list.
 *  Each `JSQMessagesCollectionViewCell` in the layout can display messages of arbitrary sizes and avatar images, 
 *  as well as metadata such as a timestamp and sender.
 *  You can easily customize the layout via its properties or its delegate methods 
 *  defined in `JSQMessagesCollectionViewDelegateFlowLayout`.
 *
 *  @see `JSQMessagesCollectionViewDelegateFlowLayout`
 *  @see `JSQMessagesCollectionViewCell`
 */
@interface JSQMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 *  The collection view object currently using this layout object.
 */
@property (readonly, nonatomic) JSQMessagesCollectionView *collectionView;

/**
 *  Specifies whether or not the layout should enable spring behavior dynamics for its items using `UIDynamics`.
 *
 *  @discussion The default value is `NO`, which disables "springy" or "bouncy" items in the layout. 
 *  Set to `YES` if you want items to have spring behavior dynamics.
 */
@property (assign, nonatomic) BOOL springinessEnabled;

/**
 *  Specifies the degree of resistence for the "springiness" of items in the layout. 
 *  This property has no effect if `springinessEnabled` is set to `NO`.
 *
 *  @discussion The default value is `1000`. Increasing this value increases the resistance, that is, items become less "bouncy". 
 *  Decrease this value in order to make items more "bouncy".
 */
@property (assign, nonatomic) NSUInteger springResistanceFactor;

/**
 *  Returns the width of items in the layout.
 */
@property (readonly, nonatomic) CGFloat itemWidth;

/**
 *  The font used to display the body a text message in the message bubble of each 
 *  `JSQMessagesCollectionViewCell` in the collectionView. 
 *  
 *  @discussion The default value is the system font at size `15.0f`. This value must not be `nil`.
 */
@property (strong, nonatomic) UIFont *messageBubbleFont;

/**
 *  The horizontal spacing used to lay out the text view frame within each `JSQMessagesCollectionViewCell`.
 *  This value specifies the horizontal spacing between the message bubble and 
 *  the edge of the collection view cell in which it is displayed.
 *
 *  @discussion The default value is `40.0f`. This value must be positive.
 *  For *outgoing* messages, this value specifies the amount of spacing from the left most 
 *  edge of the collectionView to the left most edge of a message bubble within a cell.
 *
 *  For *incoming* messages, this value specifies the amount of spacing from the right most 
 *  edge of the collectionView to the right most edge of a message bubble within a cell.
 *
 *  @warning This value may not be exact when the layout object finishes laying out its items, due to the constraints it must satisfy. 
 *  This value should be considered more of a recommendation or suggestion to the layout, not an exact value.
 *
 *  @see `JSQMessagesCollectionViewCellIncoming`.
 *  @see `JSQMessagesCollectionViewCellOutgoing`.
 */
@property (assign, nonatomic) CGFloat messageBubbleLeftRightMargin;

/**
 *  The inset of the frame of the text view within each `JSQMessagesCollectionViewCell`. 
 *  The inset values should be positive and are applied in the following ways:
 *  
 *  1. The right value insets the text view frame on the side adjacent to the avatar image 
 *      (or where the avatar would normally appear). For outgoing messages this is the right side, 
 *      for incoming messages this is the left side.
 *
 *  2. The left value insets the text view frame on the side opposite the avatar image 
 *      (or where the avatar would normally appear). For outgoing messages this is the left side, 
 *      for incoming messages this is the right side.
 *
 *  3. The top value insets the top of the frame
 *
 *  4. The bottom value insets the bottom of the frame.
 *
 *  @discussion The default value is `(0.0f, 0.0f, 0.0f, 6.0f)`.
 *
 *  @warning Adjusting this value is an advanced endeavour and not recommended. 
 *  You will only need to adjust this value should you choose to provide your own bubble image assets.
 *  Changing this value may also require you to manually calculate the itemSize for each cell 
 *  in the layout by overriding the delegate method `collectionView: layout: sizeForItemAtIndexPath:`
 */
@property (assign, nonatomic) UIEdgeInsets messageBubbleTextViewFrameInsets;

/**
 *  The inset of the text container's layout area within the text view's content area in each `JSQMessagesCollectionViewCell`. 
 *  The specified inset values should be positive.
 *
 *  @discussion The default value is `(10.0f, 8.0f, 10.0f, 8.0f)`.
 *
 *  @warning Adjusting this value is an advanced endeavour and not recommended. 
 *  You will only need to adjust this value should you choose to provide your own bubble image assets.
 *  Changing this value may also require you to manually calculate the itemSize for each cell
 *  in the layout by overriding the delegate method `collectionView: layout: sizeForItemAtIndexPath:`
 */
@property (assign, nonatomic) UIEdgeInsets messageBubbleTextViewTextContainerInsets;

/**
 *  The horizontal spacing used to lay out the bubble's top label of each `JSQMessagesCollectionViewCell`.
 *  This value specifies the horizontal spacing between the bubble's top label and
 *  the edge of the collection view.
 *
 *  @discussion The default value is `60.0f`. This value must be positive.
 *  For *outgoing* messages, this value specifies the amount of spacing from the right
 *  edge of the collectionView to the right most edge of the messageBubbleTopLabel.
 *
 *  For *incoming* messages, this value specifies the amount of spacing from the left
 *  edge of the collectionView to the left most edge of a messageBubbleTopLabel.
 *
 */
@property (assign, nonatomic) CGFloat messageBubbleTopLabelLeftRightInset;

/**
 *  The size of the avatar image view for incoming messages.
 *
 *  @discussion The default value is `(34.0f, 34.0f)`. Set to `CGSizeZero` to remove incoming avatars.
 */
@property (assign, nonatomic) CGSize incomingAvatarViewSize;

/**
 *  The size of the avatar image view for outgoing messages.
 *
 *  @discussion The default value is `(34.0f, 34.0f)`. Set to `CGSizeZero` to remove outgoing avatars.
 */
@property (assign, nonatomic) CGSize outgoingAvatarViewSize;

/**
 *  Computes and returns the size of the `messageBubbleImageView` property of a `JSQMessagesCollectionViewCell` 
 *  to display its entire message contents. Note, this is *not* the entire cell, but only its message bubble.
 *
 *  @param indexPath The index path of the item to be displayed.
 *
 *  @return The size of the message bubble for the item displayed at indexPath.
 */
- (CGSize)messageBubbleSizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
