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

#import "JSQCustomMediaView.h"

@interface JSQCustomMediaViewTests : XCTestCase

@end

@implementation JSQCustomMediaViewTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCustomMediaViewInit
{
    JSQCustomMediaView *view = [[JSQCustomMediaView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    XCTAssertNotNil(view, @"Custom view should not be nil");

    JSQMessage *message = [view generateMessageWithSenderId:@"1" displayName:@"Foo"];
    XCTAssertNotNil(message, @"Generated message should not be nil");
}

@end
