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

#import "JSQMessagesTypingIndicatorFooterView.h"
/**
 *  The `JSQMessagesTypingIndicatorAnimator` class manages the typing indicator animation.
 *  This manages the animation of the three dots.
 */
@interface JSQMessagesTypingIndicatorAnimator : NSObject

/**
 *  Initialize the animator with the view to be animated as well as the ellipsis color
 *  as part of the animation.  Using this default color, a second, darker color is 
 *  calculated.
 */
- (instancetype) initWithTypingIndicatorView:(JSQMessagesTypingIndicatorFooterView*) view color:(UIColor*) ellipsisColor;

#pragma mark - Instance Methods

/**
 *  Starts the animation
 */
- (void) startAnimating;

/**
 *  Ends the animation
 */
- (void) stopAnimating;

@end
