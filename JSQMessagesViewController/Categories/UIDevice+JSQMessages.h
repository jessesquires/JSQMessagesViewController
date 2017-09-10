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

@interface UIDevice (JSQMessages)

/**
 *  @return Whether or not the current device is running a version of iOS before 8.0.
 */
+ (BOOL)jsq_isCurrentDeviceBeforeiOS8;

/**
 *  @return Whether or not the current device is running a version of iOS after 9.0.
 */
+ (BOOL)jsq_isCurrentDeviceAfteriOS9;

@end
