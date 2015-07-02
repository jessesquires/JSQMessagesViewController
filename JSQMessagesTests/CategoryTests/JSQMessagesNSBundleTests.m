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

#import "NSBundle+JSQMessages.h"


@interface JSQMessagesNSBundleTests : XCTestCase
@end


@implementation JSQMessagesNSBundleTests

- (void)testMessagesBundle
{
    XCTAssertNotNil([NSBundle jsq_messagesBundle]);
}

- (void)testAssetBundle
{
    NSBundle *bundle = [NSBundle jsq_messagesAssetBundle];
    XCTAssertNotNil(bundle);
    XCTAssertEqualObjects(bundle.bundlePath.lastPathComponent, @"JSQMessagesAssets.bundle");
}

- (void)testLocalizedStringForKey
{
    XCTAssertNotNil([NSBundle jsq_localizedStringForKey:@"send"]);
    XCTAssertNotEqualObjects([NSBundle jsq_localizedStringForKey:@"send"], @"send");

    XCTAssertNotNil([NSBundle jsq_localizedStringForKey:@"load_earlier_messages"]);
    XCTAssertNotEqualObjects([NSBundle jsq_localizedStringForKey:@"load_earlier_messages"], @"load_earlier_messages");

    XCTAssertNotNil([NSBundle jsq_localizedStringForKey:@"new_message"]);
    XCTAssertNotEqualObjects([NSBundle jsq_localizedStringForKey:@"new_message"], @"new_message");
}

@end
