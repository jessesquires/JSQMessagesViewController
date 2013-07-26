//
//  UIImage+JSMessagesView.h
//
//  Created by Jesse Squires on 7/25/13.
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

#import <UIKit/UIKit.h>

@interface UIImage (JSMessagesView)

#pragma mark - Avatar styles
- (UIImage *)circleImageWithSize:(CGFloat)size;
- (UIImage *)squareImageWithSize:(CGFloat)size;

- (UIImage *)imageAsCircle:(BOOL)clipToCircle
               withDiamter:(CGFloat)diameter
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
              shadowOffSet:(CGSize)shadowOffset;

#pragma mark - Input bar
+ (UIImage *)inputBar;
+ (UIImage *)inputField;

#pragma mark - Bubble cap insets
- (UIImage *)makeStretchableDefaultIncoming;
- (UIImage *)makeStretchableDefaultOutgoing;

- (UIImage *)makeStretchableSquareIncoming;
- (UIImage *)makeStretchableSquareOutgoing;

#pragma mark - Incoming message bubbles
+ (UIImage *)bubbleDefaultIncoming;
+ (UIImage *)bubbleDefaultIncomingSelected;

+ (UIImage *)bubbleDefaultIncomingGreen;

+ (UIImage *)bubbleSquareIncoming;
+ (UIImage *)bubbleSquareIncomingSelected;

#pragma mark - Outgoing message bubbles
+ (UIImage *)bubbleDefaultOutgoing;
+ (UIImage *)bubbleDefaultOutgoingSelected;

+ (UIImage *)bubbleDefaultOutgoingGreen;

+ (UIImage *)bubbleSquareOutgoing;
+ (UIImage *)bubbleSquareOutgoingSelected;

@end
