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
#import "JSQMessage.h"
#import "JSQMessagesCollectionView.h"

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

- (void)testSetProperties
{
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] init];
    
    item.location = self.location;
    XCTAssertNotNil(item.location);
    XCTAssertTrue(CLLocationCoordinate2DIsValid(item.coordinate));
    
    item.location = nil;
    XCTAssertNil(item.location);
    
    item.appliesMediaViewMaskAsOutgoing = YES;
    XCTAssertTrue(item.appliesMediaViewMaskAsOutgoing);
}

- (void)testLocationItemIsEqual
{
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] initWithLocation:self.location];
    
    JSQLocationMediaItem *copy = [item copy];
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    XCTAssertEqual([item mediaHash], [copy mediaHash], @"Copied item media hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
    
    copy.appliesMediaViewMaskAsOutgoing = NO;
    XCTAssertNotEqualObjects(item, copy);
    
    copy.appliesMediaViewMaskAsOutgoing = NO;
    XCTAssertNotEqualObjects(item, copy);
}

- (void)testLocationItemArchiving
{
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] initWithLocation:self.location];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    JSQLocationMediaItem *unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(item, unarchivedItem);
}

- (void)testMediaDataProtocol
{
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] init];
    item.location = nil;
    
    NSString *senderId = @"324543-43556-212343";
    NSString *senderDisplayName = @"Jesse Squires";
    NSDate *date = [NSDate date];
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date media:item];
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    JSQMessagesCollectionView *collectionView = [[JSQMessagesCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 500) collectionViewLayout:layout];
    
    XCTAssertNotNil(collectionView.collectionViewLayout);
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySizeWithMessageData:message layout:layout], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderViewWithMessageData:message layout:layout]);
    XCTAssertNil([item mediaViewWithMessageData:message layout:layout], @"Media view should be nil if location is nil");
    
    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];
    
    [item setLocation:self.location withCompletionHandler:^{
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:15 handler:^(NSError *error) {
        XCTAssertNil(error, @"Expectation should not error");
    }];
    
    XCTAssertNotNil([item mediaViewWithMessageData:message layout:layout], @"Media view should NOT be nil once item has media data");
}

- (void)testLocationItemDescription
{
    JSQLocationMediaItem *item = [[JSQLocationMediaItem alloc] initWithLocation:self.location];
    XCTAssertTrue([item.description containsString:@"location"]);
    XCTAssertTrue([item.description containsString:@"appliesMediaViewMaskAsOutgoing"]);
}

@end
