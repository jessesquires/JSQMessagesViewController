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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSMessage.h"

@implementation JSMessage

#pragma mark - Initialization

- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        date:(NSDate *)date
                      userID:(NSNumber *)userID
{
    self = [super init];
    if (self) {
        _text = text ? text : @" ";
        _sender = sender;
        _date = date;
        _userID = userID;
    }
    return self;
}

- (void)dealloc
{
    _text = nil;
    _sender = nil;
    _date = nil;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _text = [aDecoder decodeObjectForKey:@"text"];
        _sender = [aDecoder decodeObjectForKey:@"sender"];
        _date = [aDecoder decodeObjectForKey:@"date"];
        _userID = [aDecoder decodeObjectForKey:@"userID"];
        _identifier = [aDecoder decodeObjectForKey:@"identifier"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.sender forKey:@"sender"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.userID forKey:@"userID"];
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithText:[self.text copy]
                                                    sender:[self.sender copy]
                                                      date:[self.date copy]
                                                    userID:[self.userID copy]];
}

#pragma mark - Comparing

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[JSMessage class]]) {
        return NO;
    }
    
    JSMessage * msg = (JSMessage *)object;
    
    return [msg.identifier isEqual:self.identifier];
}

- (void)hideTimestampIfNeeded:(JSMessage *)otherMessage
{
    
    NSInteger days = [JSMessage daysBetweenDate:self.date andDate:otherMessage.date ? otherMessage.date : [NSDate date]];
    if (days == 0) {
        self.timestampHidden = YES;
    } else {
        self.timestampHidden = NO;
    }
}

+ (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return abs([difference day]);
}

- (void)updateIdentifierIfNeeded
{
    if ([self.identifier integerValue] < 0) {
        NSDictionary * messagesCreated = [[NSUserDefaults standardUserDefaults] objectForKey:@"TMMessagesCreated"];
        if (messagesCreated[[self.identifier stringValue]]) {
            self.identifier = messagesCreated[[self.identifier stringValue]];
        }
    }
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"js message id: %@", self.identifier];
}

@end
