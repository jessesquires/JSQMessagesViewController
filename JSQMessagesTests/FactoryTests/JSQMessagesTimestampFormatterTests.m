//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "JSQMessagesTimestampFormatter.h"


@interface JSQMessagesTimestampFormatterTests : XCTestCase
@end


@implementation JSQMessagesTimestampFormatterTests

- (void)testTimestampFormatterInit
{
    JSQMessagesTimestampFormatter *formatter = [JSQMessagesTimestampFormatter sharedFormatter];
    XCTAssertNotNil(formatter, @"Formatter should not be nil");
    XCTAssertNotNil(formatter.dateTextAttributes, @"Attributes should not be nil");
    XCTAssertNotNil(formatter.timeTextAttributes, @"Attributes should not be nil");
}

@end
