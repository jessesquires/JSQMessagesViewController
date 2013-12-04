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

/**
 *  The type of bubble for a `JSBubbleMessageCell` object.
 */
typedef NS_ENUM(NSUInteger, JSBubbleMessageType) {
    /**
     *  Specifies an incoming, or received message.
     */
    JSBubbleMessageTypeIncoming,
    /**
     *  Specifies an outgoing, or sent message.
     */
    JSBubbleMessageTypeOutgoing
};

/**
 *  The style of a classic bubble image with an iOS 6 appearance.
 */
typedef NS_ENUM(NSUInteger, JSBubbleImageViewStyle) {
    /**
     *  Specifies a glossy gray messsage bubble.
     */
    JSBubbleImageViewStyleClassicGray,
    /**
     *  Specifies a glossy blue messsage bubble.
     */
    JSBubbleImageViewStyleClassicBlue,
    /**
     *  Specifies a glossy green messsage bubble.
     */
    JSBubbleImageViewStyleClassicGreen,
    /**
     *  Specifies a glossy gray square messsage bubble.
     */
    JSBubbleImageViewStyleClassicSquareGray,
    /**
     *  Specifies a glossy blue square messsage bubble.
     */
    JSBubbleImageViewStyleClassicSquareBlue
};

/**
 *  `JSBubbleImageViewFactory` is a factory that provides a means for styling bubble image views to be displayed in a `JSBubbleMessageCell` of a `JSMessagesViewController`.
 */
@interface JSBubbleImageViewFactory : NSObject

/**
 *  Creates and returns an image view object with the specified type and color. The `image` property of the image view is configured with a flat, iOS7-style bubble image, masked with the given color. The `highlightedImage` property is configured similarly, but with a slightly darkened version of the given color.
 *
 *  @param type  The type of the bubble image view.
 *  @param color The color of the bubble image in the image view.
 *
 *  @return An initialized image view object if created successfully, `nil` otherwise.
 */
+ (UIImageView *)bubbleImageViewForType:(JSBubbleMessageType)type
                                  color:(UIColor *)color;

/**
 *  Creates and returns an image view object with the specified type and style. The `image` property of the image view is configured with a glossy, iOS6-style bubble image, corresponding to the given style. The `highlightedImage` property is configured similarly, but with a selected version of the bubble image.
 *
 *  @param type  The type of the bubble image view.
 *  @param style The style of the bubble image in the image view.
 *
 *  @see `JSBubbleImageViewStyle`.
 *
 *  @return An initialized image view object if created successfully, `nil` otherwise.
 */
+ (UIImageView *)classicBubbleImageViewForType:(JSBubbleMessageType)type
                                         style:(JSBubbleImageViewStyle)style;

@end
