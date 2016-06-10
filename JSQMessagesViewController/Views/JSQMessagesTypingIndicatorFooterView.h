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

/**
 *  A constant defining the default height of a `JSQMessagesTypingIndicatorFooterView`.
 */
FOUNDATION_EXPORT const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight;

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `JSQMessagesTypingIndicatorFooterView` class implements a reusable view that can be placed
 *  at the bottom of a `JSQMessagesCollectionView`. This view represents a typing indicator 
 *  for incoming messages.
 */
@interface JSQMessagesTypingIndicatorFooterView : UICollectionReusableView

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for the collection reusable view.
 *
 *  @return The initialized `UINib` object.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify the reusable footer view.
 *
 *  @return The string used to identify the reusable footer view.
 */
+ (NSString *)footerReuseIdentifier;

#pragma mark - Typing indicator

/**
 *  Configures the receiver with the specified attributes for the given collection view.
 *  Call this method after dequeuing the footer view.
 *
 *  @param ellipsisColor       The color of the typing indicator ellipsis. This value must not be `nil`.
 *  @param messageBubbleColor  The color of the typing indicator message bubble. This value must not be `nil`.
 *  @param animated            Specifies whether the typing indicator should animate.
 *  @param shouldDisplayOnLeft Specifies whether the typing indicator displays on the left or right side of the collection view when displayed.
 *  @param collectionView      The collection view in which the footer view will appear. This value must not be `nil`.
 */
- (void)configureWithEllipsisColor:(UIColor *)ellipsisColor
                messageBubbleColor:(UIColor *)messageBubbleColor
                          animated:(BOOL)animated
               shouldDisplayOnLeft:(BOOL)shouldDisplayOnLeft
                 forCollectionView:(UICollectionView *)collectionView;
@end

NS_ASSUME_NONNULL_END
