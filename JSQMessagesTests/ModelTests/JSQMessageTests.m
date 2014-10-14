//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "JSQMessage.h"


@interface JSQMessageTests : XCTestCase

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSDate *date;

@end


@implementation JSQMessageTests

- (void)setUp
{
    [super setUp];
    self.text = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque"
                @"laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi"
                @"architecto beatae vitae dicta sunt explicabo.";
    self.sender = @"Jesse Squires";
    self.date = [NSDate date];
}

- (void)tearDown
{
    self.text = nil;
    self.sender = nil;
    self.date = nil;
    [super tearDown];
}

- (void)testMessageInit
{
    JSQMessage *msg0 = [[JSQMessage alloc] initWithText:self.text sender:self.sender date:self.date];
    XCTAssertNotNil(msg0, @"Message should not be nil");
    
    JSQMessage *msg1 = [JSQMessage messageWithText:self.text sender:self.sender];
    XCTAssertNotNil(msg1, @"Message shold not be nil");
}

- (void)testMessageInvalidInit
{
    XCTAssertThrows([JSQMessage messageWithText:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithText:self.text sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithText:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithText:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:self.text sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:nil sender:nil date:self.date], @"Invalid init should throw");
}

- (void)testMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithText:self.text sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithText:self.text sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

@end
