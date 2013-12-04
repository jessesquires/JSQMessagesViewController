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

@interface UIColor (JSMessagesView)

#pragma mark - Colors

+ (UIColor *)js_backgroundColorClassic;
+ (UIColor *)js_messagesTimestampColorClassic;

#pragma mark - Bubble colors

+ (UIColor *)js_bubbleGreenColor;
+ (UIColor *)js_bubbleBlueColor;
+ (UIColor *)js_bubbleLightGrayColor;

#pragma mark - Utilities

- (UIColor *)js_darkenColorWithValue:(CGFloat)value;

@end