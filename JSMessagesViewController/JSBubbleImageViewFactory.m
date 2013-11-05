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

#import "JSBubbleImageViewFactory.h"
#import "UIImage+JSMessagesView.h"

static NSDictionary *bubbleImageDictionary;

@interface JSBubbleImageViewFactory()

+ (UIImageView *)bubbleImageViewForStyle:(JSBubbleImageViewStyle)style isOutgoing:(BOOL)isOutgoing;
+ (UIImage *)highlightedBubbleImageForStyle:(JSBubbleImageViewStyle)style;
+ (UIEdgeInsets)bubbleImageCapInsetsForStyle:(JSBubbleImageViewStyle)style isOutgoing:(BOOL)isOutgoing;

@end



@implementation JSBubbleImageViewFactory

#pragma mark - Initialization

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bubbleImageDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"bubble-classic-gray", @(JSBubbleImageViewStyleClassicGray),
                                 @"bubble-classic-blue", @(JSBubbleImageViewStyleClassicBlue),
                                 @"bubble-classic-green", @(JSBubbleImageViewStyleClassicGreen),
                                 @"bubble-classic-square-gray", @(JSBubbleImageViewStyleClassicSquareGray),
                                 @"bubble-classic-square-blue", @(JSBubbleImageViewStyleClassicSquareBlue),
                                 nil];
    });
}

#pragma mark - Public

+ (UIImageView *)bubbleImageViewForType:(JSBubbleMessageType)type
                                  style:(JSBubbleImageViewStyle)style
{
    return [JSBubbleImageViewFactory bubbleImageViewForStyle:style
                                                  isOutgoing:type == JSBubbleMessageTypeOutgoing];
}

#pragma mark - Private

+ (UIImageView *)bubbleImageViewForStyle:(JSBubbleImageViewStyle)style isOutgoing:(BOOL)isOutgoing
{
    UIImage *image = [UIImage imageNamed:[bubbleImageDictionary objectForKey:@(style)]];
    UIImage *highlightedImage = [JSBubbleImageViewFactory highlightedBubbleImageForStyle:style];
    
    if(isOutgoing) {
        image = [image js_imageFlippedHorizontal];
        highlightedImage = [highlightedImage js_imageFlippedHorizontal];
    }
    
    UIEdgeInsets capInsets = [JSBubbleImageViewFactory bubbleImageCapInsetsForStyle:style
                                                                         isOutgoing:isOutgoing];
    
    return [[UIImageView alloc] initWithImage:[image js_stretchableImageWithCapInsets:capInsets]
                             highlightedImage:[highlightedImage js_stretchableImageWithCapInsets:capInsets]];
}

+ (UIImage *)highlightedBubbleImageForStyle:(JSBubbleImageViewStyle)style
{
    switch (style) {
        case JSBubbleImageViewStyleClassicGray:
        case JSBubbleImageViewStyleClassicBlue:
        case JSBubbleImageViewStyleClassicGreen:
            return [UIImage imageNamed:@"bubble-classic-highlighted"];
            
        case JSBubbleImageViewStyleClassicSquareGray:
        case JSBubbleImageViewStyleClassicSquareBlue:
            return [UIImage imageNamed:@"bubble-classic-square-highlighted"];
            
        default:
            return nil;
    }
}

+ (UIEdgeInsets)bubbleImageCapInsetsForStyle:(JSBubbleImageViewStyle)style isOutgoing:(BOOL)isOutgoing
{
    switch (style) {
        case JSBubbleImageViewStyleClassicGray:
        case JSBubbleImageViewStyleClassicBlue:
        case JSBubbleImageViewStyleClassicGreen:
            return UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f);
            
        case JSBubbleImageViewStyleClassicSquareGray:
        case JSBubbleImageViewStyleClassicSquareBlue:
            return isOutgoing ? UIEdgeInsetsMake(15.0f, 18.0f, 16.0f, 23.0f) : UIEdgeInsetsMake(15.0f, 25.0f, 16.0f, 23.0f);
            
        default:
            return UIEdgeInsetsZero;
    }
}

@end
