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

#import "JSBubbleImageViewFactory.h"
#import "UIImage+JSMessagesView.h"
#import "UIColor+JSMessagesView.h"

static NSDictionary *bubbleImageDictionary;

@interface JSBubbleImageViewFactory()

+ (UIImageView *)classicBubbleImageViewForStyle:(JSBubbleImageViewStyle)style
                                     isOutgoing:(BOOL)isOutgoing;

+ (UIImage *)classicHighlightedBubbleImageForStyle:(JSBubbleImageViewStyle)style;

+ (UIEdgeInsets)classicBubbleImageCapInsetsForStyle:(JSBubbleImageViewStyle)style
                                         isOutgoing:(BOOL)isOutgoing;

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
                                  color:(UIColor *)color
{
    UIImage *bubble = [UIImage imageNamed:@"bubble-min"];
    
    UIImage *normalBubble = [bubble js_imageMaskWithColor:color];
    UIImage *highlightedBubble = [bubble js_imageMaskWithColor:[color js_darkenColorWithValue:0.12f]];
    
    if(type == JSBubbleMessageTypeIncoming) {
        normalBubble = [normalBubble js_imageFlippedHorizontal];
        highlightedBubble = [highlightedBubble js_imageFlippedHorizontal];
    }
    
    // make image stretchable from center point
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    
    return [[UIImageView alloc] initWithImage:[normalBubble js_stretchableImageWithCapInsets:capInsets]
                             highlightedImage:[highlightedBubble js_stretchableImageWithCapInsets:capInsets]];
}

+ (UIImageView *)classicBubbleImageViewForType:(JSBubbleMessageType)type
                                         style:(JSBubbleImageViewStyle)style
{
    return [JSBubbleImageViewFactory classicBubbleImageViewForStyle:style
                                                  isOutgoing:type == JSBubbleMessageTypeOutgoing];
}

#pragma mark - Private

+ (UIImageView *)classicBubbleImageViewForStyle:(JSBubbleImageViewStyle)style
                                     isOutgoing:(BOOL)isOutgoing
{
    UIImage *image = [UIImage imageNamed:[bubbleImageDictionary objectForKey:@(style)]];
    UIImage *highlightedImage = [JSBubbleImageViewFactory classicHighlightedBubbleImageForStyle:style];
    
    if(!isOutgoing) {
        image = [image js_imageFlippedHorizontal];
        highlightedImage = [highlightedImage js_imageFlippedHorizontal];
    }
    
    UIEdgeInsets capInsets = [JSBubbleImageViewFactory classicBubbleImageCapInsetsForStyle:style
                                                                                isOutgoing:isOutgoing];
    
    return [[UIImageView alloc] initWithImage:[image js_stretchableImageWithCapInsets:capInsets]
                             highlightedImage:[highlightedImage js_stretchableImageWithCapInsets:capInsets]];
}

+ (UIImage *)classicHighlightedBubbleImageForStyle:(JSBubbleImageViewStyle)style
{
    switch (style) {
        case JSBubbleImageViewStyleClassicGray:
        case JSBubbleImageViewStyleClassicBlue:
        case JSBubbleImageViewStyleClassicGreen:
            return [UIImage imageNamed:@"bubble-classic-selected"];
            
        case JSBubbleImageViewStyleClassicSquareGray:
        case JSBubbleImageViewStyleClassicSquareBlue:
            return [UIImage imageNamed:@"bubble-classic-square-selected"];
            
        default:
            return nil;
    }
}

+ (UIEdgeInsets)classicBubbleImageCapInsetsForStyle:(JSBubbleImageViewStyle)style
                                         isOutgoing:(BOOL)isOutgoing
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
