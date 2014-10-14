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

/**
 *  `JSQMessagesBubbleImageFactory` is a factory that provides a means for creating and styling 
 *  message bubble image views to be displayed in a `JSQMessagesCollectionViewCell` of a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesBubbleImageFactory : NSObject

/**
 *  Creates an returns an image view object with the specified color for outgoing messages. 
 *  The `image` property of the image view is configured with a flat bubble image, masked to the given color. 
 *  The `highlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized image view object if created successfully, `nil` otherwise.
 */
+ (UIImageView *)outgoingMessageBubbleImageViewWithColor:(UIColor *)color;

/**
 *  Creates an returns an image view object with the specified color for incoming messages. 
 *  The `image` property of the image view is configured with a flat bubble image, masked to the given color. 
 *  The `highlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized image view object if created successfully, `nil` otherwise.
 */
+ (UIImageView *)incomingMessageBubbleImageViewWithColor:(UIColor *)color;

@end
