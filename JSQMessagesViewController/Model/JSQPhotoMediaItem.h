//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

#import <Foundation/Foundation.h>
#import "JSQMessageMediaData.h"

/**
 *  The `JSQPhotoMediaItem` class is a concrete class that implements the `JSQMessageMediaData` protocol
 *  and represents a photo media message. An initialized `JSQPhotoMediaItem` object can be passed 
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 */
@interface JSQPhotoMediaItem : NSObject <JSQMessageMediaData, NSCoding, NSCopying>

/**
 *  The image for the photo media item.
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  Initializes and returns a photo media item object having the given image.
 *
 *  @param image The image for the photo media item.
 *
 *  @return An initialized `JSQPhotoMediaItem` if successful, `nil` otherwise.
 */
- (instancetype)initWithImage:(UIImage *)image;

@end
