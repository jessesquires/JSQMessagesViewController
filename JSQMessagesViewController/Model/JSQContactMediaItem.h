//
//  Created by Bary Levy (2016).
//  barylevy@gmail.com
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
//  Copyright (c) 2016 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMediaItem.h"
#import <Contacts/Contacts.h>
/**
 *  The `JSQContacMediatItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` protocol
 *  and represents a contact media message. An initialized `JSQContactMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQContactMediaItem` to provide additional functionality or behavior.
 */
@interface JSQContactMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying>

/**
 *  The contact to be displayed. The default value is `nil`.
 */

@property (copy, nonatomic) CNContact *contact;

/**
 *  Initializes and returns a photo media item object having the given image.
 *
 *  @param image The image for the photo media item. This value may be `nil`.
 *
 *  @return An initialized `JSQContacMediatItem` if successful, `nil` otherwise.
 *
 *  @discussion If the image must be dowloaded from the network, 
 *  you may initialize a `JSQContacMediatItem` object with a `nil` image.
 *  Once the image has been retrieved, you can then set the image property.
 */
- (instancetype)initWithContact:(CNContact *)contact;

@end

