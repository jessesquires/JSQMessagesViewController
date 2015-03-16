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

#import "JSQMessage.h"


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

- (NSUInteger)hash { return 10000; }

- (NSUInteger)mediaHash { return self.hash; }

@end




@interface JSQMessageMediaTests : XCTestCase

@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *senderDisplayName;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) id mockMediaData;

@end


@implementation JSQMessageMediaTests

- (void)setUp
{
    [super setUp];
    self.senderId = @"324543-43556-212343";
    self.senderDisplayName = @"Jesse Squires";
    self.date = [NSDate date];
    
    self.mockMediaData = [OCMockObject mockForProtocol:@protocol(JSQMessageMediaData)];
    [[self.mockMediaData stub] mediaHash];
}

- (void)tearDown
{
    self.senderId = nil;
    self.senderDisplayName = nil;
    self.date = nil;
    self.mockMediaData = nil;
    [super tearDown];
}

- (void)testMediaMessageInit
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                     media:self.mockMediaData];
    XCTAssertNotNil(msg, @"Message should not be nil");
}

- (void)testMediaMessageInvalidInit
{
    XCTAssertThrows([[JSQMessage alloc] init], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithSenderId:nil senderDisplayName:nil date:nil media:nil], @"Invalid init should throw");
}

- (void)testMediaMessageIsEqual
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                     media:self.mockMediaData];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertEqualObjects(msg, msg, @"Messages should be equal to itself");
}

- (void)testMediaMessageArchiving
{
    JSQMessage *msg = [[JSQMessage alloc] initWithSenderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date
                                                     media:[FakeMedia new]];
    
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertEqualObjects(msg, unarchivedMsg, @"Message should be equal");
}

@end
