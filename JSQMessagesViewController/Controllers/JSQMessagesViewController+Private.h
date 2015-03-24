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
//  Copyright (c) 2015 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesViewController.h"

@interface JSQMessagesViewController ()

/**
 *
 * This private method is how the View Controller initializes most of its initial state.
 * If you override this method, you should probably call super as well.
 */
- (void)jsq_configureMessagesViewController;

/**
 *
 * This private method is how the View Controller initializes the inputToolbar.
 * If you override this method, you should probably call super as well.
 */
- (void)jsq_configureMessagesInputToolbar;
@end
