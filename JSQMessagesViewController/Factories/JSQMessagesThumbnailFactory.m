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

+ (UIImage *)thumbnaiFromURL:(NSURL *)videoURL
{
    return [self thumbnaiFromURL:videoURL atTime:CMTimeMake(1, 1)];
}

+ (UIImage *)thumbnaiFromURL:(NSURL *)videoURL atTime:(CMTime)time
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:videoURL options:@{AVURLAssetPreferPreciseDurationAndTimingKey: @NO}];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
    UIImage *thumbnai = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return thumbnai;
}

@end
