//
//  JSQMessagesVideoThumbnailFactory.m
//  JSQMessages
//
//  Created by Xi Huang on 8/22/16.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "JSQVideoMediaItem.h"

#import "JSQMessagesVideoThumbnailFactory.h"
#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"

@implementation JSQMessagesVideoThumbnailFactory

+ (void)customThumbnailWithVideoMediaAsset:(AVURLAsset *)videoMediaAsset
                     withCompletionHandler:(JSQMessagesVideoThumbnailCompletionBlock)completion {
    
    [JSQMessagesVideoThumbnailFactory customThumbnailWithVideoMediaAsset:videoMediaAsset
                                                                    time:CMTimeMakeWithSeconds(1, 2)
                                                   withCompletionHandler:completion];
}

+ (void)customThumbnailWithVideoMediaAsset:(AVURLAsset *)videoMediaAsset
                                      time:(CMTime)time
                     withCompletionHandler:(JSQMessagesVideoThumbnailCompletionBlock)completion {
    
    NSParameterAssert(videoMediaAsset != nil);
    
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:videoMediaAsset];
    generate.appliesPreferredTrackTransform = YES;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        generate.maximumSize = CGSizeMake(315.0f, 225.0f);
    }
    else {
        generate.maximumSize = CGSizeMake(210.0f, 150.0f);
    }
    [generate generateCGImagesAsynchronouslyForTimes:[NSArray arrayWithObject:[NSValue valueWithCMTime:time]]
                                   completionHandler:^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
                                       
                                       if (completion) {
                                           if (result == AVAssetImageGeneratorSucceeded) {
                                               completion([UIImage imageWithCGImage:im], nil);
                                           }
                                           else {
                                               completion(nil, error);
                                           }
                                       }
                                   }];
}

@end
