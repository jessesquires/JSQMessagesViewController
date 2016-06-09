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

#import "JSQMessageMediaData.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  The `JSQMessageData` protocol defines the common interface through which 
 *  a `JSQMessagesViewController` and `JSQMessagesCollectionView` interact with message model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances of that class 
 *  can be displayed properly within a `JSQMessagesCollectionViewCell`.
 *
 *  The class that conforms to this protocol is provided in the library. See `JSQMessage`.
 *
 *  @see JSQMessage.
 */
@protocol JSQMessageData <NSObject>

@required

/**
 *  @return A string identifier that uniquely identifies the user who sent the message.
 *
 *  @discussion If you need to generate a unique identifier, consider using 
 *  `[[NSProcessInfo processInfo] globallyUniqueString]`
 *
 *  @warning You must not return `nil` from this method. This value must be unique.
 */
- (NSString *)senderId;

/**
 *  @return The display name for the user who sent the message.
 *
 *  @warning You must not return `nil` from this method.
 */
- (NSString *)senderDisplayName;

/**
 *  @return The date that the message was sent.
 *
 *  @warning You must not return `nil` from this method.
 */
- (NSDate *)date;

/**
 *  This method is used to determine if the message data item contains text or media.
 *  If this method returns `YES`, an instance of `JSQMessagesViewController` will ignore 
 *  the `text` method of this protocol when dequeuing a `JSQMessagesCollectionViewCell`
 *  and only call the `media` method. 
 *
 *  Similarly, if this method returns `NO` then the `media` method will be ignored and
 *  and only the `text` method will be called.
 *
 *  @return A boolean value specifying whether or not this is a media message or a text message.
 *  Return `YES` if this item is a media message, and `NO` if it is a text message.
 */
- (BOOL)isMediaMessage;

/**
 *  @return An integer that can be used as a table address in a hash table structure.
 *
 *  @discussion This value must be unique for each message with distinct contents. 
 *  This value is used to cache layout information in the collection view.
 */
- (NSUInteger)messageHash;

@optional

/**
 *  @return The body text of the message.
 *
 *  @warning You must not return `nil` from this method.
 */
- (NSString *)text;

/**
 *  @return The media item of the message.
 *  
 *  @warning You must not return `nil` from this method.
 */
- (id<JSQMessageMediaData>)media;

@end

NS_ASSUME_NONNULL_END
