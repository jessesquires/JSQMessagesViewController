//
//  UIImage+JSMessagesView.m
//  MessagesDemo
//
//  Created by Jesse Squires on 11/3/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "UIImage+JSMessagesView.h"

@implementation UIImage (JSMessagesView)

- (UIImage *)js_imageFlippedHorizontal
{
    return [UIImage imageWithCGImage:self.CGImage
                               scale:self.scale
                         orientation:UIImageOrientationUpMirrored];
}

- (UIImage *)js_stretchableImageWithCapInsets:(UIEdgeInsets)capInsets
{
    return [self resizableImageWithCapInsets:capInsets
                                resizingMode:UIImageResizingModeStretch];
}

@end
