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

#import "NSString+JSQMessages.h"


@interface JSQMessagesNSStringTests : XCTestCase
@end


@implementation JSQMessagesNSStringTests

- (void)testTrimingStringWhitespace
{
    // GIVEN: a string of text
    NSString *loremIpsum = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

    // WHEN: the text is wrapped in white space
    NSString *string1 = [NSString stringWithFormat:@"       %@      ", loremIpsum];
    NSString *string2 = [NSString stringWithFormat:@"       %@", loremIpsum];
    NSString *string3 = [NSString stringWithFormat:@"%@      ", loremIpsum];
    
    // THEN: we can successfully trim extra white space
    XCTAssertEqualObjects(loremIpsum, [string1 jsq_stringByTrimingWhitespace], @"Strings should be equal after trimming whitespace");
    
    XCTAssertEqualObjects(loremIpsum, [string2 jsq_stringByTrimingWhitespace], @"Strings should be equal after trimming whitespace");
    
    XCTAssertEqualObjects(loremIpsum, [string3 jsq_stringByTrimingWhitespace], @"Strings should be equal after trimming whitespace");
}

@end
