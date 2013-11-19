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

#import <UIKit/UIKit.h>

@interface UIImage (JSMessagesView)

- (UIImage *)js_imageFlippedHorizontal;

- (UIImage *)js_stretchableImageWithCapInsets:(UIEdgeInsets)capInsets;

- (UIImage *)js_imageAsCircle:(BOOL)clipToCircle
                  withDiamter:(CGFloat)diameter
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 shadowOffSet:(CGSize)shadowOffset;

- (UIImage *)js_imageMaskWithColor:(UIColor *)maskColor;

@end
