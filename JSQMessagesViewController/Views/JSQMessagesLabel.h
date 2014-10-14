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

#import <UIKit/UIKit.h>

/**
 *  `JSQMessagesLabel` is a subclass of `UILabel` that adds support for a `textInsets` property,
 *  which is similar to the `textContainerInset` property of `UITextView`.
 */
@interface JSQMessagesLabel : UILabel

/**
 *  The inset of the text layout area within the label's content area. The default value is `UIEdgeInsetsZero`.
 *
 *  @discussion This property provides text margins for the text laid out in the label.
 *  The inset values provided must be greater than or equal to `0.0f`.
 */
@property (assign, nonatomic) UIEdgeInsets textInsets;

@end
