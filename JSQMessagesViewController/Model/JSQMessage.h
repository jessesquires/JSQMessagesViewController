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

#import <Foundation/Foundation.h>

#import "JSQMessageData.h"

/**
 *  The `JSQMessage` class is an abstract base class for message model objects that represents a single user message.
 *  It contains the senderId, senderDisplayName, and the date that the message was sent. 
 *
 *  @warning This class is intended to be subclassed. You should not use it directly.
 *  
 *  @see JSQTextMessage.
 *  @see JSQMediaMessage.
 */
@interface JSQMessage : NSObject <JSQMessageData, NSCoding, NSCopying>

/**
 *  Returns the string identifier that uniquely identifies the user who sent the message. 
 */
@property (copy, nonatomic, readonly) NSString *senderId;

/**
 *  Returns the display name for the user who sent the message. This value does not have to be unique.
 */
@property (copy, nonatomic, readonly) NSString *senderDisplayName;

/**
 *  Returns the date that the message was sent.
 */
@property (copy, nonatomic, readonly) NSDate *date;

/**
 *  Returns a boolean value specifying whether or not the message contains media.
 *  The default value is `NO`, meaning that is message contains text, not media.
 */
@property (assign, nonatomic, readonly) BOOL isMediaMessage;

#pragma mark - Initialization

/**
 *  Initializes and returns a message object having the given senderId, senderDisplayName, and date.
 *
 *  @param senderId          The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param senderDisplayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param date              The date that the message was sent. This value must not be `nil`.
 *  @param isMedia           A boolean value specifying whether or not the message contains media.
 *
 *  @return An initialized `JSQMessage` object if successful, `nil` otherwise.
 */
- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                         isMedia:(BOOL)isMedia;

@end
