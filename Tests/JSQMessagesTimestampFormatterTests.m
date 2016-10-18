//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>

@interface JSQMessagesTimestampFormatterTests : XCTestCase

@end


@implementation JSQMessagesTimestampFormatterTests

- (void)testTimestampFormatterInit
{
    JSQMessagesTimestampFormatter *formatter = [JSQMessagesTimestampFormatter sharedFormatter];
    XCTAssertNotNil(formatter, @"Formatter should not be nil");
    XCTAssertEqualObjects(formatter, [JSQMessagesTimestampFormatter sharedFormatter], @"Shared formatter should return the same instance");
    
    UIColor *color = [UIColor lightGrayColor];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dateAttrs = @{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle };
    
    NSDictionary *timeAttrs = @{ NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleBody],
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle };
    
    XCTAssertEqualObjects(formatter.dateTextAttributes, dateAttrs, @"Date attributes should be equal to default values");
    
    XCTAssertEqualObjects(formatter.timeTextAttributes, timeAttrs, @"Time attributes should be equal to default values");
    
    XCTAssertNotNil(formatter.dateFormatter, @"Property should not be nil");
}

- (void)testTimestampForDate
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setCalendar:[NSCalendar currentCalendar]];
    [components setYear:2013];
    [components setMonth:6];
    [components setDay:6];
    [components setHour:19];
    [components setMinute:6];
    [components setSecond:0];
    
    NSDate *date = [components date];
    
    NSString *timestampString = [[JSQMessagesTimestampFormatter sharedFormatter] timestampForDate:date];
    
    XCTAssertEqualObjects(timestampString, @"Jun 6, 2013, 7:06 PM", @"Timestamp string should return expected value");
    
    NSAttributedString *timestampAttributedString = [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:date];
    
    XCTAssertEqualObjects([timestampAttributedString string], @"Jun 6, 2013 7:06 PM", @"Attributed timestamp string should return expected value");
}

- (void)testTimeForDate
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setCalendar:[NSCalendar currentCalendar]];
    [components setHour:7];
    [components setMinute:6];
    [components setSecond:0];
    
    NSDate *date = [components date];
    
    NSString *timeForDateString = [[JSQMessagesTimestampFormatter sharedFormatter] timeForDate:date];
    
    XCTAssertEqualObjects(timeForDateString, @"7:06 AM", @"Time string should return expected value");
}

- (void)testRelativeDataForDate
{
    NSDate *date = [NSDate date];
    
    NSString *relativeDateString = [[JSQMessagesTimestampFormatter sharedFormatter] relativeDateForDate:date];
    
    XCTAssertEqualObjects(relativeDateString, @"Today", @"Relative date string should return expected value");
}

@end
