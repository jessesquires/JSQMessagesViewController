//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import "JSMessageData.h"

/**
 *  A `JSMessage` object represents a single user message. This is a concrete class that implements the `JSMessageData` protocol. It contains the message text, its sender, and the date that the message was sent.
 */
@interface JSMessage : NSObject <JSMessageData, NSCoding, NSCopying>

/**
 *  The body text of the message. The default value is the empty string `@" "`. This value must not be `nil`.
 */
@property (copy, nonatomic) NSString *text;

/**
 *  The name of user who sent the message. The default value is `nil`.
 */
@property (copy, nonatomic) NSString *sender;

/**
 *  The date that the message was sent. The default value is `nil`.
 */
@property (strong, nonatomic) NSDate *date;

#pragma mark - Initialization

/**
 *  Initializes and returns a message object having the given text, sender, and date.
 *
 *  @param text   The body text of the message.
 *  @param sender The name of the user who sent the message.
 *  @param date   The date that the message was sent.
 *
 *  @return An initialized `JSMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        date:(NSDate *)date;

@end
