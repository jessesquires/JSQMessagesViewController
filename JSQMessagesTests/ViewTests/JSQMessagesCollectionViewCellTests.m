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

#import "JSQMessagesCollectionViewTextCellIncoming.h"
#import "JSQMessagesCollectionViewTextCellOutgoing.h"


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

- (void)testMessagesCollectionViewCellInit
{
    UINib *incomingCell = [JSQMessagesCollectionViewTextCellIncoming nib];
    XCTAssertNotNil(incomingCell, @"Nib should not be nil");
    
    NSString *incomingCellId = [JSQMessagesCollectionViewTextCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingCellId, @"Cell identifier should not be nil");
    
    UINib *outgoingCell = [JSQMessagesCollectionViewTextCellOutgoing nib];
    XCTAssertNotNil(outgoingCell, @"Nib should not be nil");
    
    NSString *outgoingCellId = [JSQMessagesCollectionViewTextCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingCellId, @"Cell identifier should not be nil");
}

@end
