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


@implementation JSQPhotoMediaItem

#pragma mark - Initialization

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)dealloc
{
    _image = nil;
}

#pragma mark - JSQMessageMediaData protcol

- (UIView *)mediaView
{
    if (self.image == nil) {
        return nil;
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:self.image];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.layer.cornerRadius = 20.0f;
    return imgView;
}

- (CGSize)mediaViewDisplaySize
{
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
    
    JSQPhotoMediaItem *photoItem = (JSQPhotoMediaItem *)object;
    
    return [self.image isEqual:photoItem.image];
}

- (NSUInteger)hash
{
    return self.image.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: image=%@>", [self class], self.image];
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
        _image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithImage:self.image];
}

@end
