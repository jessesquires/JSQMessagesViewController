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
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>

/**
 *  The `JSQMessageData` protocol defines the common interface through 
 *  which `JSQMessagesViewController` and `JSQMessagesCollectionView` interacts with message model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances of that class 
 *  can be displayed properly with a `JSQMessagesCollectionViewCell`.
 */
@protocol JSQMessageData <NSObject>

@required

/**
 *  @return The body text of the message. 
 *  @warning This value must not be `nil`.
 */
- (NSString *)text;

/**
 *  @return The name of the user who sent the message.
 *  @warning This value must not be `nil`.
 */
- (NSString *)sender;

/**
 *  @return The date that the message was sent.
 *  @warning This value must not be `nil`.
 */
- (NSDate *)date;

@end
