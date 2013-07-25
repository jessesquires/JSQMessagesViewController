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
+ (UIImage *)inputBarImage
{
    return [[UIImage imageNamed:@"input-bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)];
}

+ (UIImage *)inputFieldImage
{
    return [[UIImage imageNamed:@"input-field"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 12.0f, 18.0f, 18.0f)];
}

#pragma mark - Message bubbles
+ (UIImage *)messageBubbleOutgoingDefault
{
    return [[UIImage imageNamed:@"messageBubbleBlue"] stretchableImageWithLeftCapWidth:15.0f topCapHeight:15.0f];
}

+ (UIImage *)messageBubbleIncomingDefault
{
    return [[UIImage imageNamed:@"messageBubbleGray"] stretchableImageWithLeftCapWidth:23.0f topCapHeight:15.0f];
}

+ (UIImage *)messageBubbleOutgoingSquareDefault
{
    return [[UIImage imageNamed:@"bubbleSquareOutgoing"] stretchableImageWithLeftCapWidth:15.0f topCapHeight:15.0f];
}

+ (UIImage *)messageBubbleIncomingSquareDefault
{
    return [[UIImage imageNamed:@"bubbleSquareIncoming"] stretchableImageWithLeftCapWidth:25.0f topCapHeight:15.0f];
}

+ (UIImage *)messageBubbleOutgoingDefaultGreen
{
    return [[UIImage imageNamed:@"messageBubbleGreen"] stretchableImageWithLeftCapWidth:15.0f topCapHeight:15.0f];
}

#pragma mark - Highlighted message bubbles
+ (UIImage *)messageBubbleHighlightedIncoming
{
    return [[UIImage imageNamed:@"messageBubbleHighlighted-incoming"] stretchableImageWithLeftCapWidth:23.0f topCapHeight:15.0f];
}

+ (UIImage *)messageBubbleHighlightedOutgoing
{
    return [[UIImage imageNamed:@"messageBubbleHighlighted-outgoing"] stretchableImageWithLeftCapWidth:15.0f topCapHeight:15.0f];
}

@end
