//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"


@interface JSQMessagesToolbarButtonFactoryTests : XCTestCase

@end


@implementation JSQMessagesToolbarButtonFactoryTests

- (void)testDefaultSendButtonItem
{
    UIButton *button = [JSQMessagesToolbarButtonFactory defaultSendButtonItem];
    XCTAssertNotNil(button, @"Button should not be nil");
}

- (void)testDefaultAccessoryButtonItem
{
    UIButton *button = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
    XCTAssertNotNil(button, @"Button should not be nil");
}

@end
