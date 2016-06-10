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

#import "JSQMessagesAvatarImage.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  `JSQMessagesAvatarImageFactory` is a factory that provides a means for creating and styling
 *  `JSQMessagesAvatarImage` objects to be displayed in a `JSQMessagesCollectionViewCell` of a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesAvatarImageFactory : NSObject

/**
 *  Creates and returns a new instance of `JSQMessagesAvatarImageFactory` that uses
 *  the default diameter for creating avatars.
 *
 *  @return An initialized `JSQMessagesAvatarImageFactory` object.
 */
- (instancetype)init;

/**
 *  Creates and returns a new instance of `JSQMessagesAvatarImageFactory` that uses
 *  the specified diameter for creating avatars.
 *
 *  @param diameter An integer value specifying the diameter size of the image in points. This value must be greater than `0`.
 *
 *  @return An initialized `JSQMessagesAvatarImageFactory` object.
 */
- (instancetype)initWithDiameter:(NSUInteger)diameter NS_DESIGNATED_INITIALIZER;

/**
*  Creates and returns a `JSQMessagesAvatarImage` object with the specified placeholderImage that is
*  cropped to a circle of the given diameter.
*
*  @param placeholderImage An image object that represents a placeholder avatar image. This value must not be `nil`.
*
*  @return An initialized `JSQMessagesAvatarImage` object.
*/
- (JSQMessagesAvatarImage *)avatarImageWithPlaceholder:(UIImage *)placeholderImage;

/**
 *  Creates and returns a `JSQMessagesAvatarImage` object with the specified image that is
 *  cropped to a circle of the given diameter and used for the `avatarImage` and `avatarPlaceholderImage` properties
 *  of the returned `JSQMessagesAvatarImage` object. This image is then copied and has a transparent black mask applied to it, 
 *  which is used for the `avatarHighlightedImage` property of the returned `JSQMessagesAvatarImage` object.
 *
 *  @param image    An image object that represents an avatar image. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessagesAvatarImage` object.
 */
- (JSQMessagesAvatarImage *)avatarImageWithImage:(UIImage *)image;

/**
 *  Returns a copy of the specified image that is cropped to a circle with the given diameter.
 *
 *  @param image    The image to crop. This value must not be `nil`.
 *
 *  @return A new image object.
 */
- (UIImage *)circularAvatarImage:(UIImage *)image;

/**
 *  Returns a copy of the specified image that is cropped to a circle with the given diameter.
 *  Additionally, a transparent overlay is applied to the image to represent a pressed or highlighted state.
 *
 *  @param image    The image to crop. This value must not be `nil`.
 *
 *  @return A new image object.
 */
- (UIImage *)circularAvatarHighlightedImage:(UIImage *)image;

/**
 *  Creates and returns a `JSQMessagesAvatarImage` object with a circular shape that displays the specified userInitials
 *  with the given backgroundColor, textColor, font, and diameter.
 *
 *  @param userInitials    The user initials to display in the avatar image. This value must not be `nil`.
 *  @param backgroundColor The background color of the avatar. This value must not be `nil`.
 *  @param textColor       The color of the text of the userInitials. This value must not be `nil`.
 *  @param font            The font applied to userInitials. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessagesAvatarImage` object.
 *
 *  @discussion This method does not attempt to detect or correct incompatible parameters. 
 *  That is to say, you are responsible for providing a font size and diameter that make sense.
 *  For example, a font size of `14.0f` and a diameter of `34.0f` will result in an avatar similar to Messages in iOS 7. 
 *  However, a font size `30.0f` and diameter of `10.0f` will not produce a desirable image.
 *  Further, this method does not check the length of userInitials. It is recommended that you pass a string of length `2` or `3`.
 */
- (JSQMessagesAvatarImage *)avatarImageWithUserInitials:(NSString *)userInitials
                                        backgroundColor:(UIColor *)backgroundColor
                                              textColor:(UIColor *)textColor
                                                   font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
