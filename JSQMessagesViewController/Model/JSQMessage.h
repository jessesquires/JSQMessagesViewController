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
 *  The type of the message. Default is `JSQMessageText`.
 */
@property (nonatomic) JSQMessageType type;

/**
 *  The name of user who sent the message. This value must not be `nil`.
 */
@property (copy, nonatomic) NSString *sender;

/**
 *  The date that the message was sent. This value must not be `nil`. Default is current system date.
 */
@property (copy, nonatomic) NSDate *date;

/**
 *  The body text of the message. Default is empty.
 */
@property (copy, nonatomic) NSString *text;

/**
 *  The audio data of the message. Only valid when `type` is `JSQMessageAudio`. Default is `nil`.
 */
@property (strong, nonatomic) NSData *audio;

/**
 *  The full-size image of the message. Only valid when `type` is `JSQMessagePhoto`. Default is `nil`.
 */
@property (strong, nonatomic) UIImage *sourceImage;

/**
 *  The thumbnail of the `sourceImage` of the message. 
 *  Only valid when `type` is `JSQMessagePhoto` or `JSQMessageRemotePhoto`. Default is `nil`.
 *
 *  @warning If the `type` is `JSQMessagePhoto` or `JSQMessageRemotePhoto`, this value must not be `nil`
 */
@property (strong, nonatomic) UIImage *thumbnailImage;

/**
 *  The thumbnail of the video of the message. Only valid when `type` is `JSQMessageVideo` or `JSQMessageRemoteVideo`. Default is `nil`.
 *
 *  @warning If the `type` is `JSQMessageVideo`, this value must not be `nil`.
 *  If the `type` is `JSQMessageRemoteVideo`, this value and `videoThumbnailPlaceholder` can *NOT* both be nil.
 */
@property (strong, nonatomic) UIImage *videoThumbnail;

/**
 *  The placeholder image of the video thumbnail, only valid when `type` is `JSQMessageRemoteVideo`.
 *
 *  @discussion Normally, you can directly use the `thumbnail`.
 *  But when you know the url of a video, but not yet downloaded it, you may not have thumbnail,
 *  In this case, this comes in handy.
 */
@property (strong, nonatomic) UIImage *videoThumbnailPlaceholder;

/**
 *  The url for the media data of the message. Default is `nil`.
 */
@property (strong, nonatomic) NSURL *sourceURL;

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
 *  Initializes and returns a message object having the given image, sender, and current system date.
 *
 *  @param sourceImage    The full-size image of the message.
 *  @param thumbnailImage The thumbnail of the `sourceImage` of the message.
 *  @param sender         The name of the user who sent the message.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithImage:(UIImage *)sourceImage thumbnailImage:(UIImage *)thumbnailImage sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given image url, placeholder, sender, and current system date.
 *
 *  @param sourceImageURL The url for the image. Can *NOT* be a local URL, the type of this message will automatically set.
 *  @param placeholder    The image to be set initially, until the image request finishes.
 *  @param sender         The name of the user who sent the message.
 *
 *  @discussion If you use this method to initialize the message, you need to implement
 *  `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithImageURL:(NSURL *)sourceImageURL placeholderImage:(UIImage *)placeholder sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given video thumbnail, video url, sender, and current system date.
 *
 *  @param sourceVideoURL The url for the video of the message. Can be remote or local URL, the type of this message will automatically set.
 *  @param thumbnail      The thumbnail for the video.
 *  @param sender         The name of the user who sent the message.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithVideoURL:(NSURL *)sourceVideoURL thumbnail:(UIImage *)thumbnail sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given placeholder image, video url, sender, and current system date.
 *
 *  @param remoteURL   The url for the video of the message. Can *NOT* be a local URL, the type of this message will automatically set.
 *  @param placeholder The video thumbnail placeholder to be set initially, until the actual thumbnail request finishes.
 *  @param sender      The name of the user who sent the message.
 *
 *  @discussion This method can be used in when you know the url of the video, but not yet downloaded it,
 *  so you may not have thumbnail. If you use this method to initialize the message, you need to implement
 *  `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithVideoURL:(NSURL *)remoteURL placeholderImage:(UIImage *)placeholder sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given audio data, sender, and current system date.
 *
 *  @param audio  The audio data of the message.
 *  @param sender The name of the user who sent the message.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithAudio:(NSData *)audio sender:(NSString *)sender;

/**
 *  Initializes and returns a message object having the given audio url, sender, and current system date.
 *
 *  @param sourceURL The url for the audio. Can be remote or local URL, the type of this message will automatically set.
 *  @param sender    The name of the user who sent the message.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithAudioURL:(NSURL *)sourceURL sender:(NSString *)sender;


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
 *  Initializes and returns a message object having the given image, sender, and date.
 *
 *  @param sourceImage    The full-size image of the message.
 *  @param thumbnailImage The thumbnail of the `sourceImage` of the message.
 *  @param sender         The name of the user who sent the message.
 *  @param date           The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithImage:(UIImage *)sourceImage
               thumbnailImage:(UIImage *)thumbnailImage
                       sender:(NSString *)sender
                         date:(NSDate *)date;

/**
 *  Initializes and returns a message object having the given image url, placeholder, sender, and date.
 *
 *  @param sourceImageURL The url for the image. Can *NOT* be a local URL, the type of this message will automatically set.
 *  @param placeholder    The image to be set initially, until the image request finishes.
 *  @param sender         The name of the user who sent the message.
 *  @param date           The date that the message was sent.
 *
 *  @discussion If you use this method to initialize the message, you need to implement
 *  `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *  @return @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithImageURL:(NSURL *)sourceImageURL
                placeholderImage:(UIImage *)placeholder
                          sender:(NSString *)sender
                            date:(NSDate *)date;

/**
 *  Initializes and returns a message object having the given video thumbnail, video url, sender, and date.
 *
 *  @param sourceVideoURL The url for the video. Can be remote or local URL, the type of this message will automatically set.
 *  @param thumbnail      The thumbnail for the video.
 *  @param sender         The name of the user who sent the message.
 *  @param date           The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithVideoURL:(NSURL *)sourceVideoURL
                       thumbnail:(UIImage *)thumbnail
                          sender:(NSString *)sender
                            date:(NSDate *)date;

/**
 *  Initializes and returns a message object having the given placeholder image, video url, sender, and current system date.
 *
 *  @param remoteURL   The url for the video. Can *NOT* be a local URL, the type of this message will automatically set.
 *  @param placeholder The video thumbnail placeholder to be set initially, until the actual thumbnail request finishes.
 *  @param sender      The name of the user who sent the message.
 *  @param date        The date that the message was sent.
 *
 *  @discussion This method can be used in when you know the url of the video, but not yet downloaded it,
 *  so you may not have thumbnail. If you use this method to initialize the message, you need to implement
 *  `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithVideoURL:(NSURL *)remoteURL
                placeholderImage:(UIImage *)placeholder
                          sender:(NSString *)sender
                            date:(NSDate *)date;

/**
 *  Initializes and returns a message object having the given audio data, sender, and date.
 *
 *  @param audio  The audio data of the message.
 *  @param sender The name of the user who sent the message.
 *  @param date   The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithAudio:(NSData *)audio
                       sender:(NSString *)sender
                         date:(NSDate *)date;

/**
 *  Initializes and returns a message object having the given audio url, sender, and date.
 *
 *  @param sourceURL Thr url for the audio. Can be remote or local URL, the type of this message will automatically set.
 *  @param sender    The name of the user who sent the message.
 *  @param date      The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithAudioURL:(NSURL *)sourceURL
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
