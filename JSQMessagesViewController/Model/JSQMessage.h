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
 *  A `JSQMessage` model object represents a single user message. 
 *  This is a concrete class that implements the `JSQMessageData` protocol. 
 *  It contains the message text, its sender, and the date that the message was sent.
 */
@interface JSQMessage : NSObject <JSQMessageData, NSCoding, NSCopying>

/**
 *  Message kind
 */
@property (nonatomic) JSQMessageKind kind;

/**
 *  The body text of the message.
 */
@property (copy, nonatomic) NSString *text;

/**
 *  The image of the message.
 */
@property (copy, nonatomic) UIImage *image;

/**
 *  The URL of the remote message.
 */
@property (copy, nonatomic) NSURL *url;

/**
 *  The name of user who sent the message. This value must not be `nil`.
 */
@property (copy, nonatomic) NSString *sender;

/**
 *  The date that the message was sent. This value must not be `nil`.
 */
@property (copy, nonatomic) NSDate *date;

#pragma mark - Initialization

/**
 *  Initializes and returns a message object having the given text, sender, and current system date.
 *
 *  @param text   The body text of the message.
 *  @param sender The name of the user who sent the message.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithText:(NSString *)text sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given text, sender, and date.
 *
 *  @param text   The body text of the message.
 *  @param sender The name of the user who sent the message.
 *  @param date   The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        date:(NSDate *)date;

/**
 *  Initializes and returns a message object having the given image, sender, and current system date.
 *
 *  @param image  The image of the message
 *  @param sender The name of the user who sent the message
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized
 */
+ (instancetype)messageWithImage:(UIImage *)image sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given image, sender, and date.
 *
 *  @param image   The image of the message.
 *  @param sender The name of the user who sent the message.
 *  @param date   The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithImage:(UIImage *)image
                       sender:(NSString *)sender
                         date:(NSDate *)date;

/**
 *  Initializes and returns a message object having the given URL, sender, and current system date.
 *
 *  @param url  The URL for the remote image of the message
 *  @param sender The name of the user who sent the message
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized
 */
+ (instancetype)messageWithURL:(NSURL *)url sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given image, sender, and date.
 *
 *  @param url   The URL for the remote image of the message.
 *  @param sender The name of the user who sent the message.
 *  @param date   The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithURL:(NSURL *)url
                     sender:(NSString *)sender
                       date:(NSDate *)date;

/**
 *  Returns a boolean value that indicates whether a given message is equal to the receiver.
 *
 *  @param aMessage The message with which to compare the receiver.
 *
 *  @return `YES` if aMessage is equivalent to the receiver, otherwise `NO`.
 */
- (BOOL)isEqualToMessage:(JSQMessage *)aMessage;

@end
