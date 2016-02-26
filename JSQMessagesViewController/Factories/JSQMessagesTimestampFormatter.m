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

#import "JSQMessagesTimestampFormatter.h"

@interface JSQMessagesTimestampFormatter ()

@property (strong, nonatomic, readwrite) NSDateFormatter *dateFormatter;

@end



@implementation JSQMessagesTimestampFormatter

#pragma mark - Initialization

+ (JSQMessagesTimestampFormatter *)sharedFormatter
{
    static JSQMessagesTimestampFormatter *_sharedFormatter = nil;
    
    static dispatch_once_t onceToken = 0;
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
        
        UIColor *color = [UIColor lightGrayColor];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        _dateTextAttributes = @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle };
        
        _timeTextAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName : color,
                                 NSParagraphStyleAttributeName : paragraphStyle };
    }
    return self;
}

#pragma mark - Formatter

- (NSString *)timestampForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self.dateFormatter stringFromDate:date];
}

- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    NSString *relativeDate = [self relativeDateForDate:date];
    NSString *time = [self timeForDate:date];
    
    NSMutableAttributedString *timestamp = nil;
    
    if ([relativeDate isEqualToString:time]) {
        timestamp = [[NSMutableAttributedString alloc] initWithString:relativeDate
                                                           attributes:self.timeTextAttributes];
        
    }else{
        timestamp = [[NSMutableAttributedString alloc] initWithString:relativeDate
                                                           attributes:self.dateTextAttributes];
        
        
        [timestamp appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        
        [timestamp appendAttributedString:[[NSAttributedString alloc] initWithString:time
                                                                          attributes:self.timeTextAttributes]];
    }
    
    return [[NSAttributedString alloc] initWithAttributedString:timestamp];
}

- (NSString *)timeForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    [self.dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [self.dateFormatter stringFromDate:date];
}

- (NSInteger)yearForDate:(NSDate *)date
{
    return [[NSCalendar currentCalendar] components:(NSCalendarUnitYear)
                                           fromDate:date].year;
}

- (NSString *)relativeDateForDate:(NSDate *)date
{
    if (!date) {
        return nil;
    }
    
    //Now
    NSDateFormatter *dateFormatter = [self.dateFormatter copy];
    [dateFormatter setDoesRelativeDateFormatting:NO];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *nowDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *now = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@235959",nowDateString]];
    
    NSTimeInterval timeInterval = abs([now timeIntervalSinceDate:date]);
    
    if (timeInterval < 24*60*60){
        return [self timeForDate:date];
    }else if (timeInterval >= 2*24*60*60 && timeInterval < 7*24*60*60){
        [dateFormatter setDateFormat:@"EEEE"];
        return [dateFormatter stringFromDate:date];
    }else if (timeInterval >= 7*24*60*60 && timeInterval <= 365*24*60*60){
        NSInteger year = [self yearForDate:now];
        NSInteger dateYear = [self yearForDate:date];
        if (year == dateYear) {
            [dateFormatter setDateFormat:@"MM/dd"];
        }else{
            [dateFormatter setDateFormat:@"yy/MM/dd"];
        }
        return [dateFormatter stringFromDate:date];
    }
    
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    return [self.dateFormatter stringFromDate:date];
}

@end
