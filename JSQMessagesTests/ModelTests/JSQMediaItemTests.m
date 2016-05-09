//
//  JSQMediaItemTests.m
//  JSQMessages
//
//  Created by Alex Gurin on 5/8/16.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "JSQMediaItem.h"
#import "JSQMessage.h"
#import "JSQMessagesCollectionView.h"

@interface JSQMediaItemTests : XCTestCase

@end

@implementation JSQMediaItemTests

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
    JSQMediaItem *item = [[JSQMediaItem alloc] init];
    XCTAssertNotNil(item);
}

- (void)testPhotoItemIsEqual
{
    JSQMediaItem *item = [[JSQMediaItem alloc] init];
    
    JSQMediaItem *copy = [item copy];
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertTrue([item isEqual:item]);
    
    XCTAssertNotEqualObjects(item, [NSString new]);
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    XCTAssertEqual([item mediaHash], [copy mediaHash], @"Copied item media hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
}

- (void)testPhotoItemArchiving
{
    JSQMediaItem *item = [[JSQMediaItem alloc] init];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    JSQMediaItem *unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(item, unarchivedItem);
}

- (void)testMediaDataProtocol
{
    JSQMediaItem *item = [[JSQMediaItem alloc] init];
    
    NSString *senderId = @"324543-43556-212343";
    NSString *senderDisplayName = @"Jesse Squires";
    NSDate *date = [NSDate date];
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date media:item];
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    JSQMessagesCollectionView *collectionView = [[JSQMessagesCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 500) collectionViewLayout:layout];
    
    XCTAssertNotNil(collectionView.collectionViewLayout);
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySizeWithMessageData:message layout:layout], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderViewWithMessageData:message layout:layout]);
}

- (void)testPhotoItemDescription
{
    JSQMediaItem *item = [[JSQMediaItem alloc] init];
    XCTAssertTrue([item.description containsString:@"appliesMediaViewMaskAsOutgoing"]);
}

- (void)testDidReceiveMemoryWarning
{
    JSQMediaItem *item = [[JSQMediaItem alloc] init];
    
    NSString *senderId = @"324543-43556-212343";
    NSString *senderDisplayName = @"Jesse Squires";
    NSDate *date = [NSDate date];
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date media:item];
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    JSQMessagesCollectionView *collectionView = [[JSQMessagesCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 500) collectionViewLayout:layout];
    
    XCTAssertNotNil(collectionView.collectionViewLayout);
    XCTAssertNotNil([item mediaPlaceholderViewWithMessageData:message layout:layout]);
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    XCTAssertNil(item.cachedPlaceholderView);
}

@end
