//
//  JSQMessagesActivityIndicator.h
//  JSQMessages
//
//  Created by Vincent Xue on 14-7-6.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	The `JSQMessagesActivityIndicator` protocol defines the methods used by a `JSQMessagesCollectionViewCell`
 *  subclass object to represents that a task is in progress.
 *  Adopt the `JSQMessagesActivityIndicator` protocol in the UIView subclass to implement your own activity indicator.
 *  All of the methods of this protocol are required.
 */
@protocol JSQMessagesActivityIndicator <NSObject>

/**
 *	Starts the animation of the progress indicator.
 *  The indicator is animated until stopAnimating is called.
 */
- (void)startAnimation;

/**
 *	Stops the animation of the progress indicator.
 *  Call this method to stop the animation of the progress indicator started with a call to startAnimating.
 */
- (void)stopAnimation;

/**
 *	Returns whether the receiver is animating.
 *
 *	@return YES if the receiver is animating, otherwise NO.
 */
- (BOOL)isAnimating;

@end
