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

@implementation JSQPhotoMediaItem

@synthesize cachedMediaView = _cachedMediaView;
#pragma mark - Initialization

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = [image copy];
    }
    return self;
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    _image = [image copy];
    _cachedMediaView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (CGSize)mediaViewDisplaySizeWithMessageData:(id<JSQMessageData>)messageData layout:(JSQMessagesCollectionViewFlowLayout *)layout{
    CGSize proposedSize = [super mediaViewDisplaySizeWithMessageData:messageData layout:layout];
    
    if (self.image) {
        if (self.image.size.width < proposedSize.width) {
            return self.image.size;
        } else {
            CGFloat ratio = proposedSize.width/self.image.size.width;
            return CGSizeMake(proposedSize.width, self.image.size.height*ratio);
        }
    } else {
        return proposedSize;
    }
}

- (UIView *)mediaViewWithMessageData:(id<JSQMessageData>)messageData layout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    if (self.image == nil) {
        return nil;
    }
    
    if (self.cachedMediaView == nil) {
        CGSize size = [self mediaViewDisplaySizeWithMessageData:messageData layout:layout];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:imageView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedMediaView = imageView;
    }
    
    return self.cachedMediaView;
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
