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

#import "JSQMessageData.h"

/**
 *  A `JSQMessage` model object represents a single user message. An instance of `JSQMessage` is immutable.
 *  This is a concrete class that implements the `JSQMessageData` protocol.
 *  It contains the message text, senderId, senderDisplayName, and the date that the message was sent.
 */
@interface JSQMessage : NSObject <JSQMessageData, NSCoding, NSCopying>

/**
 *  Returns the body text of the message.
 */
@property (copy, nonatomic, readonly) NSString *text;

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

#pragma mark - Initialization

/**
 *  Initializes and returns a message object having the given text, senderId, senderDisplayName, 
 *  and current system date.
 *
 *  @param text              The body text of the message. This value must not be `nil`.
 *  @param senderId          The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param senderDisplayName The display name for the user who sent the message. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithText:(NSString *)text
                       senderId:(NSString *)senderId
              senderDisplayName:(NSString *)senderDisplayName;

/**
 *  Initializes and returns a message object having the given text, senderId, senderDisplayName, and date.
 *
 *  @param text              The body text of the message. This value must not be `nil`.
 *  @param senderId          The unique identifier for the user who sent the message. This value must not be `nil`.
 *  @param senderDisplayName The display name for the user who sent the message. This value must not be `nil`.
 *  @param date              The date that the message was sent. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithText:(NSString *)text
                    senderId:(NSString *)senderId
           senderDisplayName:(NSString *)senderDisplayName
                        date:(NSDate *)date;

@end
