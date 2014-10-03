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
 *  The `JSQTextMessage` class is a concrete class for text message model objects that inherits from `JSQMessage`.
 *  An instance of `JSQTextMessage` is an immutable model object that represents a single user text message.
 *  It implements the `JSQMessageData` protocol and contains the message text.
 */
@interface JSQTextMessage : JSQMessage <JSQMessageData, NSCoding, NSCopying>

/**
 *  Returns the body text of the message.
 */
@property (copy, nonatomic, readonly) NSString *text;

/**
 *  Initializes and returns a text message object having the given senderId, displayName, text,
 *  and current system date.
 *
 *  @param senderId    The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param displayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param text        The body text of the message. This value must not be `nil`.
 *
 *  @return An initialized `JSQTextMessage` object if successful, `nil` otherwise.
 */
+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                               text:(NSString *)text;

/**
 *  Initializes and returns a text message object having the given senderId, senderDisplayName, date, and text.
 *
 *  @param senderId          The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param senderDisplayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param date              The date that the message was sent. This value must not be `nil`.
 *  @param text              The body text of the message. This value must not be `nil`.
 *
 *  @return An initialized `JSQTextMessage` object if successful, `nil` otherwise.
 */
- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text;

@end
