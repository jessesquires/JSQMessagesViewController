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
                        style:(JSAvatarImageStyle)style
                        shape:(JSAvatarImageShape)shape
{
    UIImage *image = [UIImage imageNamed:filename];
    
    return [image js_imageAsCircle:(shape == JSAvatarImageShapeCircle)
                       withDiamter:kJSAvatarImageSize
                       borderColor:(style == JSAvatarImageStyleClassic) ? [UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f] : nil
                       borderWidth:(style == JSAvatarImageStyleClassic) ? 1.0f : 0.0f
                      shadowOffSet:(style == JSAvatarImageStyleClassic) ? CGSizeMake(0.0f, 1.0f) : CGSizeZero];
}

@end
