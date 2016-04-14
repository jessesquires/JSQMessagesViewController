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

#import "JSQPhotoMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"


@interface JSQPhotoMediaItem ()

@property (strong, nonatomic) UIImageView *cachedImageView;

@end


@implementation JSQPhotoMediaItem

#pragma mark - Initialization

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = [image copy];
        _cachedImageView = nil;
        _imageAspect = JSQPhotoMediaImageAspectDefault;
    }
    return self;
}

- (void)clearCachedMediaViews
{
    [super clearCachedMediaViews];
    _cachedImageView = nil;
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    _image = [image copy];
    _cachedImageView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedImageView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (CGSize)mediaViewDisplaySize {
    CGSize thumbnailSize = [super mediaViewDisplaySize];
    if (self.imageAspect == JSQPhotoMediaImageAspectDefault) {
        return thumbnailSize;
    }
    
    CGFloat longestSide = fmax(thumbnailSize.width, thumbnailSize.height);
    CGFloat smallestSide = fmin(thumbnailSize.width, thumbnailSize.height);
    
    if (self.imageAspect == JSQPhotoMediaImageAspectSmallSquare) {
        thumbnailSize = CGSizeMake(smallestSide, smallestSide);
    } else if (self.imageAspect == JSQPhotoMediaImageAspectLargeSquare) {
        thumbnailSize = CGSizeMake(longestSide, longestSide);
    } else if (self.imageAspect == JSQPhotoMediaImageAspectPortrait) {
        thumbnailSize = CGSizeMake(smallestSide, longestSide);
    } else if (self.imageAspect == JSQPhotoMediaImageAspectLandscape) {
        thumbnailSize = CGSizeMake(longestSide, smallestSide);
    } else if (self.imageAspect == JSQPhotoMediaImageAspectAutomatic) {
        if (self.image.size.height > 0 && self.image.size.width > 0) {
            CGFloat aspect = self.image.size.width / self.image.size.height;
            if (self.image.size.width > self.image.size.height) {
                thumbnailSize = CGSizeMake(thumbnailSize.width, thumbnailSize.width / aspect);
            } else {
                thumbnailSize = CGSizeMake(thumbnailSize.height * aspect, thumbnailSize.height);
            }
        }
    }
    
    return thumbnailSize;
}

- (UIView *)mediaView
{
    if (self.image == nil) {
        return nil;
    }
    
    if (self.cachedImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:imageView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedImageView = imageView;
    }
    
    return self.cachedImageView;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    return super.hash ^ self.image.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: image=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.image, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQPhotoMediaItem *copy = [[JSQPhotoMediaItem allocWithZone:zone] initWithImage:self.image];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
