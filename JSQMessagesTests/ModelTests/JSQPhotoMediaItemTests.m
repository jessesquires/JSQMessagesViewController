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

#import "JSQPhotoMediaItem.h"


@interface JSQPhotoMediaItemTests : XCTestCase

@end


@implementation JSQPhotoMediaItemTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testPhotoItemInit
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage new]];
    XCTAssertNotNil(item);
}

- (void)testPhotoItemIsEqual
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]];
    
    JSQPhotoMediaItem *copy = [item copy];
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
}

- (void)testPhotoItemArchiving
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage new]];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    JSQPhotoMediaItem *unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(item, unarchivedItem);
}

- (void)testMediaDataProtocol
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:nil];
    
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySize], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderView]);
    XCTAssertNil([item mediaView], @"Media view should be nil if image is nil");
    
    item.image = [UIImage imageNamed:@"demo_avatar_jobs"];
    
    XCTAssertNotNil([item mediaView], @"Media view should NOT be nil once item has media data");
}

@end
