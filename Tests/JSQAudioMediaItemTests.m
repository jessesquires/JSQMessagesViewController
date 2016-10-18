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

@interface JSQAudioMediaItemTests : XCTestCase

@end

@implementation JSQAudioMediaItemTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAudioItemInit
{
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] initWithData:[NSData data]];
    XCTAssertNotNil(item);
}

- (void)testAudioItemIsEqual
{
    NSString *sample = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsq_messages_sample" ofType:@"m4a"];
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] initWithData:[NSData dataWithContentsOfFile:sample]];
    
    JSQAudioMediaItem *copy = [item copy];
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
}

- (void)testAudioItemArchiving
{
    NSString *sample = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsq_messages_sample" ofType:@"m4a"];
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] initWithData:[NSData dataWithContentsOfFile:sample]];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    JSQAudioMediaItem *unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(item, unarchivedItem);
}

- (void)testMediaDataProtocol
{
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] init];
    
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySize], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderView]);
    XCTAssertNil([item mediaView], @"Media view should be nil if image is nil");

    NSString *sample = [[NSBundle bundleForClass:[self class]] pathForResource:@"jsq_messages_sample" ofType:@"m4a"];
    item.audioData = [NSData dataWithContentsOfFile:sample];
    
    XCTAssertNotNil([item mediaView], @"Media view should NOT be nil once item has media data");
}

@end
