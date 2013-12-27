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
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(15.0f, 20.0f, 15.0f, 20.0f);
    
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

+ (UIImage *)bubbleMediaMaskImageForType:(JSBubbleMessageType)type
                                    size:(CGSize)rectSize
{
    
    UIImage *backgroundImage = [UIImage imageNamed:@"mask-bubble-background@2x.png"];
    
    if(type == JSBubbleMessageTypeIncoming)
    {
        
        UIImage *arrowImage = [UIImage imageNamed:@"r-mask-bubble-arrow-right@2x.png"];
        UIImage *rightBarImage = [UIImage imageNamed:@"r-mask-bubble-right-bar@2x.png"];
        UIImage *upperRightCorner = [UIImage imageNamed:@"r-mask-bubble-upper-right@2x.png"];
        UIImage *upperLeftCorner = [UIImage imageNamed:@"r-mask-bubble-upper-left@2x.png"];
        UIImage *bottomLeftCorner = [UIImage imageNamed:@"r-mask-bubble-bottom-left@2x.png"];
        
        UIGraphicsBeginImageContextWithOptions(rectSize, NO, [UIScreen mainScreen].scale);
        
        
        [backgroundImage drawInRect:CGRectMake(0, 0, rectSize.width, rectSize.height)];
        
        [arrowImage drawInRect:CGRectMake( 0 , rectSize.height - 18 , 24 , 18)];
        [rightBarImage drawInRect:CGRectMake(0 , 18 , 24,  rectSize.height - ( 36 ))];
        [upperRightCorner drawInRect:CGRectMake(0 , 0 , 24, 18)];
        
        [upperLeftCorner drawInRect:CGRectMake(rectSize.width - 24 , 0 , 24, 18)];
        [bottomLeftCorner drawInRect:CGRectMake(rectSize.width - 24  , rectSize.height - 18 , 24, 18)];
        
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result;
        
    }else
    {
        
        
        UIImage *arrowImage = [UIImage imageNamed:@"mask-bubble-arrow-right@2x.png"];
        UIImage *rightBarImage = [UIImage imageNamed:@"mask-bubble-right-bar@2x.png"];
        UIImage *upperRightCorner = [UIImage imageNamed:@"mask-bubble-upper-right@2x.png"];
        UIImage *upperLeftCorner = [UIImage imageNamed:@"mask-bubble-upper-left@2x.png"];
        UIImage *bottomLeftCorner = [UIImage imageNamed:@"mask-bubble-bottom-left@2x.png"];
        
        UIGraphicsBeginImageContextWithOptions(rectSize, NO, [UIScreen mainScreen].scale);
        
        
        [backgroundImage drawInRect:CGRectMake(0, 0, rectSize.width, rectSize.height)];
        
        [arrowImage drawInRect:CGRectMake( rectSize.width - 24 , rectSize.height - 18 , 24 , 18)];
        [rightBarImage drawInRect:CGRectMake(rectSize.width - 24 , 18 , 24,  rectSize.height - ( 36 ))];
        [upperRightCorner drawInRect:CGRectMake(rectSize.width - 24 , 0 , 24, 18)];
        
        [upperLeftCorner drawInRect:CGRectMake(0 , 0 , 24, 18)];
        [bottomLeftCorner drawInRect:CGRectMake(0 , rectSize.height - 18 , 24, 18)];
        
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return result;
    }
    
    
    
}

@end
