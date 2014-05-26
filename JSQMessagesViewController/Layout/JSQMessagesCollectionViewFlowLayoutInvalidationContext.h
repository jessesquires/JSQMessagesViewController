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
 *  The `JSQMessagesCollectionViewFlowLayoutInvalidationContext` is a custom invalidation context
 *  object used by `JSQMessagesCollectionViewDelegateFlowLayout`. Its purpose is to override the default
 *  behaviour of `UICollectionViewFlowLayout` which re-computes layout information upon each invalidation,
 *  causing a lot of useless computations when `JSQMessagesCollectionViewDelegateFlowLayout` is used with
 *  `springinessEnabled` set to `YES`
 *
 *  @see `JSQMessagesCollectionViewDelegateFlowLayout`
 */
@interface JSQMessagesCollectionViewFlowLayoutInvalidationContext : UICollectionViewFlowLayoutInvalidationContext

/**
 *  Creates an invalidation context identical to the newly created instance of
 *  `UICollectionViewFlowLayoutInvalidationContext`.
 *  Pass returned object to `-[JSQMessagesCollectionViewFlowLayoutInvalidationContext invalidateWithContext:]
 *  to get the "real" invalidation.
 */
+ (instancetype)defaultContext;

@end
