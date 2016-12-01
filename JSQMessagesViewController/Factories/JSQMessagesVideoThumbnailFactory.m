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

#import "JSQMessagesVideoThumbnailFactory.h"
#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"

@implementation JSQMessagesVideoThumbnailFactory

- (void)thumbnailWithVideoMediaAsset:(AVURLAsset *)asset
                          completion:(JSQMessagesVideoThumbnailCompletionBlock)completion
{
    NSParameterAssert(asset != nil);
    NSParameterAssert(completion != nil);
    [self thumbnailWithVideoMediaAsset:asset
                                  time:CMTimeMakeWithSeconds(1, 2)
                            completion:completion];
}

- (void)thumbnailWithVideoMediaAsset:(AVURLAsset *)asset
                                time:(CMTime)time
                          completion:(JSQMessagesVideoThumbnailCompletionBlock)completion
{
    NSParameterAssert(asset != nil);
    NSParameterAssert(completion != nil);

    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform = YES;

    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        generate.maximumSize = CGSizeMake(315.0f, 225.0f);
    }
    else {
        generate.maximumSize = CGSizeMake(210.0f, 150.0f);
    }

    NSArray *times = [NSArray arrayWithObject:[NSValue valueWithCMTime:time]];
    [generate generateCGImagesAsynchronouslyForTimes:times
                                   completionHandler:^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {

                                       UIImage *image = (result == AVAssetImageGeneratorSucceeded) ? [UIImage imageWithCGImage:im] : nil;
                                       if (completion) {
                                           completion(image, error);
                                       }
                                   }];
}

@end
