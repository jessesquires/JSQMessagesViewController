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
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>

@interface JSQMessagesAvatarFactory : NSObject

/**
*  Returns a copy of the image object associated with the specified originalImage that is cropped to a circle with the given diameter.
*
*  @param originalImage The origin image object from which an avatar is created.
*  @param diameter      An integer value specifying the diameter size of the avatar in points.
*
*  @return A new avatar image object for the specified originalImage that is cropped to a circle with the given diameter, or `nil` if originalImage is not a valid, initialized image object.
*/
+ (UIImage *)avatarWithImage:(UIImage *)originalImage diameter:(NSUInteger)diameter;

@end
