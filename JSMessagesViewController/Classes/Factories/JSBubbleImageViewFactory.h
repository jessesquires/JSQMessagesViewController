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

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JSBubbleMessageType) {
    JSBubbleMessageTypeIncoming,
    JSBubbleMessageTypeOutgoing
};


typedef NS_ENUM(NSUInteger, JSBubbleImageViewStyle) {
    JSBubbleImageViewStyleClassicGray,
    JSBubbleImageViewStyleClassicBlue,
    JSBubbleImageViewStyleClassicGreen,
    JSBubbleImageViewStyleClassicSquareGray,
    JSBubbleImageViewStyleClassicSquareBlue
};


@interface JSBubbleImageViewFactory : NSObject

+ (UIImageView *)bubbleImageViewForType:(JSBubbleMessageType)type
                                  color:(UIColor *)color;

+ (UIImageView *)classicBubbleImageViewForType:(JSBubbleMessageType)type
                                         style:(JSBubbleImageViewStyle)style;

@end
