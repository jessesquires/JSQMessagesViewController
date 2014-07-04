//
//  JSQMessagesThumbnailFactory.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-3.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesThumbnailFactory.h"

#import <AVFoundation/AVFoundation.h>

@implementation JSQMessagesThumbnailFactory

+ (UIImage *)thumbnailFromVideoURL:(NSURL *)videoURL
{
    return [self thumbnailFromVideoURL:videoURL atSeconds:1];
}

+ (UIImage *)thumbnailFromVideoURL:(NSURL *)videoURL atSeconds:(NSUInteger)second
{
    NSParameterAssert(videoURL != nil);
    NSParameterAssert(second >= 0);
    
    /**
     *  Default set to 25 frames per second.
     */
    CMTime time = CMTimeMake(25, 25);
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:@{AVURLAssetPreferPreciseDurationAndTimingKey: @NO}];
    AVAssetTrack *assetTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] lastObject];
    
    if (assetTrack) {
        NSUInteger fps = ceilf(assetTrack.nominalFrameRate);
        time = CMTimeMake((int64_t)(second * fps), (int32_t)fps);
    }
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnai = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnai;
}

+ (UIImage *)thumbnailFromVideoURL:(NSURL *)videoURL atTime:(CMTime)time
{
    NSParameterAssert(videoURL != nil);
    NSParameterAssert(CMTIME_IS_VALID(time));
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:@{AVURLAssetPreferPreciseDurationAndTimingKey: @NO}];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnai = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnai;
}

@end
