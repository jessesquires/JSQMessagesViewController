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

@interface JSAvatarImageFactory : NSObject

+ (UIImage *)avatarImageNamed:(NSString *)filename
              croppedToCircle:(BOOL)croppedToCircle;

+ (UIImage *)classicAvatarImageNamed:(NSString *)filename
                     croppedToCircle:(BOOL)croppedToCircle;

@end
