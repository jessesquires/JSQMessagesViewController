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

@import AVFoundation;

@interface JSQVideoMediaItem ()

@property (strong, nonatomic) UIImageView *cachedVideoImageView;

@property (strong, nonatomic) UIImage *thumbnailImage;

@end


@implementation JSQVideoMediaItem

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
    _thumbnailImage = nil;
}

#pragma mark - Setters

- (void)setFileURL:(NSURL *)fileURL
{
    _fileURL = [fileURL copy];
    _cachedVideoImageView = nil;
    _thumbnailImage = nil;
}

- (void)setIsReadyToPlay:(BOOL)isReadyToPlay
{
    _isReadyToPlay = isReadyToPlay;
    _cachedVideoImageView = nil;
    _thumbnailImage = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedVideoImageView = nil;
    _thumbnailImage = nil;
}

- (UIImage *)thumbnailImage{
    if (_thumbnailImage) {
        return _thumbnailImage;
    }
    AVURLAsset *avAsset =  [AVURLAsset URLAssetWithURL:_fileURL options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:avAsset];
    generate.appliesPreferredTrackTransform = YES;
    CMTime thumbTime = CMTimeMakeWithSeconds(1,2);
    AVAssetImageGeneratorCompletionHandler handler = ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result == AVAssetImageGeneratorSucceeded) {
            _thumbnailImage = [UIImage imageWithCGImage:im];
            _cachedVideoImageView = nil;
        }
    };
    generate.maximumSize = [self mediaViewDisplaySize];
    [generate generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
    return nil;
}


#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.fileURL == nil || !self.isReadyToPlay) {
        return nil;
    }
    
    if (self.cachedVideoImageView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIImage *playIcon = [[UIImage jsq_defaultPlayImage] jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
        UIImageView *playIconView = [[UIImageView alloc] initWithImage:playIcon];
        playIconView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        UIImageView *thumbnailView = [[UIImageView alloc] initWithFrame:playIconView.frame];
        playIconView.contentMode = UIViewContentModeCenter;
        playIconView.clipsToBounds = YES;
        [thumbnailView addSubview:playIconView];
        if (self.thumbnailImage) {
            thumbnailView.image = _thumbnailImage;
            thumbnailView.contentMode = UIViewContentModeScaleAspectFill;
        }else{
            thumbnailView.backgroundColor = [UIColor blackColor];
        }
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:thumbnailView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedVideoImageView = thumbnailView;
    }
    
    return self.cachedVideoImageView;
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
    return self.fileURL.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: fileURL=%@, isReadyToPlay=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.fileURL, @(self.isReadyToPlay), @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _fileURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(fileURL))];
        _isReadyToPlay = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isReadyToPlay))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.fileURL forKey:NSStringFromSelector(@selector(fileURL))];
    [aCoder encodeBool:self.isReadyToPlay forKey:NSStringFromSelector(@selector(isReadyToPlay))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQVideoMediaItem *copy = [[[self class] allocWithZone:zone] initWithFileURL:self.fileURL
                                                                   isReadyToPlay:self.isReadyToPlay];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
