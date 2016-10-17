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

#import "JSQVideoMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

#import "UIImage+JSQMessages.h"


@interface JSQVideoMediaItem ()

@property (strong, nonatomic) UIImageView *cachedVideoImageView;

@end


@implementation JSQVideoMediaItem

#pragma mark - Initialization

- (instancetype)initWithFileURL:(NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _fileURL = [fileURL copy];
        _isReadyToPlay = isReadyToPlay;
        _image = [image copy];
        _cachedVideoImageView = nil;
    }
    return self;
}

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

- (void)clearCachedMediaViews
{
    [super clearCachedMediaViews];
    _cachedVideoImageView = nil;
}

#pragma mark - Setters

- (void)setFileURL:(NSURL *)fileURL
{
    _fileURL = [fileURL copy];
    _cachedVideoImageView = nil;
}

- (void)setImage:(UIImage *)image
{
    _image = [image copy];
    _cachedVideoImageView = nil;
}

- (void)setIsReadyToPlay:(BOOL)isReadyToPlay
{
    _isReadyToPlay = isReadyToPlay;
    _cachedVideoImageView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedVideoImageView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.fileURL == nil || !self.isReadyToPlay) {
        return nil;
    }

    if (self.cachedVideoImageView == nil)
    {
        if (_image == nil)
        {
            CGSize size = [self mediaViewDisplaySize];
            UIImage *playIcon = [[UIImage jsq_defaultPlayImage] jsq_imageMaskedWithColor:[UIColor lightGrayColor]];

            UIImageView *imageView = [[UIImageView alloc] initWithImage:playIcon];
            imageView.backgroundColor = [UIColor blackColor];
            imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
            imageView.contentMode = UIViewContentModeCenter;
            imageView.clipsToBounds = YES;
            [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:imageView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
            self.cachedVideoImageView = imageView;
        }
        else
        {
            CGSize size = [self mediaViewDisplaySize];
            UIImage *playIcon = [[UIImage jsq_defaultPlayImage] jsq_imageMaskedWithColor:[UIColor lightGrayColor]];

            CGRect scaledImageRect = CGRectZero;
            CGFloat aspectWidth = _image.size.width / playIcon.size.width;
            CGFloat aspectHeight = _image.size.height / playIcon.size.height;
            CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
            scaledImageRect.size.width = playIcon.size.width * aspectRatio / 5;
            scaledImageRect.size.height = playIcon.size.height * aspectRatio / 5;
            scaledImageRect.origin.x = (_image.size.width - scaledImageRect.size.width) / 2.0f;
            scaledImageRect.origin.y = (_image.size.height - scaledImageRect.size.height) / 2.0f;

            UIGraphicsBeginImageContextWithOptions(_image.size, NO, 0.0f);
            [_image drawInRect:CGRectMake(0, 0, _image.size.width, _image.size.height)];
            [playIcon drawInRect:scaledImageRect];
            UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            UIImageView *imageView = [[UIImageView alloc] initWithImage:resultImage];
            imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:imageView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
            self.cachedVideoImageView = imageView;
        }
    }

    return self.cachedVideoImageView;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }

    JSQVideoMediaItem *videoItem = (JSQVideoMediaItem *)object;

    return [self.fileURL isEqual:videoItem.fileURL]
    && self.isReadyToPlay == videoItem.isReadyToPlay;
}

- (NSUInteger)hash
{
    return super.hash ^ self.fileURL.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: fileURL=%@, isReadyToPlay=%@, appliesMediaViewMaskAsOutgoing=%@, image=%@>",
            [self class], self.fileURL, @(self.isReadyToPlay), @(self.appliesMediaViewMaskAsOutgoing), self.image];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _fileURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(fileURL))];
        _isReadyToPlay = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isReadyToPlay))];
        _image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.fileURL forKey:NSStringFromSelector(@selector(fileURL))];
    [aCoder encodeBool:self.isReadyToPlay forKey:NSStringFromSelector(@selector(isReadyToPlay))];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQVideoMediaItem *copy = [[[self class] allocWithZone:zone] initWithFileURL:self.fileURL
                                                                   isReadyToPlay:self.isReadyToPlay
                                                                           image:self.image];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
