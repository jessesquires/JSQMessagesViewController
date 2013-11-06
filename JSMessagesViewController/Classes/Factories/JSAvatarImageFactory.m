//
//  Created by Jesse Squires on 11/3/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
