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

+ (UIImage *)avatarImageNamed:(NSString *)filename
              croppedToCircle:(BOOL)croppedToCircle
{
    UIImage *image = [UIImage imageNamed:filename];
    return [self avatarImage:image croppedToCircle:croppedToCircle];
}

+ (UIImage *)avatarImage:(UIImage *)originalImage
         croppedToCircle:(BOOL)croppedToCircle
{
    return [originalImage js_imageAsCircle:croppedToCircle
                               withDiamter:kJSAvatarImageSize
                               borderColor:nil
                               borderWidth:0.0f
                              shadowOffSet:CGSizeZero];
}

+ (UIImage *)classicAvatarImageNamed:(NSString *)filename
                     croppedToCircle:(BOOL)croppedToCircle
{
    UIImage *image = [UIImage imageNamed:filename];
    return [image js_imageAsCircle:croppedToCircle
                       withDiamter:kJSAvatarImageSize
                       borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                       borderWidth:1.0f
                      shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

@end
