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

/**
 *  The `JSMessageData` protocol defines the common interface through which `JSMessagesViewController` interacts with message model objects. 
 *  It declares the methods that a class must implement so that instances of that class can be displayed properly by a `JSMessagesViewController`.
 */
@protocol JSMessageData <NSObject>

@required

/**
 *  @return The body text of the message. 
 *  @warning This value must not be `nil`.
 */
- (NSString *)text;

@optional

/**
 *  @return The name of the user who sent the message.
 */
- (NSString *)sender;

/**
 *  @return The date that the message was sent.
 */
- (NSDate *)date;

@end
