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

#import "JSQMessagesTimestampFormatter.h"

@interface JSQMessagesTimestampFormatter ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDictionary *textAttributes;

@end



@implementation JSQMessagesTimestampFormatter

#pragma mark - Initialization

+ (JSQMessagesTimestampFormatter *)sharedFormatter
{
    static JSQMessagesTimestampFormatter *_sharedFormatter;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFormatter = [[JSQMessagesTimestampFormatter alloc] init];
    });
    
    return _sharedFormatter;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setLocale:[NSLocale currentLocale]];
        [_dateFormatter setDoesRelativeDateFormatting:YES];
        
        _textAttributes = nil;
    }
    return self;
}

#pragma mark - Formatter

- (NSString *)timestampForDate:(NSDate *)date
{
    return [self.dateFormatter stringFromDate:date];
}

- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date
{
    NSString *timestamp = [self timestampForDate:date];
    
    return [[NSAttributedString alloc] initWithString:timestamp attributes:nil];
}

@end
