//
//  UIImage+JSMessagesView.h
//  MessagesDemo
//
//  Created by Jesse Squires on 11/3/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JSMessagesView)

- (UIImage *)js_imageFlippedHorizontal;

- (UIImage *)js_stretchableImageWithCapInsets:(UIEdgeInsets)capInsets;

@end
