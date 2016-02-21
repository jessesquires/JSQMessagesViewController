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


@interface JSQMessageTextTests : XCTestCase

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *text;

@end


@implementation JSQMessageTextTests

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

#pragma mark - Text messages

- (void)testTextMessageInit
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                      text:self.text];
    XCTAssertNotNil(msg, @"Message should not be nil");
}

- (void)testTextMessageInvalidInit
{
    XCTAssertThrows([[JSQMessage alloc] initWithSenderId:nil senderDisplayName:nil date:nil text:nil], @"Invalid init should throw");
}

- (void)testTextMessageIsEqual
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                      text:self.text];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertEqualObjects(msg, msg, @"Messages should be equal to itself");
}

- (void)testTextMessageArchiving
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                      text:self.text];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertEqualObjects(msg, unarchivedMsg, @"Message should be equal");
}

@end
