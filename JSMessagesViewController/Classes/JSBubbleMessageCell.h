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
#import "JSBubbleView.h"
#import "JSMessageData.h"

/**
 *  The `JSBubbleMessageCell` class defines the attributes and behavior of the cells that appear in `JSMessagesViewController`. This class includes properties and methods for setting and managing cell content.
 */
@interface JSBubbleMessageCell : UITableViewCell

/**
 *  Returns the bubble view used in the cell. JSBubbleMessageCell adds the appropriate bubble view when you create the cell with a given cell type and bubbleImageView. This property is never `nil`. 
 *  @see JSBubbleView. 
 *  @see JSBubbleMessageType.
 */
@property (weak, nonatomic, readonly) JSBubbleView *bubbleView;

/**
 *  Returns the label used to display the timestamp for the cell. This property may be `nil` if no timestamp is provided. 
 *  @see JSMessagesViewDataSource.
 */
@property (weak, nonatomic, readonly) UILabel *timestampLabel;

/**
 *  Returns the image view used to display the avatar for the cell. This property may be `nil` if no avatar is provided. 
 *  @see JSMessagesViewDataSource.
 */
@property (weak, nonatomic, readonly) UIImageView *avatarImageView;

/**
 *  Returns the label used to display the subtitle for the cell. This property may be `nil` if no subtitle is provided. 
 *  @see JSMessagesViewDataSource.
 */
@property (weak, nonatomic, readonly) UILabel *subtitleLabel;

#pragma mark - Initialization

/**
 *  Initializes a message cell and returns it to the caller.
 *
 *  @param type              A constant indicating a message type. @see JSBubbleMessageType for details.
 *  @param bubbleImageView   An image view initialized with bubble images. The `UIImageView` properties `image` and `highlightedImage` must not be `nil`. @see JSBubbleImageViewFactory.
 *  @param message           An object that conforms to the `JSMessageData` protocol containing the message data for the cell.
 *  @param displaysTimestamp A boolean value indicating whether or not the cell should display the date contained in message. Pass `YES` to display a timestamp, `NO` otherwise.
 *  @param hasAvatar         A boolean value indicating whether or not the cell should be initialized with an avatarImageView. Pass `YES` to initialize with an avatar, `NO` otherwise.
 *  @param reuseIdentifier   A string used to identify the cell object to be reused for drawing multiple rows of a JSMessagesViewController. This property must not be `nil`.
 *
 *  @return An initialized `JSBubbleMessageCell` object or `nil` if the object could not be created.
 */
- (instancetype)initWithBubbleType:(JSBubbleMessageType)type
                   bubbleImageView:(UIImageView *)bubbleImageView
                           message:(id<JSMessageData>)message
                 displaysTimestamp:(BOOL)displaysTimestamp
                         hasAvatar:(BOOL)hasAvatar
                   reuseIdentifier:(NSString *)reuseIdentifier;

#pragma mark - Setters

/**
 *  Sets the message object for the cell.
 *
 *  @param message An object that conforms to the `JSMessageData` protocol containing the message data for the cell.
 */
- (void)setMessage:(id<JSMessageData>)message;

/**
 *  Sets the imageView for the avatarImageView of the cell. The frame is set for you by `JSBubbleMessageCell`.
 *
 *  @param imageView An imageView containing an avatar image. The `image` property of the `UIImageView` must not be `nil`.
 */
- (void)setAvatarImageView:(UIImageView *)imageView;

#pragma mark - Getters

/**
 *  Returns a contant indicating the message type for the cell. 
 *  @see JSBubbleMessageType.
 *
 *  @return A contant indicating the message type.
 */
- (JSBubbleMessageType)messageType;

#pragma mark - Class methods

/**
 *  Computes and returns the minimum necessary height of a `JSBubbleMessageCell` needed to display its contents.
 *
 *  @param message   An object that conforms to the `JSMessageData` protocol to display in the cell.
 *  @param hasAvatar A boolean value indicating whether or not the cell has an avatar.
 *
 *  @return The height required for the frame of the cell in order for the cell to display the entire contents of its subviews.
 */
+ (CGFloat)neededHeightForBubbleMessageCellWithMessage:(id<JSMessageData>)message
                                                avatar:(BOOL)hasAvatar;

@end