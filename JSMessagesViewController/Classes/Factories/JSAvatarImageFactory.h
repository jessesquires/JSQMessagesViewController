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
