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

#import "UIDevice+JSQMessages.h"

@implementation UIDevice (JSQMessages)

+ (BOOL)jsq_isCurrentDeviceAfteriOS7
{
    // iOS > 7.0
    return [[UIDevice currentDevice].systemVersion compare:@"7.0" options:NSNumericSearch] == NSOrderedSame ||
            [[UIDevice currentDevice].systemVersion compare:@"7.0" options:NSNumericSearch] == NSOrderedDescending;
}

@end
