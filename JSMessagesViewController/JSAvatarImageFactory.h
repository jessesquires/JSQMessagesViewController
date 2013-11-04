//
//  JSAvatarImageFactory.h
//  MessagesDemo
//
//  Created by Jesse Squires on 11/3/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGFloat const kJSAvatarImageSize;

typedef NS_ENUM(NSUInteger, JSAvatarImageStyle) {
    JSAvatarImageStyleClassic,
    JSAvatarImageStyleFlat
};


typedef NS_ENUM(NSUInteger, JSAvatarImageShape) {
    JSAvatarImageShapeCircle,
    JSAvatarImageShapeSquare
};


@interface JSAvatarImageFactory : NSObject

+ (UIImage *)avatarImageNamed:(NSString *)filename
                        style:(JSAvatarImageStyle)style
                        shape:(JSAvatarImageShape)shape;

@end
