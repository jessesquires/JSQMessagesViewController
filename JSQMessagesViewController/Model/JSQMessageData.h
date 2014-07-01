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

typedef NS_ENUM(NSUInteger, JSQMessageType) {
    JSQMessageText,
    JSQMessagePhoto,
    JSQMessageVideo,
    JSQMessageAudio
};

/**
 *  The `JSQMessageData` protocol defines the common interface through 
 *  which `JSQMessagesViewController` and `JSQMessagesCollectionView` interacts with message model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances of that class 
 *  can be displayed properly with a `JSQMessagesCollectionViewCell`.
 */
@protocol JSQMessageData <NSObject>

@optional

/**
 *  @return The body text of the message.
 */
- (NSString *)text;

/**
 *  @return The media data of the message. This can be photo, video or audio, depends on message type.
 */
- (NSData *)data;

@required

/**
 *  @return The type of the message.
 *  @warning You must not return `nil` from this method.
 */
- (JSQMessageType)type;

/**
 *  @return The name of the user who sent the message.
 *  @warning You must not return `nil` from this method.
 */
- (NSString *)sender;

/**
 *  @return The date that the message was sent.
 *  @warning You must not return `nil` from this method.
 */
- (NSDate *)date;

@end
