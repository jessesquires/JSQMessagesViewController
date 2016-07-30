//
//  JSQMessagesVideoThumbnailFactory.h
//  JSQMessages
//
//  Created by Xi Huang on 8/22/16.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  A completion handler block for a `JSQMessagesVideoThumbnailFactory`. See `customThumbnailWithVideoMediaAsset: withCompletionHandler:`.
 */
typedef void (^JSQMessagesVideoThumbnailCompletionBlock)(UIImage * _Nullable, NSError * _Nullable);

/**
 *  `JSQMessagesVideoThumbnailFactory` is a factory that provides a means for generating a thumbnail image with a given media item.
 */
@interface JSQMessagesVideoThumbnailFactory : NSObject

/**
 *  Generates and returns a thumbnail image for the specified video media asset with the default CMTimeMakeWithSeconds(1, 2).
 *
 *  The specified block is executed upon completion of generating the thumbnail image and is executed on the app’s main thread.
 *
 *  @param videoMediaAsset  The instance of AVURLAsset for the video media item.
 *  @param completion       The block to call after the thumbnail has been generated.
 */
+ (void)customThumbnailWithVideoMediaAsset:(AVURLAsset *)videoMediaAsset
                     withCompletionHandler:(JSQMessagesVideoThumbnailCompletionBlock)completion;

/**
 *  Generates and returns a thumbnail image for the specified video media asset with a given CMTime.
 *
 *  The specified block is executed upon completion of generating the thumbnail image and is executed on the app’s main thread.
 *
 *  @param videoMediaAsset The instance of AVURLAsset for the video media item.
 *  @param time            The CMTime struct for capturing the thumbnail image from the video media item.
 *  @param completion      The block to call after the thumbnail has been generated.
 */
+ (void)customThumbnailWithVideoMediaAsset:(AVURLAsset *)videoMediaAsset
                                      time:(CMTime)time
                     withCompletionHandler:(JSQMessagesVideoThumbnailCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
