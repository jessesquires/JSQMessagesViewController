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

/**
 *  The `JSQPhotoMediaItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` protocol
 *  and represents a photo media message. An initialized `JSQPhotoMediaItem` object can be passed 
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQPhotoMediaItem` to provide additional functionality or behavior.
 */
@interface JSQPhotoMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying>

/**
 *  The image for the photo media item. The default value is `nil`.
 */
@property (copy, nonatomic) UIImage *image;

/**
 *  Initializes and returns a photo media item object having the given image.
 *
 *  @param image The image for the photo media item. This value may be `nil`.
 *
 *  @return An initialized `JSQPhotoMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the image must be dowloaded from the network, 
 *  you may initialize a `JSQPhotoMediaItem` object with a `nil` image. 
 *  Once the image has been retrieved, you can then set the image property.
 */
- (instancetype)initWithImage:(UIImage *)image;

@end
