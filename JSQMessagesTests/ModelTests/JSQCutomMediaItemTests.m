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

#import "JSQCustomMediaItem.h"
#import "JSQCustomMediaView.h"

@interface JSQCutomMediaItemTests : XCTestCase

@end

@implementation JSQCutomMediaItemTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCustomItemInit
{
    JSQCustomMediaItem *item = [[JSQCustomMediaItem alloc] initWithView:nil];
    XCTAssertNotNil(item);
}

- (void)testMediaDataProtocol
{
    JSQCustomMediaItem *item = [[JSQCustomMediaItem alloc] initWithView:nil];

    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySize], CGSizeZero));
    XCTAssertNil([item mediaView], @"Media view should be nil if view is nil");

    JSQCustomMediaView *view = [[JSQCustomMediaView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    item.customView = view;

    XCTAssertNotNil([item mediaView], @"Media view should NOT be nil once item has media data");
}


@end
