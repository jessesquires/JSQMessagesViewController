//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

#import "JSQMessage.h"

@implementation JSQMessage

#pragma mark - Initialization

+ (instancetype)messageWithText:(NSString *)text
                       senderId:(NSString *)senderId
              senderDisplayName:(NSString *)senderDisplayName
{
    return [[JSQMessage alloc] initWithText:text
                                   senderId:senderId
                          senderDisplayName:senderDisplayName
                                       date:[NSDate date]];
}

- (instancetype)initWithText:(NSString *)text
                    senderId:(NSString *)senderId
           senderDisplayName:(NSString *)senderDisplayName
                        date:(NSDate *)date
{
    NSParameterAssert(text != nil);
    NSParameterAssert(senderId != nil);
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(date != nil);
    
    self = [super init];
    if (self) {
        _text = [text copy];
        _senderId = [senderId copy];
        _senderDisplayName = [senderDisplayName copy];
        _date = [date copy];
    }
    return self;
}

- (id)init
{
    NSAssert(NO, @"%s is not a valid initializer for %@. Use %@ instead.",
             __PRETTY_FUNCTION__, [self class], NSStringFromSelector(@selector(initWithText:senderId:senderDisplayName:date:)));
    return nil;
}

- (void)dealloc
{
    _text = nil;
    _senderId = nil;
    _senderDisplayName = nil;
    _date = nil;
}

#pragma mark - JSQMessage

- (BOOL)isEqualToMessage:(JSQMessage *)aMessage
{
    return [self.text isEqualToString:aMessage.text]
            && [self.senderId isEqualToString:aMessage.senderId]
            && [self.senderDisplayName isEqualToString:aMessage.senderDisplayName]
            && ([self.date compare:aMessage.date] == NSOrderedSame);
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    JSQMessage *aMessage = (JSQMessage *)object;
    
    return [self.text isEqualToString:aMessage.text]
            && [self.senderId isEqualToString:aMessage.senderId]
            && [self.senderDisplayName isEqualToString:aMessage.senderDisplayName]
            && ([self.date compare:aMessage.date] == NSOrderedSame);
}

- (NSUInteger)hash
{
    return [self.senderId hash] ^ [self.date hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: senderId=%@, senderDisplayName=%@, date=%@, text=%@>",
            [self class], self.senderId, self.senderDisplayName, self.date, self.text];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _senderId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderId))];
        _senderDisplayName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderDisplayName))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.senderId forKey:NSStringFromSelector(@selector(senderId))];
    [aCoder encodeObject:self.senderDisplayName forKey:NSStringFromSelector(@selector(senderDisplayName))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithText:self.text
                                                  senderId:self.senderId
                                         senderDisplayName:self.senderDisplayName
                                                      date:self.date];
}

@end
