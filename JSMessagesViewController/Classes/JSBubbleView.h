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
#import "JSMessage.h"


/**
 *  An instance of JSBubbleView is a means for displaying text in a speech bubble image to be placed in a JSBubbleMessageCell. 
 *  @see JSBubbleMessageCell.
 */
@interface JSBubbleView : UIView

@property (weak, nonatomic) JSMessage *message;
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

/**
 *  Returns the image view containing the attached image for this bubble view.
 */
@property (strong, nonatomic, readonly) UIImageView *attachedImageView;

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
 *  Sets a given Image for the bubble view, resizing its frame as needed.
 *
 *  @param image The message attached Image to be displayed in the bubble view.
 */
- (void)setMessageImage:(UIImage *)image;


#pragma mark - Getters

/**
 *  The bubble view's frame rectangle is computed and set based on the size of the text that it needs to display.
 *
 *  @return The frame of the bubble view.
 */
- (CGRect)bubbleFrame;

#pragma mark - Class methods

/**
 *  Computes and returns the minimum necessary size of a `JSBubbleView` needed to display the given text AND/OR Image.
 *
 *  @param msg The JSMessage Data to be displayed inside the bubble view.
 *
 *  @return The size required for the frame of the bubble view in order to display the given text and/or Image.
 */
+ (CGSize)neededSizeForMessage:(JSMessage*) msg;


/**
 *  Asks the BubbleView for showing weather it contains attached Image or not.
 *
 *  @return A Bool.
 */
- (BOOL)isImageMessage;

- (void)setPlayButtonOverlay;

@end