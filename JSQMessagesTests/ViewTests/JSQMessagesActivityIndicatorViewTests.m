//
//  JSQMessagesActivityIndicatorViewTests.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-7.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "JSQMessagesActivityIndicatorView.h"

@protocol JSQMessagesActivityIndicator;

@interface JSQMessagesActivityIndicatorViewTests : XCTestCase
@end

@implementation JSQMessagesActivityIndicatorViewTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMessageActivityIndicatorViewInit
{
    JSQMessagesActivityIndicatorView *activityIndicatorView = [JSQMessagesActivityIndicatorView new];
    XCTAssertNotNil(activityIndicatorView, @"view should not be nil");
    
    BOOL conformsToProtocol = [activityIndicatorView conformsToProtocol:@protocol(JSQMessagesActivityIndicator)];
    XCTAssertTrue(conformsToProtocol, @"view should conforms to `JSQMessagesActivityIndicator` protocol");
}

@end
