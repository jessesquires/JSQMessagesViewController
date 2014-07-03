//
//  JSQMessagesThumbnailFactory.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-3.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreMedia/CMTime.h>

/**
 *  `JSQMessagesThumbnailFactory` is a factory that provides a means for creating the video thumbnail
 *  to be displayed in the `mediaImageView` of `JSQMessagesCollectionViewCellIncomingVideo` or `JSQMessagesCollectionViewCellOutgoingVideo`.
 */
@interface JSQMessagesThumbnailFactory : NSObject

/**
 *  Creates and returns a new thumbnail image is obtained from the specified video URL.
 *
 *  @param videoURL The URL of the video which you need to get the thumbnail. This value must *NOT* be `nil`.
 *
 *  @return A new thumbnail image for the specified video url, or `nil` if can not get the thumbnail from the specified video url.
 */
+ (UIImage *)thumbnailFromVideoURL:(NSURL *)videoURL;

/**
 *  Creates and returns a new thumbnail image is obtained from the specified video URL and time.
 *
 *  @param videoURL The URL of the video which you need to get the thumbnail. This value must *NOT* be `nil`.
 *  @param time The time at which the keyframe of the video is to be created.
 *  Treat this value to be careful , if too large may not get thumbnails This value must *NOT* be `nil`.
 *
 *  @return A new thumbnail image for the specified video url and time,
 *  or `nil` if can not get the thumbnail from the specified video url and time.
 */
+ (UIImage *)thumbnailFromVideoURL:(NSURL *)videoURL atTime:(CMTime)time;

@end