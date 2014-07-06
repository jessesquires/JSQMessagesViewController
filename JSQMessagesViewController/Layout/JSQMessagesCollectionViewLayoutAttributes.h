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

/**
 *  A `JSQMessagesCollectionViewLayoutAttributes` is an object that manages the layout-related attributes
 *  for a given `JSQMessagesCollectionViewCell` in a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>

/**
 *  The font used to display the body of a text message in a message bubble within a `JSQMessagesCollectionViewCell`.
 *  This value must not be `nil`.
 */
@property (strong, nonatomic) UIFont *messageBubbleFont;

/**
 *  The horizontal spacing between the message bubble and the edge of the collection 
 *  view cell in which it is displayed. This value should be greater than or equal to `0.0`.
 *
 *  @discussion For *outgoing* messages, this value specifies the amount of spacing from the left most edge
 *  of the collection view cell to the left most edge of a message bubble with in the cell.
 *
 *  For *incoming* messages, this value specifies the amount of spacing from the right most edge 
 *  of the collection view cell to the right most edge of a message bubble with in the cell.
 */
@property (assign, nonatomic) CGFloat messageBubbleLeftRightMargin;

/**
 *  The inset of the text container's layout area within the text view's content area in a `JSQMessagesCollectionViewCell`. 
 *  The specified inset values should be greater than or equal to `0.0`.
 */
@property (assign, nonatomic) UIEdgeInsets textViewTextContainerInsets;

/**
 *  The inset of the frame of the text view within a `JSQMessagesCollectionViewCell`. 
 *  
 *  @discussion The inset values should be greater than or equal to `0.0` and are applied in the following ways:
 *
 *  1. The right value insets the text view frame on the side adjacent to the avatar image 
 *  (or where the avatar would normally appear). For outgoing messages this is the right side, 
 *  for incoming messages this is the left side.
 *
 *  2. The left value insets the text view frame on the side opposite the avatar image 
 *  (or where the avatar would normally appear). For outgoing messages this is the left side, 
 *  for incoming messages this is the right side.
 *
 *  3. The top value insets the top of the frame.
 *
 *  4. The bottom value insets the bottom of the frame.
 */
@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;

/**
 *  The size of the `avatarImageView` of a `JSQMessagesCollectionViewCellIncoming` or it's subclass.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncoming`.
 */
@property (assign, nonatomic) CGSize incomingAvatarViewSize;

/**
 *  The size of the `avatarImageView` of a `JSQMessagesCollectionViewCellOutgoing` or it's subclass.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoing`.
 */
@property (assign, nonatomic) CGSize outgoingAvatarViewSize;

/**
 *  The size of the `thumbnailImageView` of a `JSQMessagesCollectionViewCellIncomingPhoto`.
 *  The size values should be greater than `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncomingPhoto`.
 */
@property (assign, nonatomic) CGSize incomingThumbnailImageSize;

/**
 *  The size of the `thumbnailImageView` of a `JSQMessagesCollectionViewCellOutgoingPhoto`.
 *  The size values should be greater than `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoingPhoto`.
 */
@property (assign, nonatomic) CGSize outgoingThumbnailImageSize;

/**
 *  The size of the `thumbnailImageView` of a `JSQMessagesCollectionViewCellIncomingVideo`.
 *  The size values should be greater than `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncomingVideo`.
 */
@property (assign, nonatomic) CGSize incomingVideoThumbnailSize;

/**
 *  The size of the `thumbnailImageView` of a `JSQMessagesCollectionViewCellOutgoingVideo`.
 *  The size values should be greater than `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoingVideo`.
 */
@property (assign, nonatomic) CGSize outgoingVideoThumbnailSize;

/**
 *  The size of the `playerView` of a `JSQMessagesCollectionViewCellIncomingAudio`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncomingAudio`.
 */
@property (assign, nonatomic) CGSize incomingAudioPlayerViewSize;

/**
 *  The size of the `playerView` of a `JSQMessagesCollectionViewCellOutgoingAudio`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoingAudio`.
 */
@property (assign, nonatomic) CGSize outgoingAudioPlayerViewSize;

/**
 *	The size of the `overlayView` of a `JSQMessagesCollectionViewCellIncomingVideo`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncomingVideo`.
 */
@property (assign, nonatomic) CGSize incomingVideoOverlayViewSize;

/**
 *	The size of the `overlayView` of a `JSQMessagesCollectionViewCellOutgoingVideo`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoingVideo`
 */
@property (assign, nonatomic) CGSize outgoingVideoOverlayViewSize;

/**
 *  The size of the `activityIndicatorView` of a `JSQMessagesCollectionViewCellIncomingPhoto`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncomingPhoto`.
 */
@property (assign, nonatomic) CGSize incomingPhotoActivityIndicatorViewSize;

/**
 *  The size of the `activityIndicatorView` of a `JSQMessagesCollectionViewCellOutgoingPhoto`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoingPhoto`.
 */
@property (assign, nonatomic) CGSize outgoingPhotoActivityIndicatorViewSize;

/**
 *  The size of the `activityIndicatorView` of a `JSQMessagesCollectionViewCellIncomingVideo`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncomingVideo`.
 */
@property (assign, nonatomic) CGSize incomingVideoActivityIndicatorViewSize;

/**
 *  The size of the `activityIndicatorView` of a `JSQMessagesCollectionViewCellOutgoingVideo`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoingVideo`.
 */
@property (assign, nonatomic) CGSize outgoingVideoActivityIndicatorViewSize;

/**
 *  The size of the `activityIndicatorView` of a `JSQMessagesCollectionViewCellIncomingAudio`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellIncomingAudio`.
 */
@property (assign, nonatomic) CGSize incomingAudioActivityIndicatorViewSize;

/**
 *  The size of the `activityIndicatorView` of a `JSQMessagesCollectionViewCellOutgoingAudio`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCellOutgoingAudio`.
 */
@property (assign, nonatomic) CGSize outgoingAudioActivityIndicatorViewSize;

/**
 *  The height of the `cellTopLabel` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
@property (assign, nonatomic) CGFloat cellTopLabelHeight;

/**
 *  The height of the `messageBubbleTopLabel` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
@property (assign, nonatomic) CGFloat messageBubbleTopLabelHeight;

/**
 *  The height of the `cellBottomLabel` of a `JSQMessagesCollectionViewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
@property (assign, nonatomic) CGFloat cellBottomLabelHeight;

@end
