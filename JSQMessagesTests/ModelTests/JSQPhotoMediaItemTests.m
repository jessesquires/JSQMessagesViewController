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
#import "JSQMessage.h"
#import "JSQMessagesCollectionView.h"

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
    
    NSString *senderId = @"324543-43556-212343";
    NSString *senderDisplayName = @"Jesse Squires";
    NSDate *date = [NSDate date];
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date media:item];
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    JSQMessagesCollectionView *collectionView = [[JSQMessagesCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 500) collectionViewLayout:layout];
    
    XCTAssertNotNil(collectionView.collectionViewLayout);
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySizeWithMessageData:message layout:layout], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderViewWithMessageData:message layout:layout]);
    XCTAssertNil([item mediaViewWithMessageData:message layout:layout], @"Media view should be nil if image is nil");
    
    item.image = [UIImage imageNamed:@"demo_avatar_jobs"];
    
    XCTAssertNotNil([item mediaViewWithMessageData:message layout:layout], @"Media view should NOT be nil once item has media data");
}

- (void)testPhotoItemDescription
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage new]];
    XCTAssertTrue([item.description containsString:@"image"]);
    XCTAssertTrue([item.description containsString:@"appliesMediaViewMaskAsOutgoing"]);
}

@end
