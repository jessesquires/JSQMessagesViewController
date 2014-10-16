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

#import "JSQTextMessage.h"


@interface JSQTextMessageTests : XCTestCase

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *text;

@end


@implementation JSQTextMessageTests

- (void)setUp
{
    [super setUp];
    self.senderId = @"324543-43556-212343";
    self.senderDisplayName = @"Jesse Squires";
    self.date = [NSDate date];
    self.text = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque"
    @"laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi"
    @"architecto beatae vitae dicta sunt explicabo.";
}

- (void)tearDown
{
    self.senderId = nil;
    self.senderDisplayName = nil;
    self.date = nil;
    self.text = nil;
    [super tearDown];
}

- (void)testTextMessageInit
{
    JSQTextMessage *msg = [[JSQTextMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:self.date
                                                              text:self.text];
    XCTAssertNotNil(msg, @"Message should not be nil");
}

- (void)testMessageInvalidInit
{
    XCTAssertThrows([[JSQTextMessage alloc] init], @"Invalid init should throw");
    XCTAssertThrows([[JSQTextMessage alloc] initWithSenderId:nil senderDisplayName:nil date:nil text:nil], @"Invalid init should throw");
}

- (void)testMessageIsEqual
{
    JSQTextMessage *msg = [[JSQTextMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:self.date
                                                              text:self.text];
    JSQTextMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqualObjects(msg, msg, @"Messages should be equal to itself");
}

- (void)testMessageArchiving
{
    JSQTextMessage *msg = [[JSQTextMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:self.date
                                                              text:self.text];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQTextMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertEqualObjects(msg, unarchivedMsg, @"Message should be equal");
}

@end
