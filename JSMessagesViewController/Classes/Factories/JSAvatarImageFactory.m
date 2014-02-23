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

#import "JSAvatarImageFactory.h"
#import "UIImage+JSMessagesView.h"

CGFloat const kJSAvatarImageSize = 50.0f;

@implementation JSAvatarImageFactory

+ (UIImage *)avatarImage:(UIImage *)originalImage
         croppedToCircle:(BOOL)croppedToCircle
{
    return [originalImage js_imageAsCircle:croppedToCircle
                               withDiamter:kJSAvatarImageSize
                               borderColor:nil
                               borderWidth:0.0f
                              shadowOffSet:CGSizeZero];
}

@end
