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

/**
 *  A `JSQMessagesCollectionViewFlowLayoutInvalidationContext` object specifies properties for 
 *  determining whether to recompute the size of items or their position in the layout. 
 *  The flow layout object creates instances of this class when it needs to invalidate its contents 
 *  in response to changes. You can also create instances when invalidating the flow layout manually.
 *
 */
@interface JSQMessagesCollectionViewFlowLayoutInvalidationContext : UICollectionViewFlowLayoutInvalidationContext

/**
 *  A boolean indicating whether to empty the messages layout information cache for items and views in the layout.
 *  The default value is `NO`.
 */
@property (nonatomic, assign) BOOL invalidateFlowLayoutMessagesCache;

/**
 *  Creates and returns a new `JSQMessagesCollectionViewFlowLayoutInvalidationContext` object.
 *
 *  @discussion When you need to invalidate the `JSQMessagesCollectionViewFlowLayout` object for your
 *  `JSQMessagesViewController` subclass, you should use this method to instantiate a new invalidation 
 *  context and pass this object to `invalidateLayoutWithContext:`.
 *
 *  @return An initialized invalidation context object.
 */
+ (instancetype)context;

@end

NS_ASSUME_NONNULL_END
