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

+ (instancetype)messageWithImage:(UIImage *)sourceImage thumbnailImage:(UIImage *)thumbnailImage sender:(NSString *)sender
{
    return [[self alloc] initWithImage:sourceImage thumbnailImage:thumbnailImage sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithImageURL:(NSURL *)sourceImageURL placeholderImage:(UIImage *)placeholder sender:(NSString *)sender
{
    return [[self alloc] initWithImageURL:sourceImageURL placeholderImage:placeholder sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithVideoURL:(NSURL *)sourceVideoURL thumbnail:(UIImage *)thumbnail sender:(NSString *)sender
{
    return [[self alloc] initWithVideoURL:sourceVideoURL thumbnail:thumbnail sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithVideoURL:(NSURL *)remoteURL placeholderImage:(UIImage *)placeholder sender:(NSString *)sender
{
    return [[self alloc] initWithVideoURL:remoteURL placeholderImage:placeholder sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithAudio:(NSData *)audio sender:(NSString *)sender
{
    return [[self alloc] initWithAudio:audio sender:sender date:[NSDate date]];
}

+ (instancetype)messageWithAudioURL:(NSURL *)sourceURL sender:(NSString *)sender
{
    return [[self alloc] initWithAudioURL:sourceURL sender:sender date:[NSDate date]];
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

- (instancetype)initWithImage:(UIImage *)sourceImage
               thumbnailImage:(UIImage *)thumbnailImage
                       sender:(NSString *)sender
                         date:(NSDate *)date
{
    NSParameterAssert(sourceImage != nil);
    NSParameterAssert(thumbnailImage != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessagePhoto;
        _sourceImage = sourceImage;
        _thumbnailImage = thumbnailImage;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithImageURL:(NSURL *)sourceImageURL
                placeholderImage:(UIImage *)placeholder
                          sender:(NSString *)sender
                            date:(NSDate *)date
{
    NSParameterAssert(sourceImageURL != nil &&  ![sourceImageURL isFileURL] && [[[sourceImageURL absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(placeholder != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessageRemotePhoto;
        _sourceURL = sourceImageURL;
        _thumbnailImage = placeholder;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithVideoURL:(NSURL *)sourceVideoURL
                       thumbnail:(UIImage *)thumbnail
                          sender:(NSString *)sender
                            date:(NSDate *)date
{
    NSParameterAssert(thumbnail != nil);
    NSParameterAssert(sourceVideoURL != nil && [[[sourceVideoURL absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        if ([sourceVideoURL isFileURL]) {
            NSData *data = [NSData dataWithContentsOfURL:sourceVideoURL];
            NSParameterAssert(data != nil);
            
            _type = JSQMessageVideo;
        }
        else {
            _type = JSQMessageRemoteVideo;
        }
        
        _videoThumbnail = thumbnail;
        _sourceURL = sourceVideoURL;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithVideoURL:(NSURL *)remoteURL
                placeholderImage:(UIImage *)placeholder
                          sender:(NSString *)sender
                            date:(NSDate *)date
{
    NSParameterAssert(remoteURL != nil && ![remoteURL isFileURL] && [[[remoteURL absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(placeholder != nil);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessageRemoteVideo;
        _videoThumbnailPlaceholder = placeholder;
        _sourceURL = remoteURL;
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
        _audio = audio;
        _sender = sender;
        _date = date;
    }
    return self;
}

- (instancetype)initWithAudioURL:(NSURL *)sourceURL
                          sender:(NSString *)sender
                            date:(NSDate *)date
{
    NSParameterAssert(sourceURL != nil && [[[sourceURL absoluteString] jsq_stringByTrimingWhitespace] length] > 0);
    NSParameterAssert(sender != nil);
    NSParameterAssert(date != nil);
    
    self = [self init];
    if (self) {
        _type = JSQMessageRemoteAudio;
        _sender = sender;
        _date = date;
        _sourceURL = sourceURL;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _type = JSQMessageText;
        _sender = @"";
        _date = [NSDate date];
        _text = @"";
        _audio = nil;
        _sourceImage = nil;
        _thumbnailImage = nil;
        _videoThumbnail = nil;
        _videoThumbnailPlaceholder = nil;
        _sourceURL = nil;
    }
    return self;
}

- (void)dealloc
{
    _sender = nil;
    _date = nil;
    _text = nil;
    _audio = nil;
    _sourceImage = nil;
    _thumbnailImage = nil;
    _videoThumbnail = nil;
    _videoThumbnailPlaceholder = nil;
    _sourceURL = nil;
}

#pragma mark - JSQMessage

- (BOOL)isEqualToMessage:(JSQMessage *)aMessage
{
    BOOL typeEqual = self.type == aMessage.type;

    BOOL senderEqual = [self.sender isEqualToString:aMessage.sender];
    
    BOOL dateEqual = [self.date compare:aMessage.date] == NSOrderedSame;
    
    BOOL textEqual = [self.text isEqualToString:aMessage.text];
    
    BOOL audioEqual = (!self.audio && !aMessage.audio) ? YES : [self.audio isEqualToData:aMessage.audio];
    
    BOOL sourceImageEqual = (!self.sourceImage && !aMessage.sourceImage)
    ? YES
    : [UIImageJPEGRepresentation(self.sourceImage, .1f) isEqualToData:UIImageJPEGRepresentation(aMessage.sourceImage, .1f)];
    
    BOOL thumbnailImageEqual = (!self.thumbnailImage && !aMessage.thumbnailImage)
    ? YES
    : [UIImageJPEGRepresentation(self.thumbnailImage, .1f) isEqualToData:UIImageJPEGRepresentation(aMessage.thumbnailImage, .1f)];
    
    BOOL videoThumbnailEqual = (!self.videoThumbnail && !aMessage.videoThumbnail)
    ? YES
    : [UIImageJPEGRepresentation(self.videoThumbnail, .1f) isEqual:UIImageJPEGRepresentation(aMessage.videoThumbnail, .1f)];
    
    BOOL videoThumbnailPlaceholderEqual = (!self.videoThumbnailPlaceholder && !aMessage.videoThumbnailPlaceholder)
    ? YES
    : [UIImageJPEGRepresentation(self.videoThumbnailPlaceholder, .1f) isEqual:UIImageJPEGRepresentation(aMessage.videoThumbnailPlaceholder, .1f)];
    
    BOOL sourceURLEqual = (!self.sourceURL && !aMessage.sourceURL)
    ? YES
    : [self.sourceURL isEqual:aMessage.sourceURL];
    
    return typeEqual && senderEqual && dateEqual && textEqual && audioEqual
    && sourceImageEqual && thumbnailImageEqual && videoThumbnailEqual && videoThumbnailPlaceholderEqual
    &&sourceURLEqual;
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
    return [NSString stringWithFormat:@"<%@: %p; type = %d; sender = %@; date = %@; text = '%@'; "
            @"audio data length = %d; sourceImage = %@; thumbnailImage = %@; "
             @"videoThumbnail = %@; videoThumbnailPlaceholder = %@; sourceURL = %@>",
            [self class], self, self.type, self.sender, self.date, self.text,
            [self.audio length], self.sourceImage, self.thumbnailImage, self.videoThumbnail,
            self.videoThumbnailPlaceholder, self.sourceURL];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _type = [[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(type))] unsignedIntegerValue];
        _sender = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sender))];
        _date = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(date))];
        _text = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(text))];
        _audio = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(audio))];
        _sourceImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sourceImage))];
        _thumbnailImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(thumbnailImage))];
        _videoThumbnail = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(videoThumbnail))];
        _videoThumbnailPlaceholder = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(videoThumbnailPlaceholder))];
        _sourceURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(sourceURL))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.type) forKey:NSStringFromSelector(@selector(type))];
    [aCoder encodeObject:self.sender forKey:NSStringFromSelector(@selector(sender))];
    [aCoder encodeObject:self.date forKey:NSStringFromSelector(@selector(date))];
    [aCoder encodeObject:self.text forKey:NSStringFromSelector(@selector(text))];
    [aCoder encodeObject:self.audio forKey:NSStringFromSelector(@selector(audio))];
    [aCoder encodeObject:self.sourceImage forKey:NSStringFromSelector(@selector(sourceImage))];
    [aCoder encodeObject:self.thumbnailImage forKey:NSStringFromSelector(@selector(thumbnailImage))];
    [aCoder encodeObject:self.videoThumbnail forKey:NSStringFromSelector(@selector(videoThumbnail))];
    [aCoder encodeObject:self.videoThumbnailPlaceholder forKey:NSStringFromSelector(@selector(videoThumbnailPlaceholder))];
    [aCoder encodeObject:self.sourceURL forKey:NSStringFromSelector(@selector(sourceURL))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQMessage *copy = [[[self class] alloc] init];
    copy.type = [[@(self.type) copy] unsignedIntegerValue];
    copy.sender = [self.sender copy];
    copy.date = [self.date copy];
    copy.text = [self.text copy];
    copy.audio = [self.audio copy];
    copy.sourceImage = [self.sourceImage copy];
    copy.thumbnailImage = [self.thumbnailImage copy];
    copy.videoThumbnail = [self.videoThumbnail copy];
    copy.videoThumbnailPlaceholder = [self.videoThumbnailPlaceholder copy];
    copy.sourceURL = [self.sourceURL copy];
    
    return copy;
}

@end
