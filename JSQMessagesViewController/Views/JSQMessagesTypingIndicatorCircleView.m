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

#import "JSQMessagesTypingIndicatorCircleView.h"

@implementation JSQMessagesTypingIndicatorCircleView

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    // Update Radius
    self.layer.cornerRadius = frame.size.height / 2.0f;
}

@end
