//
//  JSBubbleImageViewFactory.h
//  MessagesDemo
//
//  Created by Jesse Squires on 11/3/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
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
                                  style:(JSBubbleImageViewStyle)style;

@end
