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

#import <OCMock/OCMock.h>

#import "JSQMediaMessage.h"


// Fake media object for testing
@interface FakeMedia : NSObject <JSQMessageMediaData, NSCoding>
@end

@implementation FakeMedia

- (UIView *)mediaView { return [UIView new]; }
- (UIView *)mediaPlaceholderView { return [self mediaView]; }
- (CGSize)mediaViewDisplaySize { return CGSizeMake(50, 50); }

- (void)encodeWithCoder:(NSCoder *)aCoder { }
- (id)initWithCoder:(NSCoder *)aDecoder { return [self init]; }

- (BOOL)isEqual:(id)object { return YES; }

@end




@interface JSQMediaMessageTests : XCTestCase

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) id<JSQMessageMediaData> mockMediaData;

@end


@implementation JSQMediaMessageTests

- (void)setUp
{
    [super setUp];
    self.senderId = @"324543-43556-212343";
    self.senderDisplayName = @"Jesse Squires";
    self.date = [NSDate date];
    self.mockMediaData = [OCMockObject mockForProtocol:@protocol(JSQMessageMediaData)];
}

- (void)tearDown
{
    self.senderId = nil;
    self.senderDisplayName = nil;
    self.date = nil;
    self.mockMediaData = nil;
    [super tearDown];
}

- (void)testTextMessageInit
{
    JSQMediaMessage *msg = [[JSQMediaMessage alloc] initWithSenderId:self.senderId
                                                   senderDisplayName:self.senderDisplayName
                                                                date:self.date
                                                               media:self.mockMediaData];
    XCTAssertNotNil(msg, @"Message should not be nil");
}

- (void)testMessageInvalidInit
{
    XCTAssertThrows([[JSQMediaMessage alloc] init], @"Invalid init should throw");
    XCTAssertThrows([[JSQMediaMessage alloc] initWithSenderId:nil senderDisplayName:nil date:nil media:nil], @"Invalid init should throw");
}

- (void)testMessageIsEqual
{
    JSQMediaMessage *msg = [[JSQMediaMessage alloc] initWithSenderId:self.senderId
                                                   senderDisplayName:self.senderDisplayName
                                                                date:self.date
                                                               media:self.mockMediaData];
    JSQMediaMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqualObjects(msg, msg, @"Messages should be equal to itself");
}

- (void)testMessageArchiving
{
    JSQMediaMessage *msg = [[JSQMediaMessage alloc] initWithSenderId:self.senderId
                                                   senderDisplayName:self.senderDisplayName
                                                                date:self.date
                                                               media:[FakeMedia new]];
    
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMediaMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertEqualObjects(msg, unarchivedMsg, @"Message should be equal");
}

@end
