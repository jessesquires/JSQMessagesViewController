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

#import "JSQMediaItem.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `JSQVideoMediaItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` protocol
 *  and represents a video media message. An initialized `JSQVideoMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQVideoMediaItem` to provide additional functionality or behavior.
 */
@interface JSQVideoMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying>

/**
 *  The URL that identifies a video resource.
 */
@property (nonatomic, strong, nullable) NSURL *fileURL;

/**
 *  The thumbnail image to display for the video.
 */
@property (nonatomic, strong, nullable) UIImage *thumbnailImage;

/**
 *  A boolean value that specifies whether or not the video is ready to be played.
 *
 *  @discussion When set to `YES`, the video is ready. When set to `NO` it is not ready.
 */
@property (nonatomic, assign) BOOL isReadyToPlay;

/**
 *  Initializes and returns a video media item having the given fileURL.
 *
 *  @param fileURL       The URL that identifies the video resource.
 *  @param isReadyToPlay A boolean value that specifies if the video is ready to play.
 *
 *  @return An initialized `JSQVideoMediaItem`.
 *
 *  @discussion If the video must be downloaded from the network,
 *  you may initialize a `JSQVideoMediaItem` with a `nil` fileURL or specify `NO` for
 *  isReadyToPlay. Once the video has been saved to disk, or is ready to stream, you can
 *  set the fileURL property or isReadyToPlay property, respectively.
 */
- (instancetype)initWithFileURL:(nullable NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay;

/**
 *  Initializes and returns a video media item having the given fileURL.
 *
 *  @param fileURL          The URL that identifies the video resource.
 *  @param isReadyToPlay    A boolean value that specifies if the video is ready to play.
 *  @param thumbnailImage   The background thumbnail image for the video.
 *
 *  @return An initialized `JSQVideoMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the video must be downloaded from the network,
 *  you may initialize a `JSQVideoMediaItem` with a `nil` fileURL or specify `NO` for
 *  isReadyToPlay. Once the video has been saved to disk, or is ready to stream, you can
 *  set the fileURL property or isReadyToPlay property, respectively. The background thumbnail
 *  is optional.
 */
- (instancetype)initWithFileURL:(NSURL *)fileURL
                  isReadyToPlay:(BOOL)isReadyToPlay
                 thumbnailImage:(nullable UIImage *)thumbnailImage;

@end

NS_ASSUME_NONNULL_END
