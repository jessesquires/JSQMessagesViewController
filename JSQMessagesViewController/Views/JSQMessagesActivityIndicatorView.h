//
//  JSQMessagesActivityIndicatorView.h
//  JSQMessages
//
//  Created by Vincent Xue on 14-7-5.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JSQMessagesActivityIndicator.h"

/**
 *  `JSQMessagesActivityIndicatorView` is a preset activity indicator class that adopt the
 *  `JSQMessagesActivityIndicator` protocol, you can use it directly.
 */
@interface JSQMessagesActivityIndicatorView : UIView <JSQMessagesActivityIndicator>

/**
 *	Starts the animation of the progress indicator.
 *  When the progress indicator is animated, the gear spins to indicate indeterminate progress. 
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
