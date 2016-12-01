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

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  A completion block for a `JSQMessagesVideoThumbnailFactory`.
 *
 *  @see `thumbnailWithVideoMediaAsset: completion:`
 */
typedef void (^JSQMessagesVideoThumbnailCompletionBlock)(UIImage * _Nullable, NSError * _Nullable);

/**
 * `JSQMessagesVideoThumbnailFactory` is a factory that provides a means for generating
 * a thumbnail image with for a `JSQVideoMediaItem`.
 */
@interface JSQMessagesVideoThumbnailFactory : NSObject

/**
 *  Generates and returns a thumbnail image for the specified video media asset
 *  with the default time of `CMTimeMakeWithSeconds(1, 2)`.
 *
 *  The specified block is executed upon completion of generating the thumbnail image
 *  and is executed on the main thread.
 *
 *  @param asset        The `AVURLAsset` for the video media item.
 *  @param completion   The block to call after the thumbnail has been generated.
 */
- (void)thumbnailWithVideoMediaAsset:(AVURLAsset *)asset
                          completion:(JSQMessagesVideoThumbnailCompletionBlock)completion;

/**
 *  Generates and returns a thumbnail image for the specified video media asset with a given CMTime.
 *
 *  The specified block is executed upon completion of generating the thumbnail image and is executed on the app’s main thread.
 *
 *  @param videoMediaAsset The instance of AVURLAsset for the video media item.
 *  @param time            The CMTime struct for capturing the thumbnail image from the video media item.
 *  @param completion      The block to call after the thumbnail has been generated.
 */

/**
 *  Generates and returns a thumbnail image for the specified video media asset with the given `CMTime`.
 *
 *  The specified block is executed upon completion of generating the thumbnail image
 *  and is executed on the main thread.
 *
 *  @param asset        The `AVURLAsset` for the video media item.
 *  @param time         The CMTime for capturing the thumbnail image from the video asset.
 *  @param completion   The block to call after the thumbnail has been generated.
 */
- (void)thumbnailWithVideoMediaAsset:(AVURLAsset *)asset
                                time:(CMTime)time
                          completion:(JSQMessagesVideoThumbnailCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
