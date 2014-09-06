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

#import "JSQMessagesAvatarImage.h"

@implementation JSQMessagesAvatarImage 

#pragma mark - Initialization

- (instancetype)initWithPlaceholderImage:(UIImage *)image size:(CGSize)size
{
    return [self initWithAvatarImage:nil
                    highlightedImage:nil
                    placeholderImage:image
                                size:size];
}

- (instancetype)initWithAvatarImage:(UIImage *)avatarImage
                   highlightedImage:(UIImage *)highlightedImage
                   placeholderImage:(UIImage *)placeholderImage
                               size:(CGSize)size
{
    NSParameterAssert(placeholderImage != nil);
    NSParameterAssert(!CGSizeEqualToSize(size, CGSizeZero));
    
    self = [super init];
    if (self) {
        _avatarImage = avatarImage;
        _avatarHighlightedImage = highlightedImage;
        _avatarPlaceholderImage = placeholderImage;
        _avatarImageSize = size;
    }
    return self;
}

- (id)init
{
    NSAssert(NO, @"%s is not a valid initializer for %@. Use %@ instead.",
             __PRETTY_FUNCTION__, [self class], NSStringFromSelector(@selector(initWithAvatarImage:highlightedImage:placeholderImage:size:)));
    return nil;
}

#pragma mark - Avatar image

- (UIImage *)currentDisplayImage
{
    return (self.avatarImage == nil) ? self.avatarPlaceholderImage : self.avatarImage;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: avatarImage=%@, avatarImageSize=%@, avatarHighlightedImage=%@, avatarPlaceholderImage=%@>",
            [self class], self.avatarImage, NSStringFromCGSize(self.avatarImageSize), self.avatarHighlightedImage, self.avatarPlaceholderImage];
}

- (id)debugQuickLookObject
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.avatarImageSize.width, self.avatarImageSize.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [self currentDisplayImage];
    return imageView;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithAvatarImage:[UIImage imageWithCGImage:self.avatarImage.CGImage]
                                                 highlightedImage:[UIImage imageWithCGImage:self.avatarHighlightedImage.CGImage]
                                                 placeholderImage:[UIImage imageWithCGImage:self.avatarPlaceholderImage.CGImage]
                                                             size:self.avatarImageSize];
}

@end
