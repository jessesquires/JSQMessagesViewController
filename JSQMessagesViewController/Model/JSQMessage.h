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
 *  The media data of the message. Default is `nil`.
 */
@property (strong, nonatomic) NSData *data;

/**
 *  The url for the media data of the message. Default is `nil`.
 */
@property (strong, nonatomic) NSURL *url;

/**
 *  The thumbnail for the video or photo. Default is `nil`.
 */
@property (strong, nonatomic) UIImage *thumbnail;

/**
 *  The placeholder image of the video thumbnail, only valid when `type` is `JSQMessageRemoteVideo`.
 *
 *  @discussion Normally, you can directly use the `thumbnail`.
 *  But when you know the url of a video, but not yet downloaded it, you may not have thumbnail,
 *  In this case, this comes in handy.
 */
@property (strong, nonatomic) UIImage *videoThumbnailPlaceholder;

/**
 *  The body text of the message. Default is empty.
 */
@property (copy, nonatomic) NSString *text;

/**
 *  The name of user who sent the message. This value must not be `nil`.
 */
@property (copy, nonatomic) NSString *sender;

/**
 *  The date that the message was sent. This value must not be `nil`. Default is current system date.
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
 *    Initializes and returns a message object having the given image, sender, and current system date.
 *
 *    @param image  The image of the message.
 *    @param sender The name of the user who sent the message.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithImage:(UIImage *)image sender:(NSString *)sender;

/**
 *    Initializes and returns a message object having the given image url, placeholder, sender, and current system date.
 *
 *    @param url         The url for the image. Can be remote or local URL, the type of this message will automatically set.
 *                       If it is a local URL, the `placeholder` will be ignored.
 *    @param placeholder The image to be set initially, until the image request finishes.
 *    @param sender      The name of the user who sent the message.
 *
 *    @discussion If you use this method to initialize the message, you need to implement
 *    `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithImageURL:(NSURL *)url placeholderImage:(UIImage *)placeholder sender:(NSString *)sender;

/**
 *    Initializes and returns a message object having the given video thumbnail, video url, sender, and current system date.
 *
 *    @param thumbnail The thumbnail for the video.
 *    @param url       The url for the video of the message. Can be remote or local URL, the type of this message will automatically set.
 *    @param sender    The name of the user who sent the message.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithVideoThumbnail:(UIImage *)thumbnail videoURL:(NSURL *)url sender:(NSString *)sender;

/**
 *    Initializes and returns a message object having the given placeholder image, video url, sender, and current system date.
 *
 *    @param placeholder The video thumbnail placeholder to be set initially, until the actual thumbnail request finishes.
 *    @param remoteURL   The url for the video of the message. Can *NOT* be a local URL, the type of this message will automatically set.
 *    @param sender      The name of the user who sent the message.
 *
 *    @discussion This method can be used in when you know the url of the video, but not yet downloaded it, 
 *    so you may not have thumbnail. If you use this method to initialize the message, you need to implement
 *    `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithVideoPlaceholderImage:(UIImage *)placeholder videoURL:(NSURL *)remoteURL sender:(NSString *)sender;

/**
 *    Initializes and returns a message object having the given audio data, sender, and current system date.
 *
 *    @param audio  The audio data of the message.
 *    @param sender The name of the user who sent the message.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithAudio:(NSData *)audio sender:(NSString *)sender;

/**
 *    Initializes and returns a message object having the given audio url, sender, and current system date.
 *
 *    @param url    The url for the audio. Can be remote or local URL, the type of this message will automatically set.
 *    @param sender The name of the user who sent the message.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
+ (instancetype)messageWithAudioURL:(NSURL *)url sender:(NSString *)sender;


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
 *  @param image  The image of the message.
 *  @param sender The name of the user who sent the message.
 *  @param date   The date that the message was sent.
 *
 *  @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithImage:(UIImage *)image
                       sender:(NSString *)sender
                         date:(NSDate *)date;

/**
 *    Initializes and returns a message object having the given image url, placeholder, sender, and date.
 *
 *    @param url         The url for the image. Can be remote or local URL, the type of this message will automatically set.
 *                       If it is a local URL, the `placeholder` will be ignored.
 *    @param placeholder The image to be set initially, until the image request finishes.
 *    @param sender      The name of the user who sent the message.
 *    @param date        The date that the message was sent.
 *
 *    @discussion If you use this method to initialize the message, you need to implement
 *    `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *    @return @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithImageURL:(NSURL *)url
                placeholderImage:(UIImage *)placeholder
                          sender:(NSString *)sender
                            date:(NSDate *)date;

/**
 *    Initializes and returns a message object having the given video thumbnail, video url, sender, and date.
 *
 *    @param thumbnail The thumbnail for the video.
 *    @param url       The url for the video. Can be remote or local URL, the type of this message will automatically set.
 *    @param sender    The name of the user who sent the message.
 *    @param date      The date that the message was sent.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithVideoThumbnail:(UIImage *)thumbnail
                              videoURL:(NSURL *)url
                                sender:(NSString *)sender
                                  date:(NSDate *)date;

/**
 *    Initializes and returns a message object having the given placeholder image, video url, sender, and current system date.
 *
 *    @param placeholder The video thumbnail placeholder to be set initially, until the actual thumbnail request finishes.
 *    @param url         The url for the video. Can *NOT* be a local URL, the type of this message will automatically set.
 *    @param sender      The name of the user who sent the message.
 *    @param date        The date that the message was sent.
 *
 *    @discussion This method can be used in when you know the url of the video, but not yet downloaded it,
 *    so you may not have thumbnail. If you use this method to initialize the message, you need to implement
 *    `collectionView:wantsThumbnailForURL:mediaImageViewForItemAtIndexPath:completionBlock:` data source method.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithVideoPlaceholderImage:(UIImage *)placeholder
                                     videoURL:(NSURL *)url
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
 *    Initializes and returns a message object having the given audio url, sender, and date.
 *
 *    @param url    Thr url for the audio. Can be remote or local URL, the type of this message will automatically set.
 *    @param sender The name of the user who sent the message.
 *    @param date   The date that the message was sent.
 *
 *    @return An initialized `JSQMessage` object or `nil` if the object could not be successfully initialized.
 */
- (instancetype)initWithAudioURL:(NSURL *)url
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
