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

#import "JSQMediaItem.h"
#import "JSQAudioMediaViewAttributes.h"

#import <AVFoundation/AVFoundation.h>

@class JSQAudioMediaItem;

@protocol JSQAudioMediaItemDelegate <NSObject>

/**
 * didChangeAudioCategory is called if JSQAudioMediaItem changes the sound category or categoryOptions, or if an error occurs
 */
- (void)audioMediaItem:(nonnull JSQAudioMediaItem*)audioMediaItem didChangeAudioCategory:(nonnull NSString *)category options:(AVAudioSessionCategoryOptions)options error:(nullable NSError*)error;

@end

/**
 *  The `JSQAudioMediaItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` protocol
 *  and represents a video media message. An initialized `JSQAudioMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQAudioMediaItem` to provide additional functionality or behavior.
 */
@interface JSQAudioMediaItem : JSQMediaItem <JSQMessageMediaData, AVAudioPlayerDelegate, NSCoding, NSCopying>

/**
 *  The delegate object for audio event notifications
 */
@property (nonatomic, weak, nullable) id<JSQAudioMediaItemDelegate> delegate;

/**
 * View attributes controlling the appearance of the audio media view
 *
 * @discussion Default values are used if this is `nil`.
 */
@property (nonatomic, strong, nonnull) JSQAudioMediaViewAttributes *audioViewAttributes;

/**
 *  An NSData object that contains an audio resource.
 */
@property (nonatomic, strong, nullable) NSData *audioData;

/**
 *  Initializes and returns a default audio media
 *
 *  @return An initialized `JSQAudioMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion You must set `audioData` to enable the play button.
 */
- (nullable instancetype)init;

/**
 *  Initializes and returns a default audio media using the supplied view configuration
 *
 *  @return An initialized `JSQAudioMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion You must set `audioData` to enable the play button.
 */
- (nullable instancetype)initWithAudioViewAttributes:(nonnull JSQAudioMediaViewAttributes*)attributes;

/**
 *  Initializes and returns an audio media item having the given audioData.
 *
 *  @param audioData       The data object that contains the audio resource.
 *
 *  @return An initialized `JSQAudioMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `JSQAudioMediaItem` with a `nil` audioData.
 *  Once the audio is available you can set the `audioData` property.
 */
- (nullable instancetype)initWithData:(nullable NSData *)audioData;

/**
 *  Initializes and returns a audio media item having the given audioData.
 *
 *  @param audioData       The data object that contains the audio resource.
 *  @param audioViewConfiguration       The config object that contains view properties
 *
 *  @return An initialized `JSQAudioMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `JSQVideoMediaItem` with a `nil` audioData.
 *  Once the audio is available you can set the `audioData` property.
 */
- (nullable instancetype)initWithData:(nullable NSData *)audioData audioViewAttributes:(nonnull JSQAudioMediaViewAttributes*)attributes NS_DESIGNATED_INITIALIZER;

/**
 *  Set or update the data object in an audio media item
 *
 *  @param audioURL       A File URL containing the location of the audio data.
 */
- (void)setAudioDataWithUrl:(nonnull NSURL *)audioURL;

@end
