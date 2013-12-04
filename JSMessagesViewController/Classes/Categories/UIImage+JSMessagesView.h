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

@interface UIImage (JSMessagesView)

/**
 *  Creates and returns an image object that is a copy of the receiver and flipped horizontally.
 *
 *  @return A new image object.
 */
- (UIImage *)js_imageFlippedHorizontal;

/**
 *  Creates and returns a new stretchable image object with the specified cap insets.
 *
 *  @param capInsets The values to use for the cap insets.
 *
 *  @return A new image object with the specified cap insets and mode `UIImageResizingModeStretch`.
 */
- (UIImage *)js_stretchableImageWithCapInsets:(UIEdgeInsets)capInsets;

/**
 *  Creates and returns a new image object with the specified attributes.
 *
 *  @param clipToCircle A boolean value indicating whether or not the returned image should be cropped to a circle. Pass `YES` to crop the returned image to a circle, and `NO` to crop as a square.
 *  @param diameter     A floating point value indicating the diamater of the returned image.
 *  @param borderColor  The color with which to stroke the returned image.
 *  @param borderWidth  The width of the border of the returned image.
 *  @param shadowOffset The values for the shadow offset of the returned image.
 *
 *  @return A new image object with the specified attributes.
 *
 *  @warning This method crops a copy of the receiver into a perfect square centered on the center point of the image before applying the other attributes.
 */
- (UIImage *)js_imageAsCircle:(BOOL)clipToCircle
                  withDiamter:(CGFloat)diameter
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 shadowOffSet:(CGSize)shadowOffset;

/**
 *  Creates and returns a new image object that is masked with the specified mask color.
 *
 *  @param maskColor The color value for the mask.
 *
 *  @return A new image object masked with the specified color.
 */
- (UIImage *)js_imageMaskWithColor:(UIColor *)maskColor;

@end
