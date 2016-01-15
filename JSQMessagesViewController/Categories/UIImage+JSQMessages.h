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

@interface UIImage (JSQMessages)

/**
 *  Creates and returns a new image object that is masked with the specified mask color.
 *
 *  @param maskColor The color value for the mask. This value must not be `nil`.
 *
 *  @return A new image object masked with the specified color.
 */
- (UIImage *)jsq_imageMaskedWithColor:(UIColor *)maskColor;

/**
 *  @return The regular message bubble image.
 */
+ (UIImage *)jsq_bubbleRegularImage;

/**
 *  @return The regular message bubble image without a tail.
 */
+ (UIImage *)jsq_bubbleRegularTaillessImage;

/**
 *  @return The regular message bubble image stroked, not filled.
 */
+ (UIImage *)jsq_bubbleRegularStrokedImage;

/**
 *  @return The regular message bubble image stroked, not filled and without a tail.
 */
+ (UIImage *)jsq_bubbleRegularStrokedTaillessImage;

/**
 *  @return The compact message bubble image. 
 *
 *  @discussion This is the default bubble image used by `JSQMessagesBubbleImageFactory`.
 */
+ (UIImage *)jsq_bubbleCompactImage;

/**
 *  @return The compact message bubble image without a tail.
 */
+ (UIImage *)jsq_bubbleCompactTaillessImage;

/**
 *  @return The default input toolbar accessory image.
 */
+ (UIImage *)jsq_defaultAccessoryImage;

/**
 *  @return The default typing indicator image.
 */
+ (UIImage *)jsq_defaultTypingIndicatorImage;

/**
 *  @return The default play icon image.
 */
+ (UIImage *)jsq_defaultPlayImage;

@end
