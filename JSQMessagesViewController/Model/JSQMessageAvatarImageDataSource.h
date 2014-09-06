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

// TODO: documentation

@protocol JSQMessageAvatarImageDataSource <NSObject>

@required

- (UIImage *)avatarImage;

- (UIImage *)avatarHighlightedImage;

- (UIImage *)avatarPlaceholderImage;

- (CGSize)avatarImageSize;

@end
