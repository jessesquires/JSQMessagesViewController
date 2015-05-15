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

#import "JSQVideoMediaItem.h"


@interface JSQVideoMediaItemTests : XCTestCase

@end


@implementation JSQVideoMediaItemTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testVideoMediaItemInit
{
    JSQVideoMediaItem *item = [[JSQVideoMediaItem alloc] initWithFileURL:[NSURL URLWithString:@"file://"] isReadyToPlay:NO];
    XCTAssertNotNil(item);
}

- (void)testVideoItemIsEqual
{
    JSQVideoMediaItem *item = [[JSQVideoMediaItem alloc] initWithFileURL:[NSURL URLWithString:@"file://"] isReadyToPlay:YES];
    
    JSQVideoMediaItem *copy = [item copy];
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
}

- (void)testVideoItemArchiving
{
    JSQVideoMediaItem *item = [[JSQVideoMediaItem alloc] initWithFileURL:[NSURL URLWithString:@"file://"] isReadyToPlay:YES];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    JSQVideoMediaItem *unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(item, unarchivedItem);
}

- (void)testMediaDataProtocol
{
    JSQVideoMediaItem *item = [[JSQVideoMediaItem alloc] init];
    
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySize], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderView]);
    XCTAssertNil([item mediaView], @"Media view should be nil if fileURL is nil, and readyToPlay is NO");
    
    item.fileURL = [NSURL URLWithString:@"file://"];
    item.isReadyToPlay = YES;
    
    XCTAssertNotNil([item mediaView], @"Media view should NOT be nil once item has media data");
}

@end
