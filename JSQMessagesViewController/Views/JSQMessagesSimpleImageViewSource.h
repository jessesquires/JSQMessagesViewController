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

#import "JSQMessagesImageViewSource.h"


/**
 *  A simple concrete class adopting the `JSQMessagesImageViewSource`.
 *  An instance of this class just updates `image` and `highlightedImage`
 *  properties of the bound image view immediately as it is bound.
 */
@interface JSQMessagesSimpleImageViewSource : NSObject<JSQMessagesImageViewSource>

/**
 *  Initializes and returns an image view source i
 *
 *  @param image             Image to be displayed in the bound image view.
 *
 *  @return An initialized `JSQMessagesSimpleImageViewSource` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithImage:(UIImage *)image;

/**
 *  Initializes and returns a message object having the given text, sender, and date.
 *
 *  @param image             Image to be displayed in the bound image view.
 *  @param highlightedImage  Image to be displayed when the bound view if it is highlighted
 *
 *  @return An initialized `JSQMessagesSimpleImageViewSource` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

@end
