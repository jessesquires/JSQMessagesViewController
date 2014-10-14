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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  `JSQMessagesAvatarFactory` is a factory that provides a means for creating and styling avatar images 
 *  to be displayed in a `JSQMessagesCollectionViewCell` of a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesAvatarFactory : NSObject

/**
*  Returns a copy of the image object associated with the specified originalImage that is 
*  cropped to a circle with the given diameter.
*
*  @param originalImage The origin image object from which an avatar is created. This value must not be `nil`.
*  @param diameter      An integer value specifying the diameter size of the avatar in points. This value must be greater than `0.0f`.
*
*  @return A new avatar image object for the specified originalImage that is cropped to a circle 
*  with the given diameter, or `nil` if originalImage is not a valid, initialized image object.
*/
+ (UIImage *)avatarWithImage:(UIImage *)originalImage diameter:(NSUInteger)diameter;

/**
 *  Returns an image object with a circular shape that displays the specified userInitials 
 *  with the given backgroundColor, textColor, font, and diameter.
 *
 *  @param userInitials    The user initials to display in the avatar image. This value must not be `nil`.
 *  @param backgroundColor The background color of the avatar. This value must not be `nil`.
 *  @param textColor       The color of the text of the userInitials. This value must not be `nil`.
 *  @param font            The font applied to userInitials. This value must not be `nil`.
 *  @param diameter        The diameter of the avatar image. This value must be greater than `0.0f`.
 *
 *  @return A new avatar image object having the specified attributes if created successfully, otherwise `nil`.
 *
 *  @discussion This method does not attempt to detect or correct incompatible parameters. 
 *  That is to say, you are responsible for providing a font size and diameter that sense. 
 *  For example a font size of `14.0f` and a diameter of `34.0f` will result in an avatar similar to Messages in iOS 7. 
 *  However, a font size `30.0f` and diameter of `10.0f` will not produce a desirable image.
 *  Further, this method does not check the length of userInitials. It is recommended that you pass a string of length `2` or `3`.
 */
+ (UIImage *)avatarWithUserInitials:(NSString *)userInitials
                    backgroundColor:(UIColor *)backgroundColor
                          textColor:(UIColor *)textColor
                               font:(UIFont *)font
                           diameter:(NSUInteger)diameter;

@end
