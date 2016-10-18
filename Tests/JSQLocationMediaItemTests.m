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
    
    XCTAssertEqualObjects((NSString *)kUTTypeURL, [item mediaDataType]);

    NSURL *locationURL = [[NSURL alloc] initWithString:@"http://maps.apple.com/?ll=37.795313,-122.393757&z=18&q=%20"];
    XCTAssertEqualObjects(locationURL, [item mediaData]);
}

@end
