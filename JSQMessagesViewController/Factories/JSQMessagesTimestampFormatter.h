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

+ (JSQMessagesTimestampFormatter *)sharedFormatter;

- (NSString *)timestampForDate:(NSDate *)date;

- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date;

@end
