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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JSQMessagesBubbleImage.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  `JSQMessagesBubbleImageFactory` is a factory that provides a means for creating and styling 
 *  `JSQMessagesBubbleImage` objects to be displayed in a `JSQMessagesCollectionViewCell` of a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesBubbleImageFactory : NSObject

/**
 * Specifies the layout direction of the message bubble. The default value is initialized
 * from `[UIApplication sharedApplication]`.
 */
@property (nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

/**
 *  Creates and returns a new instance of `JSQMessagesBubbleImageFactory` that uses the
 *  default bubble image assets, cap insets, and layout direction.
 *
 *  @return An initialized `JSQMessagesBubbleImageFactory` object.
 */
- (instancetype)init;

/**
 *  Creates and returns a new instance of `JSQMessagesBubbleImageFactory` having the specified
 *  bubbleImage and capInsets. These values are used internally in the factory to produce
 *  `JSQMessagesBubbleImage` objects.
 *
 *  @param bubbleImage A template bubble image from which all images will be generated.
 *  The image should represent the *outgoing* message bubble image, which will be flipped
 *  horizontally for generating the corresponding *incoming* message bubble images. This value must not be `nil`.
 *
 *  @param capInsets   The values to use for the cap insets that define the unstretchable regions of the image.
 *  Specify `UIEdgeInsetsZero` to have the factory create insets that allow the image to stretch from its center point.
 *
 *  @return An initialized `JSQMessagesBubbleImageFactory`.
 */

- (instancetype)initWithBubbleImage:(UIImage *)bubbleImage
                          capInsets:(UIEdgeInsets)capInsets
                    layoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection;

/**
 *  Creates and returns a `JSQMessagesBubbleImage` object with the specified color for *outgoing* message image bubbles.
 *  The `messageBubbleImage` property of the `JSQMessagesBubbleImage` is configured with a flat bubble image, masked to the given color.
 *  The `messageBubbleHighlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessagesBubbleImage` object.
 */
- (JSQMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color;

/**
 *  Creates and returns a `JSQMessagesBubbleImage` object with the specified color for *incoming* message image bubbles.
 *  The `messageBubbleImage` property of the `JSQMessagesBubbleImage` is configured with a flat bubble image, masked to the given color.
 *  The `messageBubbleHighlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessagesBubbleImage` object.
 */
- (JSQMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
