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

#import "NSString+JSQMessages.h"

@implementation JSQMessage

#pragma mark - Initialization

+ (instancetype)messageWithText:(NSString *)text sender:(NSString *)sender
{
    return [[self alloc] initWithText:text sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithImage:(UIImage *)image sender:(NSString *)sender
{
    return [[self alloc] initWithImage:image sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithImageURL:(NSURL *)url placeholderImage:(UIImage *)placeholder sender:(NSString *)sender
{
    return [[self alloc] initWithImageURL:url placeholderImage:placeholder sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithVideoThumbnail:(UIImage *)thumbnail videoURL:(NSURL *)url sender:(NSString *)sender
{
    return [[self alloc] initWithVideoThumbnail:thumbnail videoURL:url sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithVideoPlaceholderImage:(UIImage *)placeholder videoURL:(NSURL *)url sender:(NSString *)sender
{
    return [[self alloc] initWithVideoPlaceholderImage:placeholder videoURL:url sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithAudio:(NSData *)audio sender:(NSString *)sender
{
    return [[self alloc] initWithAudio:audio sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithAudioURL:(NSURL *)url sender:(NSString *)sender
{
    return [[self alloc] initWithAudioURL:url sender:sender date:[NSDate date]];
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
        _type = JSQMessageText;
        _text = text;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
                       sender:(NSString *)sender
                         date:(NSDate *)date {
    NSParameterAssert(image != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessagePhoto;
        _data = UIImageJPEGRepresentation(image, 1.f);
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithImageURL:(NSURL *)url
                placeholderImage:(UIImage *)placeholder
                          sender:(NSString *)sender
                            date:(NSDate *)date
{
    NSParameterAssert(url != nil && [[[url absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(placeholder != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        
        if ([url isFileURL]) {
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSParameterAssert(data != nil);
            _data = data;
            _type = JSQMessagePhoto;
        }
        else {
            _type = JSQMessageRemotePhoto;
            _url = url;
            _thumbnail = placeholder;
        }
        _sender = sender;
        _date = date;
        
    }
    return self;
}

- (instancetype)initWithVideoThumbnail:(UIImage *)thumbnail
                              videoURL:(NSURL *)url
                                sender:(NSString *)sender
                                  date:(NSDate *)date
{
    NSParameterAssert(thumbnail != nil);
    NSParameterAssert(url != nil && [[[url absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        if ([url isFileURL]) {
            NSData *data = [NSData dataWithContentsOfURL:url];
            NSParameterAssert(data != nil);
            _type = JSQMessageVideo;
        }
        else {
            _type = JSQMessageRemoteVideo;
        }
        
        _thumbnail = thumbnail;
        _url = url;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithVideoPlaceholderImage:(UIImage *)placeholder
                                     videoURL:(NSURL *)url
                                       sender:(NSString *)sender
                                         date:(NSDate *)date
{
    NSParameterAssert(url != nil && ![url isFileURL] && [[[url absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(placeholder != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessageRemoteVideo;
        _videoThumbnailPlaceholder = placeholder;
        _url = url;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithAudio:(NSData *)audio
                       sender:(NSString *)sender
                         date:(NSDate *)date {
    NSParameterAssert(audio != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessageAudio;
        _data = audio;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithAudioURL:(NSURL *)url
                          sender:(NSString *)sender
                            date:(NSDate *)date
{
    NSParameterAssert(url != nil && [[[url absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(sender != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessageRemoteAudio;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = JSQMessageText;
        _data = nil;
        _url = nil;
        _thumbnail = nil;
        _videoThumbnailPlaceholder = nil;
        _text = @"";
        _sender = @"";
        _date = [NSDate date];
    }
    return self;
}

- (void)dealloc
{
    _data = nil;
    _url = nil;
    _thumbnail = nil;
    _videoThumbnailPlaceholder = nil;
    _text = nil;
    _sender = nil;
    _date = nil;
}

#pragma mark - JSQMessage

- (BOOL)isEqualToMessage:(JSQMessage *)aMessage
{
    BOOL mediaDataEqual = NO;
    switch (aMessage.type) {
        case JSQMessageText:
            mediaDataEqual = YES;
            break;
        case JSQMessagePhoto:
        case JSQMessageVideo:
        case JSQMessageAudio:
            mediaDataEqual = [self.data isEqualToData:aMessage.data];
            break;
        case JSQMessageRemotePhoto:
        case JSQMessageRemoteVideo:
        case JSQMessageRemoteAudio:
            mediaDataEqual = [self.url isEqual:aMessage.url];
            break;
    }
    
    return [self.text isEqualToString:aMessage.text]
            && [self.sender isEqualToString:aMessage.sender]
            && ([self.date compare:aMessage.date] == NSOrderedSame)
            && mediaDataEqual;
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
    return [self.text hash] ^ [self.sender hash] ^ [self.date hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@>[ %@, %@, %@, %d, %d, %@, %@ ]",
            [self class], self.sender, self.date, self.text, [self.data length], self.type, self.url, self.thumbnail];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _sender = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sender))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _data = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(data))];
        _type = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(type))] unsignedIntegerValue];
        _url = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(url))];
        _thumbnail = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(thumbnail))];
        _videoThumbnailPlaceholder = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(videoThumbnailPlaceholder))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.sender forKey:NSStringFromSelector(@selector(sender))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeObject:self.data forKey:NSStringFromSelector(@selector(data))];
    [aCoder encodeObject:@(self.type) forKey:NSStringFromSelector(@selector(type))];
    [aCoder encodeObject:self.url forKey:NSStringFromSelector(@selector(url))];
    [aCoder encodeObject:self.thumbnail forKey:NSStringFromSelector(@selector(thumbnail))];
    [aCoder encodeObject:self.videoThumbnailPlaceholder forKey:NSStringFromSelector(@selector(videoThumbnailPlaceholder))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQMessage *copy = [[[self class] alloc] init];
    copy.text = [self.text copy];
    copy.sender = [self.sender copy];
    copy.date = [self.date copy];
    copy.data = [self.data copy];
    copy.type = [[@(self.type) copy] unsignedIntegerValue];
    copy.url = [self.url copy];
    copy.thumbnail = [self.thumbnail copy];
    copy.videoThumbnailPlaceholder = [self.videoThumbnailPlaceholder copy];
    
    return copy;
}

@end
