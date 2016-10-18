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

#import <XCTest/XCTest.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>

@interface JSQMessagesLabelTests : XCTestCase

@end


@implementation JSQMessagesLabelTests

- (void)testMessagesLabelInit
{
    JSQMessagesLabel *label = [[JSQMessagesLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 40.0f)];
    XCTAssertNotNil(label, @"Label should not be nil");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(label.textInsets, UIEdgeInsetsZero), @"Property should be equal to default value");
}

@end
