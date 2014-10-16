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

#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"


@interface JSQMessagesCollectionViewCellTests : XCTestCase
@end


@implementation JSQMessagesCollectionViewCellTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testMessagesIncomingCollectionViewCellInit
{
    UINib *incomingCell = [JSQMessagesCollectionViewCellIncoming nib];
    XCTAssertNotNil(incomingCell, @"Nib should not be nil");
    
    NSString *incomingCellId = [JSQMessagesCollectionViewCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingCellId, @"Cell identifier should not be nil");
    XCTAssertEqualObjects(incomingCellId, NSStringFromClass([JSQMessagesCollectionViewCellIncoming class]));
}

- (void)testMessagesOutgoingCollectionViewCellInit
{
    UINib *outgoingCell = [JSQMessagesCollectionViewCellOutgoing nib];
    XCTAssertNotNil(outgoingCell, @"Nib should not be nil");
    
    NSString *outgoingCellId = [JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingCellId, @"Cell identifier should not be nil");
    XCTAssertEqualObjects(outgoingCellId, NSStringFromClass([JSQMessagesCollectionViewCellOutgoing class]));
}

@end
