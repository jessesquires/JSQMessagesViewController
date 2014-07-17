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
    JSQMessageAudio,
    JSQMessageRemotePhoto,
    JSQMessageRemoteVideo,
    JSQMessageRemoteAudio
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
 *  @return The body text of the message. Only valid when `type` is `JSQMessageText`.
 */
- (NSString *)text;


/**
 *  @return The audio data of the message. Only valid when `type` is `JSQMessageAudio`.
 */
- (NSData *)audio;


/**
 *  @return The full-size image of the message. Only valid when `type` is `JSQMessagePhoto`.
 */
- (UIImage *)sourceImage;

/**
 *  @return The thumbnail of the `sourceImage` of the message. Only valid when `type` is `JSQMessagePhoto` or `JSQMessageRemotePhoto`.
 */
- (UIImage *)thumbnailImage;


/**
 *  @return The thumbnail of the video of the message. Only valid when `type` is `JSQMessageVideo` or `JSQMessageRemoteVideo`.
 */
- (UIImage *)videoThumbnail;

/**
 *  @discussion Normally, you can directly use the `thumbnail`. 
 *  But when you know the url of a video, but not yet downloaded it, you may not have thumbnail,
 *  In this case, this comes in handy.
 *
 *  @return The placeholder image of the video thumbnail, only valid when `type` is `JSQMessageRemoteVideo`.
 */
- (UIImage *)videoThumbnailPlaceholder;


/**
 *  @return The url for the data of the message.
 */
- (NSURL *)sourceURL;

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
