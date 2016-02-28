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
//  Ideas for springy collection view layout taken from Ash Furrow
//  ASHSpringyCollectionView
//  https://github.com/AshFurrow/ASHSpringyCollectionView
//

#import <UIKit/UIKit.h>

#import "JSQMessagesBubbleSizeCalculating.h"

@class JSQMessagesCollectionView;


/**
 *  A constant that describes the default height for all label subviews in a `JSQMessagesCollectionViewCell`.
 *
 *  @see JSQMessagesCollectionViewCell.
 */
FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellLabelHeightDefault;

/**
 *  A constant that describes the default size for avatar images in a `JSQMessagesCollectionViewFlowLayout`.
 */
FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewAvatarSizeDefault;



/**
 *  The `JSQMessagesCollectionViewFlowLayout` is a concrete layout object that inherits 
 *  from `UICollectionViewFlowLayout` and organizes message items in a vertical list.
 *  Each `JSQMessagesCollectionViewCell` in the layout can display messages of arbitrary sizes and avatar images, 
 *  as well as metadata such as a timestamp and sender.
 *  You can easily customize the layout via its properties or its delegate methods 
 *  defined in `JSQMessagesCollectionViewDelegateFlowLayout`.
 *
 *  @see JSQMessagesCollectionViewDelegateFlowLayout.
 *  @see JSQMessagesCollectionViewCell.
 */
@interface JSQMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

/**
 *  The collection view object currently using this layout object.
 */

// TODO: fix, rename "messagesCollectionView", see #920
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-property-type"
@property (readonly, nonatomic) JSQMessagesCollectionView *collectionView;
#pragma clang diagnostic pop

/**
 *  The object that the layout uses to calculate bubble sizes.
 *  The default value is an instance of `JSQMessagesBubblesSizeCalculator`.
 */
@property (strong, nonatomic) id<JSQMessagesBubbleSizeCalculating> bubbleSizeCalculator;

/**
 *  Specifies whether or not the layout should enable spring behavior dynamics for its items using `UIDynamics`.
 *
 *  @discussion The default value is `NO`, which disables "springy" or "bouncy" items in the layout. 
 *  Set to `YES` if you want items to have spring behavior dynamics. You *must* set this property from `viewDidAppear:`
 *  in your `JSQMessagesViewController` subclass.
 *
 *  @warning Though this feature is mostly stable, it is still considered an experimental feature.
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
 *  @discussion The default value is the preferred system font for `UIFontTextStyleBody`. This value must not be `nil`.
 */
@property (strong, nonatomic) UIFont *messageBubbleFont;

/**
 *  The horizontal spacing used to lay out the `messageBubbleContainerView` frame within each `JSQMessagesCollectionViewCell`.
 *  This container view holds the message bubble image and message contents of a cell.
 *
 *  This value specifies the horizontal spacing between the `messageBubbleContainerView` and
 *  the edge of the collection view cell in which it is displayed. That is, the edge that is opposite the avatar image.
 *
 *  @discussion The default value is `40.0f` on iPhone and `240.0f` on iPad. This value must be positive.
 *  For *outgoing* messages, this value specifies the amount of spacing from the left most 
 *  edge of the collectionView to the left most edge of a message bubble within a cell.
 *
 *  For *incoming* messages, this value specifies the amount of spacing from the right most 
 *  edge of the collectionView to the right most edge of a message bubble within a cell.
 *
 *  @warning This value may not be exact when the layout object finishes laying out its items, due to the constraints it must satisfy. 
 *  This value should be considered more of a recommendation or suggestion to the layout, not an exact value.
 *
 *  @see JSQMessagesCollectionViewCellIncoming.
 *  @see JSQMessagesCollectionViewCellOutgoing.
 */
@property (assign, nonatomic) CGFloat messageBubbleLeftRightMargin;

/**
 *  The inset of the frame of the text view within the `messageBubbleContainerView` of each `JSQMessagesCollectionViewCell`.
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
 *  3. The top value insets the top of the frame.
 *
 *  4. The bottom value insets the bottom of the frame.
 *
 *  @discussion The default value is `{0.0f, 0.0f, 0.0f, 6.0f}`.
 *
 *  @warning Adjusting this value is an advanced endeavour and not recommended. 
 *  You will only need to adjust this value should you choose to provide your own bubble image assets.
 *  Changing this value may also require you to manually calculate the itemSize for each cell 
 *  in the layout by overriding the delegate method `collectionView:layout:sizeForItemAtIndexPath:`
 */
@property (assign, nonatomic) UIEdgeInsets messageBubbleTextViewFrameInsets;

/**
 *  The inset of the text container's layout area within the text view's content area in each `JSQMessagesCollectionViewCell`. 
 *  The specified inset values should be positive.
 *
 *  @discussion The default value is `{7.0f, 14.0f, 7.0f, 14.0f}`.
 *
 *  @warning Adjusting this value is an advanced endeavour and not recommended. 
 *  You will only need to adjust this value should you choose to provide your own bubble image assets.
 *  Changing this value may also require you to manually calculate the itemSize for each cell
 *  in the layout by overriding the delegate method `collectionView:layout:sizeForItemAtIndexPath:`
 */
@property (assign, nonatomic) UIEdgeInsets messageBubbleTextViewTextContainerInsets;

/**
 *  The size of the avatar image view for incoming messages.
 *
 *  @discussion The default value is `(30.0f, 30.0f)`. Set to `CGSizeZero` to remove incoming avatars.
 *  You may use `kJSQMessagesCollectionViewAvatarSizeDefault` to size your avatars to the default value.
 */
@property (assign, nonatomic) CGSize incomingAvatarViewSize;

/**
 *  The size of the avatar image view for outgoing messages.
 *
 *  @discussion The default value is `(30.0f, 30.0f)`. Set to `CGSizeZero` to remove outgoing avatars.
 *  You may use `kJSQMessagesCollectionViewAvatarSizeDefault` to size your avatars to the default value.
 */
@property (assign, nonatomic) CGSize outgoingAvatarViewSize;

/**
 *  The maximum number of items that the layout should keep in its cache of layout information.
 *
 *  @discussion The default value is `200`. A limit of `0` means no limit. This is not a strict limit.
 */
@property (assign, nonatomic) NSUInteger cacheLimit;

/**
 *  Computes and returns the size of the `messageBubbleImageView` property of a `JSQMessagesCollectionViewCell`
 *  at the specified indexPath.
 *
 *  @param indexPath The index path of the item to be displayed.
 *
 *  @return The size of the message bubble for the item displayed at indexPath.
 *
 *  @discussion The layout uses its `bubbleSizeCalculator` object to perform this computation.
 *  The returned size contains the required dimensions to display the entire message contents.
 *  Note, this is *not* the entire cell, but only its message bubble.
 */
- (CGSize)messageBubbleSizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Computes and returns the size of the item specified by indexPath.
 *
 *  @param indexPath The index path of the item to be displayed.
 *
 *  @return The size of the item displayed at indexPath.
 */
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
