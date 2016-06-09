//
//  Created by Jesse Squires
//  http://www.jessesquires.com
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

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `JSQMessageBubbleImageDataSource` protocol defines the common interface through which
 *  a `JSQMessagesViewController` and `JSQMessagesCollectionView` interact with 
 *  message bubble image model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances
 *  of that class can be display properly within a `JSQMessagesCollectionViewCell`.
 *
 *  A concrete class that conforms to this protocol is provided in the library. See `JSQMessagesBubbleImage`.
 *
 *  @see JSQMessagesBubbleImage.
 */
@protocol JSQMessageBubbleImageDataSource <NSObject>

@required

/**
 *  @return The message bubble image for a regular display state.
 *
 *  @warning You must not return `nil` from this method.
 */
- (UIImage *)messageBubbleImage;

/**
 *  @return The message bubble image for a highlighted display state.
 *
 *  @warning You must not return `nil` from this method.
 */
- (UIImage *)messageBubbleHighlightedImage;

@end

NS_ASSUME_NONNULL_END
