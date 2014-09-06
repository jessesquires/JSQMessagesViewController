//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSQMessageAvatarImageDataSource.h"


@interface JSQMessagesAvatarImage : NSObject <JSQMessageAvatarImageDataSource, NSCopying>

@property (nonatomic, strong) UIImage *avatarImage;

@property (nonatomic, strong) UIImage *avatarHighlightedImage;

@property (nonatomic, strong, readonly) UIImage *avatarPlaceholderImage;

@property (nonatomic, assign, readonly) CGSize avatarImageSize;

- (instancetype)initWithPlaceholderImage:(UIImage *)image size:(CGSize)size;

- (instancetype)initWithAvatarImage:(UIImage *)avatarImage
                   highlightedImage:(UIImage *)highlightedImage
                   placeholderImage:(UIImage *)placeholderImage
                               size:(CGSize)size;

- (UIImage *)currentDisplayImage;

@end
