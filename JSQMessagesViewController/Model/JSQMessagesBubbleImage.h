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
#import "JSQMessageBubbleImageDataSource.h"

// TODO: documentation


@interface JSQMessagesBubbleImage : NSObject <JSQMessageBubbleImageDataSource, NSCopying>

@property (strong, nonatomic, readonly) UIImage *messageBubbleImage;

@property (strong, nonatomic, readonly) UIImage *messageBubbleHighlightedImage;

- (instancetype)initWithMessageBubbleImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

@end
