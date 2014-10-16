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

#import "JSQMessagesTypingIndicatorFooterView.h"


@interface JSQMessagesTypingIndicatorFooterViewTests : XCTestCase
@end


@implementation JSQMessagesTypingIndicatorFooterViewTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testTypingIndicatorFooterViewInit
{
    UINib *footerView = [JSQMessagesTypingIndicatorFooterView nib];
    XCTAssertNotNil(footerView, @"Nib should not be nil");
    
    NSString *footerId = [JSQMessagesTypingIndicatorFooterView footerReuseIdentifier];
    XCTAssertNotNil(footerId, @"Footer view identifier should not be nil");
}

@end
