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

#import "JSQVideoMediaitem.h"

#import "JSQMessagesMediaPlaceholderView.h"

#import "UIImage+JSQMessages.h"


@interface JSQVideoMediaitem ()

@property (strong, nonatomic) UIImageView *cachedVideoImageView;

@end


@implementation JSQVideoMediaitem

#pragma mark - Initialization

- (instancetype)initWithFileURL:(NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay
{
    self = [super init];
    if (self) {
        _fileURL = [fileURL copy];
        _isReadyToPlay = isReadyToPlay;
        _cachedVideoImageView = nil;
    }
    return self;
}

- (void)dealloc
{
    _fileURL = nil;
    _cachedVideoImageView = nil;
}

#pragma mark - Setters

- (void)setFileURL:(NSURL *)fileURL
{
    _fileURL = [fileURL copy];
    _cachedVideoImageView = nil;
}

- (void)setIsReadyToPlay:(BOOL)isReadyToPlay
{
    _isReadyToPlay = isReadyToPlay;
    _cachedVideoImageView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.fileURL == nil || !self.isReadyToPlay) {
        return nil;
    }
    
    if (self.cachedVideoImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImage *playIcon = [[UIImage imageNamed:@"play"] jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:playIcon];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeCenter;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 20.0f;
        self.cachedVideoImageView = imageView;
    }
    
    return self.cachedVideoImageView;
}

- (CGSize)mediaViewDisplaySize
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return CGSizeMake(300.0f, 180.0f);
    }
    return CGSizeMake(200.0f, 120.0f);
}

- (UIView *)mediaPlaceholderView
{
    return [JSQMessagesMediaPlaceholderView viewWithActivityIndicator];
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
    
    JSQVideoMediaitem *videoItem = (JSQVideoMediaitem *)object;
    
    return [self.fileURL isEqual:videoItem.fileURL]
            && self.isReadyToPlay == videoItem.isReadyToPlay;
}

- (NSUInteger)hash
{
    return self.fileURL.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: fileURL=%@, isReadyToPlay=%@>", [self class], self.fileURL, @(self.isReadyToPlay)];
}

- (id)debugQuickLookObject
{
    return [self mediaView] ?: [self mediaPlaceholderView];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _fileURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(fileURL))];
        _isReadyToPlay = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isReadyToPlay))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fileURL forKey:NSStringFromSelector(@selector(fileURL))];
    [aCoder encodeBool:self.isReadyToPlay forKey:NSStringFromSelector(@selector(isReadyToPlay))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithFileURL:self.fileURL
                                                isReadyToPlay:self.isReadyToPlay];
}

@end
