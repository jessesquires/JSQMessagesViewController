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

- (void)testMessagesCollectionViewCellInit
{
    UINib *incomingCell = [JSQMessagesCollectionViewCellIncoming nib];
    XCTAssertNotNil(incomingCell, @"Nib should not be nil");
    
    NSString *incomingCellId = [JSQMessagesCollectionViewCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingCellId, @"Cell identifier should not be nil");
    
    UINib *outgoingCell = [JSQMessagesCollectionViewCellOutgoing nib];
    XCTAssertNotNil(outgoingCell, @"Nib should not be nil");
    
    NSString *outgoingCellId = [JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingCellId, @"Cell identifier should not be nil");
}

@end
