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
#import "JSBubbleImageViewFactory.h"

/**
 *  An instance of JSBubbleView is a means for displaying text in a speech bubble image to be placed in a JSBubbleMessageCell. 
 *  @see JSBubbleMessageCell.
 */
@interface JSBubbleView : UIView

/**
 *  Returns the message type for this bubble view.
 *  @see JSBubbleMessageType for descriptions of the constants used to specify bubble message type.
 */
@property (assign, nonatomic, readonly) JSBubbleMessageType type;

/**
 *  Returns the image view containing the bubble image for this bubble view.
 */
@property (weak, nonatomic, readonly) UIImageView *bubbleImageView;

/**
 *  Returns the text view containing the message text for this bubble view.
 */
@property (weak, nonatomic, readonly) UITextView *textView;

#pragma mark - Initialization

/**
 *  Initializes and returns a bubble view object having the given frame, bubble type, and bubble image view.
 *
 *  @param frame           A rectangle specifying the initial location and size of the bubble view in its superview's coordinates.
 *  @param bubleType       A constant that specifies the type of the bubble view. @see JSBubbleMessageType.
 *  @param bubbleImageView An image view initialized with an image and highlighted image for this bubble view. @see JSBubbleImageViewFactory.
 *
 *  @return An initialized `JSBubbleView` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithFrame:(CGRect)frame
                   bubbleType:(JSBubbleMessageType)bubleType
              bubbleImageView:(UIImageView *)bubbleImageView;

#pragma mark - Setters

/**
 *  Sets the given text for the bubble view, resizing its frame as needed.
 *
 *  @param text The message text to be displayed in the bubble view.
 */
- (void)setText:(NSString *)text;

/**
 *  Sets the given font for the bubble view text, resizing its frame as needed.
 *
 *  @param font The message font to be used for the text displayed in the bubble view.
 */
- (void)setFont:(UIFont *)font;

/**
 *  Sets the given color for the text in the bubble view.
 *
 *  @param textColor The color to used for the text displayed in the bubble view.
 */
- (void)setTextColor:(UIColor *)textColor;

#pragma mark - Getters

/**
 *  @return The text for the bubble view.
 */
- (NSString *)text;

/**
 *  @return The font for the bubble view.
 */
- (UIFont *)font;

/**
 *  @return The text color for the bubble view.
 */
- (UIColor *)textColor;

/**
 *  The bubble view's frame rectangle is computed and set based on the size of the text that it needs to display.
 *
 *  @return The frame of the bubble view.
 */
- (CGRect)bubbleFrame;

/**
 *  The bubble view's height is the height of its frame plus padding for its displayed text.
 *
 *  @return The minimum required value for the height of the bubble view.
 */
- (CGFloat)neededHeightForCell;

@end