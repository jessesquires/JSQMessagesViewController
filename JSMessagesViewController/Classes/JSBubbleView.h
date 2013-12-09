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
 *
 *  @warning You may customize the propeties of textView, however you *must not* change its `font` property directly. Please use the `JSBubbleView` font property instead.
 */
@property (weak, nonatomic, readonly) UITextView *textView;

/**
 *  The font for the text contained in the bubble view. The default value is `[UIFont systemFontOfSize:16.0f]`.
 *
 *  @warning You must set this propety via `UIAppearance` only. *DO NOT set this property directly*.
 *  @bug Setting this property directly, rather than via `UIAppearance` will cause the message bubbles and text to be laid out incorrectly.
 */
@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;

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

#pragma mark - Getters

/**
 *  The bubble view's frame rectangle is computed and set based on the size of the text that it needs to display.
 *
 *  @return The frame of the bubble view.
 */
- (CGRect)bubbleFrame;

#pragma mark - Class methods

/**
 *  Computes and returns the minimum necessary height of a `JSBubbleView` needed to display the given text.
 *
 *  @param text The text to display in the bubble view.
 *
 *  @return The height required for the frame of the bubble view in order to display the given text.
 */
+ (CGFloat)neededHeightForText:(NSString *)text;

@end