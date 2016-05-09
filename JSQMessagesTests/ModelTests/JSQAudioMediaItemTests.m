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

#import "JSQAudioMediaItem.h"
#import "JSQMessage.h"
#import "JSQMessagesCollectionView.h"
#import "JSQAudioMediaViewAttributes.h"
#import "UIImage+JSQMessages.h"

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
    
    JSQAudioMediaItem *item2 = [[JSQAudioMediaItem alloc] initWithAudioViewAttributes:[[JSQAudioMediaViewAttributes alloc] init]];
    XCTAssertNotNil(item2);
}

- (void)testAudioItemIsEqual
{
    NSString * sample = [[NSBundle mainBundle] pathForResource:@"jsq_messages_sample" ofType:@"m4a"];
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] initWithData:[NSData dataWithContentsOfFile:sample]];
    
    JSQAudioMediaItem *copy = [item copy];
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
    
    copy.appliesMediaViewMaskAsOutgoing = NO;
    XCTAssertNotEqualObjects(item, copy);
    
    copy.appliesMediaViewMaskAsOutgoing = YES;
    copy.audioData = nil;
    XCTAssertNotEqualObjects(item, copy);
}

- (void)testAudioAttributesSet {
    JSQAudioMediaViewAttributes *attr = [[JSQAudioMediaViewAttributes alloc] init];
    
    attr.playButtonImage = [UIImage jsq_defaultPlayImage];
    XCTAssertNotNil(attr.playButtonImage);
    
    attr.pauseButtonImage = [UIImage jsq_defaultPauseImage];
    XCTAssertNotNil(attr.pauseButtonImage);
    
    attr.labelFont = [UIFont systemFontOfSize:12];
    XCTAssertEqualObjects(attr.labelFont, [UIFont systemFontOfSize:12]);
    
    attr.showFractionalSeconds = YES;
    XCTAssertTrue(attr.showFractionalSeconds);
    
    attr.backgroundColor = [UIColor blackColor];
    XCTAssertEqualObjects(attr.backgroundColor, [UIColor blackColor]);
    
    attr.tintColor = [UIColor blackColor];
    XCTAssertEqualObjects(attr.tintColor, [UIColor blackColor]);
    
    attr.controlInsets = UIEdgeInsetsMake(6, 6, 6, 18);
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(attr.controlInsets, UIEdgeInsetsMake(6, 6, 6, 18)));
    
    attr.controlPadding = 6;
    XCTAssertTrue(attr.controlPadding == 6);
    
    attr.audioCategory = @"AVAudioSessionCategoryPlayback";
    XCTAssertEqualObjects(attr.audioCategory, @"AVAudioSessionCategoryPlayback");
}

- (void)testAudioItemArchiving
{
    NSString * sample = [[NSBundle mainBundle] pathForResource:@"jsq_messages_sample" ofType:@"m4a"];
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] initWithData:[NSData dataWithContentsOfFile:sample]];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    JSQAudioMediaItem *unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(item, unarchivedItem);
}

- (void)testMediaDataProtocol
{
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] init];
    
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

    NSString *sample = [[NSBundle mainBundle] pathForResource:@"jsq_messages_sample" ofType:@"m4a"];
    item.audioData = [NSData dataWithContentsOfFile:sample];
    
    XCTAssertNotNil([item mediaViewWithMessageData:message layout:layout], @"Media view should NOT be nil once item has media data");
    
    NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:@"jsq_messages_sample" withExtension:@"m4a"];
    [item setAudioDataWithUrl:sampleURL];
    
    XCTAssertNotNil([item mediaViewWithMessageData:message layout:layout], @"Media view should NOT be nil once item has media data");
}

- (void)testAudioItemDescription
{
    JSQAudioMediaItem *item = [[JSQAudioMediaItem alloc] init];
    XCTAssertTrue([item.description containsString:@"audioData"]);
    XCTAssertTrue([item.description containsString:@"appliesMediaViewMaskAsOutgoing"]);
}

@end
