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

#import "JSQMessage.h"


@interface JSQMessageTests : XCTestCase

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;

@end


@implementation JSQMessageTests

- (void)setUp
{
    [super setUp];
    self.senderId = @"324543-43556-212343";
    self.senderDisplayName = @"Jesse Squires";
    self.date = [NSDate date];
}

- (void)tearDown
{
    self.senderId = nil;
    self.senderDisplayName = nil;
    self.date = nil;
    [super tearDown];
}

- (void)testMessageInit
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName date:self.date isMedia:NO];
    XCTAssertNotNil(msg, @"Message should not be nil");
}

- (void)testMessageInvalidInit
{
    XCTAssertThrows([[JSQMessage alloc] init], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithSenderId:nil senderDisplayName:nil date:nil isMedia:NO], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithSenderId:self.senderId senderDisplayName:nil date:nil isMedia:YES], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithSenderId:nil senderDisplayName:self.senderDisplayName date:nil isMedia:NO], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithSenderId:nil senderDisplayName:nil date:self.date isMedia:YES], @"Invalid init should throw");
}

- (void)testMessageIsEqual
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName date:self.date isMedia:NO];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqualObjects(msg, msg, @"Messages should be equal to itself");
}

- (void)testMessageArchiving
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId senderDisplayName:self.senderDisplayName date:self.date isMedia:YES];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertEqualObjects(msg, unarchivedMsg, @"Message should be equal");
}

@end
