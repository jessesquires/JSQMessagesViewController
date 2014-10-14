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

#import "JSQMessagesCollectionViewFlowLayout.h"


@interface JSQMessagesCollectionViewFlowLayoutTests : XCTestCase
@end


@implementation JSQMessagesCollectionViewFlowLayoutTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testFlowLayoutInit
{
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    XCTAssertNotNil(layout, @"Layout should not be nil");
}

@end
