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

#import "JSQMessagesLoadEarlierHeaderView.h"


@interface JSQMessagesLoadEarlierHeaderViewTests : XCTestCase
@end


@implementation JSQMessagesLoadEarlierHeaderViewTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testLoadEarlierHeaderViewInit
{
    UINib *headerView = [JSQMessagesLoadEarlierHeaderView nib];
    XCTAssertNotNil(headerView, @"Nib should not be nil");
    
    NSString *headerId = [JSQMessagesLoadEarlierHeaderView headerReuseIdentifier];
    XCTAssertNotNil(headerId, @"Header view identifier should not be nil");
}

@end
