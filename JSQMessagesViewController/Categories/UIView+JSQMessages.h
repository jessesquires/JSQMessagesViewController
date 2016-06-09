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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JSQMessages)

/**
 *  Pins the subview of the receiver to the edge of its frame, as specified by the given attribute, by adding a layout constraint.
 *
 *  @param subview   The subview to which the receiver will be pinned.
 *  @param attribute The layout constraint attribute specifying one of `NSLayoutAttributeBottom`, `NSLayoutAttributeTop`, `NSLayoutAttributeLeading`, `NSLayoutAttributeTrailing`.
 */
- (void)jsq_pinSubview:(UIView *)subview toEdge:(NSLayoutAttribute)attribute;

/**
 *  Pins all edges of the specified subview to the receiver.
 *
 *  @param subview The subview to which the receiver will be pinned.
 */
- (void)jsq_pinAllEdgesOfSubview:(UIView *)subview;

@end

NS_ASSUME_NONNULL_END
