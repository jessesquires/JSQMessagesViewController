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

+ (instancetype)messageWithText:(NSString *)text sender:(NSString *)sender
{
    return [[JSQMessage alloc] initWithText:text sender:sender date:[NSDate date]];
}

- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        date:(NSDate *)date
{
    NSParameterAssert(text != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _text = text;
        _sender = sender;
        _date = date;
        _kind = JSQMessageTextKind;
    }
    return self;
}

+ (instancetype)messageWithImage:(UIImage *)image sender:(NSString *)sender;
{
    return [[self alloc] initWithImage:image sender:sender date:[NSDate date]];
}

- (instancetype)initWithImage:(UIImage *)image
                       sender:(NSString *)sender
                         date:(NSDate *)date;
{
    NSParameterAssert(image != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);

    self = [self init];
    if (self)
    {
        _sender = sender;
        _date = [NSDate date];
        _image = image;
        _kind = JSQMessageLocalMediaKind;
    }
    return self;
}

+ (instancetype)messageWithURL:(NSURL *)url sender:(NSString *)sender;
{
    return [[self alloc] initWithURL:url sender:sender date:[NSDate date]];
}

- (instancetype)initWithURL:(NSURL *)url
                     sender:(NSString *)sender
                       date:(NSDate *)date;
{
    NSParameterAssert(url != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self)
    {
        _sender = sender;
        _date = [NSDate date];
        _url = url;
        _kind = JSQMessageRemoteMediaKind;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _text = @"";
        _sender = @"";
        _date = [NSDate date];
        _kind = JSQMessageTextKind;
    }
    return self;
}

- (void)dealloc
{
    _text = nil;
    _sender = nil;
    _date = nil;
}

#pragma mark - JSQMessage

- (BOOL)isEqualToMessage:(JSQMessage *)aMessage
{
    return [self.text isEqualToString:aMessage.text]
            && [self.sender isEqualToString:aMessage.sender]
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
    
    return [self isEqualToMessage:(JSQMessage *)object];
}

- (NSUInteger)hash
{
    return [self.text hash] ^ [self.sender hash] ^ [self.date hash] ^ [self.url hash] ^ [self.image hash] ^ [@(self.kind) hash];
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
        _url = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(url))];
        _image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
        _kind = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(kind))] integerValue];
        _sender = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sender))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.url forKey:NSStringFromSelector(@selector(url))];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
    [aCoder encodeObject:@(self.kind) forKey:NSStringFromSelector(@selector(kind))];
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
