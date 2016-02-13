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

#import "JSQLocationMediaItem.h"

#import <MobileCoreServices/UTCoreTypes.h>

@interface JSQLocationMediaItemTests : XCTestCase

@property (strong, nonatomic) CLLocation *location;

@end


@implementation JSQLocationMediaItemTests

- (void)setUp
{
    [super setUp];
    self.location = [[CLLocation alloc] initWithLatitude:37.795313 longitude:-122.393757];
}

- (void)tearDown
{
    self.location = nil;
    [super tearDown];
}

- (void)testLocationItemInit
{
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] initWithLocation:self.location];
    XCTAssertNotNil(item);
}

- (void)testMediaDataProtocol
{
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] init];
    
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySize], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderView]);
    XCTAssertNil([item mediaView], @"Media view should be nil if location is nil");
    
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    [item setLocation:self.location withCompletionHandler:^{
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:15 handler:^(NSError *error) {
        XCTAssertNil(error, @"Expectation should not error");
    }];
    
    XCTAssertNotNil([item mediaView], @"Media view should NOT be nil once item has media data");
}

- (void)testCopyableItemInMediaProtocol {
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] initWithLocation:self.location];
    XCTAssertNotNil(item);
    XCTAssertNotNil([item copyableMediaItem]);
    
    NSDictionary *copyableMediaItem = [item copyableMediaItem];
    XCTAssertNotNil(copyableMediaItem[JSQPasteboardUTTypeKey]);
    XCTAssertEqualObjects((NSString *)kUTTypeURL, copyableMediaItem[JSQPasteboardUTTypeKey]);
    
    XCTAssertNotNil(copyableMediaItem[JSQPasteboardDataKey]);
    NSURL *locationURL = [[NSURL alloc] initWithString:@"http://maps.google.com/maps?z=12&t=m&q=loc:37.795313+-122.393757"];
    XCTAssertEqualObjects(locationURL, copyableMediaItem[JSQPasteboardDataKey]);
}

@end
