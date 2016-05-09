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
#import "JSQMessage.h"
#import "JSQMessagesCollectionView.h"

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
    
    JSQVideoMediaItem *newItem = [[JSQVideoMediaItem alloc] initWithFileURL:[NSURL URLWithString:@"file://123"] isReadyToPlay:YES];
    newItem.appliesMediaViewMaskAsOutgoing = NO;
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    XCTAssertEqual([item mediaHash], [copy mediaHash], @"Copied item media hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
    XCTAssertNotEqualObjects(item, newItem);
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
    
    NSString *senderId = @"324543-43556-212343";
    NSString *senderDisplayName = @"Jesse Squires";
    NSDate *date = [NSDate date];
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date media:item];
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    JSQMessagesCollectionView *collectionView = [[JSQMessagesCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 500) collectionViewLayout:layout];
    
    XCTAssertNotNil(collectionView.collectionViewLayout);
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySizeWithMessageData:message layout:layout], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderViewWithMessageData:message layout:layout]);
    XCTAssertNil([item mediaViewWithMessageData:message layout:layout], @"Media view should be nil if fileURL is nil, and readyToPlay is NO");
    
    item.fileURL = [NSURL URLWithString:@"file://"];
    item.isReadyToPlay = YES;
    
    XCTAssertNotNil([item mediaViewWithMessageData:message layout:layout], @"Media view should NOT be nil once item has media data");
}

- (void)testPhotoItemDescription
{
    JSQVideoMediaItem *item = [[JSQVideoMediaItem alloc] initWithFileURL:[NSURL URLWithString:@"file://"] isReadyToPlay:YES];
    XCTAssertTrue([item.description containsString:@"fileURL"]);
    XCTAssertTrue([item.description containsString:@"isReadyToPlay"]);
    XCTAssertTrue([item.description containsString:@"appliesMediaViewMaskAsOutgoing"]);
}

@end
