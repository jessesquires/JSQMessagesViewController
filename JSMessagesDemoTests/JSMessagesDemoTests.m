//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import "JSMessagesViewController.h"


@interface JSMessagesDemoTests : XCTestCase

@end



@implementation JSMessagesDemoTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInit
{
    JSMessagesViewController *vc = [[JSMessagesViewController alloc] init];
    XCTAssertNotNil(vc, @"View controller should not be nil");
}

@end
