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

#import <Foundation/Foundation.h>

/**
 *  A constant defining the size of an avatar image.
 */
extern CGFloat const kJSAvatarImageSize;

/**
 *  `JSAvatarImageFactory` is a factory that provides a means for styling avatar images to be displayed in a `JSBubbleMessageCell` of a `JSMessagesViewController`.
 */
@interface JSAvatarImageFactory : NSObject

/**
 *  Returns the image object associated with the specified filename. The image is cropped to a circle if the value of croppedToCircle is `YES`, otherwise the image is cropped to a square. The image has a flat, iOS 7 appearance.
 *
 *  @param filename The name of the file. If this is the first time the image is being loaded, the method looks for an image with the specified name in the application’s main bundle.
 *  @param croppedToCircle A boolean value indicating whether or not the image should be cropped as a circle or square. Pass `YES` to crop to a circle, and `NO` to crop to a square.
 *
 *  @return The image object for the specified file (cropped as specified), or `nil` if the method could not find the specified image.
 */
+ (UIImage *)avatarImageNamed:(NSString *)filename
              croppedToCircle:(BOOL)croppedToCircle;

/**
 * Returns a copy of the image object associated with the specified originalImage. The image is cropped to a circle if the value of croppedToCircle is `YES`, otherwise the image is cropped to a square. The image has a flat, iOS 7 appearance.
 *
 *  @param originalImage The origin image object to be styled for an avatar.
 *  @param croppedToCircle A boolean value indicating whether or not the image should be cropped as a circle or square. Pass `YES` to crop to a circle, and `NO` to crop to a square.
 *
 *  @return A new image object for the specified originalImage (cropped as specified), or `nil` if originalImage is not a valid, initialized image object.
*/
+ (UIImage *)avatarImage:(UIImage *)originalImage
         croppedToCircle:(BOOL)croppedToCircle;

/**
 *  Returns the image object associated with the specified filename. The image is cropped to a circle if the value of croppedToCircle is `YES`, otherwise the image is cropped to a square. The image has a glossy, iOS 6 appearance.
 *
 *  @param filename The name of the file. If this is the first time the image is being loaded, the method looks for an image with the specified name in the application’s main bundle.
 *  @param croppedToCircle A boolean value indicating whether or not the image should be cropped as a circle or square. Pass `YES` to crop to a circle, and `NO` to crop to a square.
 *
 *  @return The image object for the specified file (cropped as specified), or `nil` if the method could not find the specified image.
 */
+ (UIImage *)classicAvatarImageNamed:(NSString *)filename
                     croppedToCircle:(BOOL)croppedToCircle;

@end
