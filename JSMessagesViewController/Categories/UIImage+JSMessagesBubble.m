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

#import "UIImage+JSMessagesBubble.h"

@implementation UIImage (JSMessagesBubble)

#pragma mark - Bubble cap insets

- (UIImage *)js_makeStretchableDefaultIncoming
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)js_makeStretchableDefaultOutgoing
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)js_makeStretchableSquareIncoming
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 25.0f, 16.0f, 23.0f)
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)js_makeStretchableSquareOutgoing
{
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(15.0f, 18.0f, 16.0f, 23.0f)
                                resizingMode:UIImageResizingModeStretch];
}

#pragma mark - Incoming message bubbles

+ (UIImage *)js_bubbleDefaultIncoming
{
    return [[UIImage imageNamed:@"bubble-default-incoming"] js_makeStretchableDefaultIncoming];
}

+ (UIImage *)js_bubbleDefaultIncomingSelected
{
    return [[UIImage imageNamed:@"bubble-default-incoming-selected"] js_makeStretchableDefaultIncoming];
}

+ (UIImage *)js_bubbleDefaultIncomingGreen
{
    return [[UIImage imageNamed:@"bubble-default-incoming-green"] js_makeStretchableDefaultIncoming];
}

+ (UIImage *)js_bubbleSquareIncoming
{
    return [[UIImage imageNamed:@"bubble-square-incoming"] js_makeStretchableSquareIncoming];
}

+ (UIImage *)js_bubbleSquareIncomingSelected
{
    return [[UIImage imageNamed:@"bubble-square-incoming-selected"] js_makeStretchableSquareIncoming];
}

#pragma mark - Outgoing message bubbles

+ (UIImage *)js_bubbleDefaultOutgoing
{
    return [[UIImage imageNamed:@"bubble-default-outgoing"] js_makeStretchableDefaultOutgoing];
}

+ (UIImage *)js_bubbleDefaultOutgoingSelected
{
    return [[UIImage imageNamed:@"bubble-default-outgoing-selected"] js_makeStretchableDefaultOutgoing];
}

+ (UIImage *)js_bubbleDefaultOutgoingGreen
{
    return [[UIImage imageNamed:@"bubble-default-outgoing-green"] js_makeStretchableDefaultOutgoing];
}

+ (UIImage *)js_bubbleSquareOutgoing
{
    return [[UIImage imageNamed:@"bubble-square-outgoing"] js_makeStretchableSquareOutgoing];
}

+ (UIImage *)js_bubbleSquareOutgoingSelected
{
    return [[UIImage imageNamed:@"bubble-square-outgoing-selected"] js_makeStretchableSquareOutgoing];
}

@end
