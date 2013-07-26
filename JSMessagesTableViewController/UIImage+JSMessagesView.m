//
//  UIImage+JSMessagesView.m
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

#import "UIImage+JSMessagesView.h"

@implementation UIImage (JSMessagesView)

#pragma mark - Input bar
+ (UIImage *)inputBar
{
    return [[UIImage imageNamed:@"input-bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)];
}

+ (UIImage *)inputField
{
    return [[UIImage imageNamed:@"input-field"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 12.0f, 18.0f, 18.0f)];
}

#pragma mark - Bubble cap insets
- (UIImage *)makeStretchableDefaultIncoming
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)makeStretchableDefaultOutgoing
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)makeStretchableSquareIncoming
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 25.0f, 16.0f, 23.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)makeStretchableSquareOutgoing
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 16.0f, 25.0f)
                                resizingMode:UIImageResizingModeStretch];
}

#pragma mark - Incoming message bubbles
+ (UIImage *)bubbleDefaultIncoming
{
    return [[UIImage imageNamed:@"bubble-default-incoming"] makeStretchableDefaultIncoming];
}

+ (UIImage *)bubbleDefaultIncomingSelected
{
    return [[UIImage imageNamed:@"bubble-default-incoming-selected"] makeStretchableDefaultIncoming];
}

+ (UIImage *)bubbleDefaultIncomingGreen
{
    return [[UIImage imageNamed:@"bubble-default-incoming-green"] makeStretchableDefaultIncoming];
}

+ (UIImage *)bubbleSquareIncoming
{
    return [[UIImage imageNamed:@"bubble-square-incoming"] makeStretchableSquareIncoming];
}

+ (UIImage *)bubbleSquareIncomingSelected
{
    return [[UIImage imageNamed:@"bubble-square-incoming-selected"] makeStretchableSquareIncoming];
}

#pragma mark - Outgoing message bubbles
+ (UIImage *)bubbleDefaultOutgoing
{
    return [[UIImage imageNamed:@"bubble-default-outgoing"] makeStretchableDefaultOutgoing];
}

+ (UIImage *)bubbleDefaultOutgoingSelected
{
    return [[UIImage imageNamed:@"bubble-default-outgoing-selected"] makeStretchableDefaultOutgoing];
}

+ (UIImage *)bubbleDefaultOutgoingGreen
{
    return [[UIImage imageNamed:@"bubble-default-outgoing-green"] makeStretchableDefaultOutgoing];
}

+ (UIImage *)bubbleSquareOutgoing
{
    return [[UIImage imageNamed:@"bubble-square-outgoing"] makeStretchableSquareOutgoing];
}

+ (UIImage *)bubbleSquareOutgoingSelected
{
    return [[UIImage imageNamed:@"bubble-square-outgoing-selected"] makeStretchableSquareOutgoing];
}

@end
