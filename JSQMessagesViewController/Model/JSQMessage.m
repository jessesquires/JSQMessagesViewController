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

#import "JSQMessage.h"

@implementation JSQMessage

#pragma mark - Initialization

+ (instancetype)messageWithText:(NSString *)text sender:(NSString *)sender
{
    return [[JSQMessage alloc] initWithText:text sender:sender date:[NSDate date]];
}

- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        date:(NSDate *)date
{
    NSAssert(text, @"ERROR: text must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(sender, @"ERROR: sender must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(date, @"ERROR: date must not be nil: %s", __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self) {
        _text = text;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (void)dealloc
{
    _text = nil;
    _sender = nil;
    _date = nil;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    JSQMessage *msg = (JSQMessage *)object;
    
    return [self.text isEqualToString:msg.text]
            && [self.sender isEqualToString:msg.sender]
            && ([self.date compare:msg.date] == NSOrderedSame);
}

- (NSUInteger)hash
{
    return [super hash] ^ [self.text hash] ^ [self.sender hash] ^ [self.date hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>[ %@, %@, %@ ]", [self class], self.sender, self.date, self.text];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _sender = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sender))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.sender forKey:NSStringFromSelector(@selector(sender))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithText:[self.text copy]
                                                    sender:[self.sender copy]
                                                      date:[self.date copy]];
}

@end
