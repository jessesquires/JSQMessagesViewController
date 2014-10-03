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

@import Foundation;
@import UIKit;

#import "JSQMessagesBubbleImage.h"


/**
 *  `JSQMessagesBubbleImageFactory` is a factory that provides a means for creating and styling 
 *  `JSQMessagesBubbleImage` objects to be displayed in a `JSQMessagesCollectionViewCell` of a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesBubbleImageFactory : NSObject

/**
 *  Creates and returns a `JSQMessagesBubbleImage` object with the specified color for *outgoing* message image bubbles.
 *  The `messageBubbleImage` property of the `JSQMessagesBubbleImage` is configured with a flat bubble image, masked to the given color.
 *  The `messageBubbleHighlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessagesBubbleImage` object if created successfully, `nil` otherwise.
 */
+ (JSQMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color;

/**
 *  Creates and returns a `JSQMessagesBubbleImage` object with the specified color for *incoming* message image bubbles.
 *  The `messageBubbleImage` property of the `JSQMessagesBubbleImage` is configured with a flat bubble image, masked to the given color.
 *  The `messageBubbleHighlightedImage` property is configured similarly, but with a darkened version of the given color.
 *
 *  @param color The color of the bubble image in the image view. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessagesBubbleImage` object if created successfully, `nil` otherwise.
 */
+ (JSQMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color;

@end
