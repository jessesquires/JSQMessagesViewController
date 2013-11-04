//
//  UIImage+JSMessagesInputBar.m
//  MessagesDemo
//
//  Created by Jesse Squires on 10/20/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "UIImage+JSMessagesInputBar.h"

@implementation UIImage (JSMessagesInputBar)

+ (UIImage *)js_inputBar_iOS6
{
    return [[UIImage imageNamed:@"input-bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)];
}

+ (UIImage *)js_inputField_iOS6
{
    return [[UIImage imageNamed:@"input-field"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 12.0f, 18.0f, 18.0f)];
}

@end
