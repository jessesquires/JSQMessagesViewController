//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>

@interface JSQMessagesTimestampFormatter : NSObject

@property (copy, nonatomic) NSDictionary *dateTextAttributes;

@property (copy, nonatomic) NSDictionary *timeTextAttributes;

+ (JSQMessagesTimestampFormatter *)sharedFormatter;

- (NSString *)timestampForDate:(NSDate *)date;

- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date;

- (NSString *)timeForDate:(NSDate *)date;

- (NSString *)relativeDateForDate:(NSDate *)date;

@end
