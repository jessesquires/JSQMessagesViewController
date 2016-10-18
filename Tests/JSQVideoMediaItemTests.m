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


@interface JSQVideoMediaItemTests : XCTestCase

@end


@implementation JSQVideoMediaItemTests

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
