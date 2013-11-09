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
