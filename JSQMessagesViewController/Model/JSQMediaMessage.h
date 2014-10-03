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

#import "JSQMessage.h"

/**
 *  The `JSQMediaMessage` class is a concrete class for media message model objects that inherits from `JSQMessage`.
 *  An instance of `JSQMediaMessage` is an immutable model object that represents a single user media message.
 *  It implements the `JSQMessageData` protocol and contains the message media.
 */
@interface JSQMediaMessage : JSQMessage <JSQMessageData, NSCoding, NSCopying>

/**
 *  Returns the media item associate with the message.
 */
@property (copy, nonatomic, readonly) id<JSQMessageMediaData> media;

/**
 *  Initializes and returns a media message object having the given senderId, displayName, media,
 *  and current system date.
 *
 *  @param senderId    The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param displayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param media       The media data for the message. This value must not be `nil`.
 *
 *  @return An initialized `JSQMediaMessage` object if successful, `nil` otherwise.
 */
+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                              media:(id<JSQMessageMediaData>)media;

/**
 *  Initializes and returns a media message object having the given senderId, displayName, date, and media.
 *
 *  @param senderId          The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param senderDisplayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param date              The date that the message was sent. This value must not be `nil`.
 *  @param media             The media data for the message. This value must not be `nil`.
 *
 *  @return An initialized `JSQMediaMessage` object if successful, `nil` otherwise.
 */
- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                           media:(id<JSQMessageMediaData>)media;

@end
