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

NS_ASSUME_NONNULL_BEGIN

@protocol JSQAudioMediaItemDelegate <NSObject>

/**
 *  Tells the delegate if the specified `JSQAudioMediaItem` changes the sound category or categoryOptions, or if an error occurs.
 */
- (void)audioMediaItem:(JSQAudioMediaItem *)audioMediaItem
didChangeAudioCategory:(NSString *)category
               options:(AVAudioSessionCategoryOptions)options
                 error:(nullable NSError *)error;

@end


/**
 *  The `JSQAudioMediaItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` protocol
 *  and represents an audio media message. An initialized `JSQAudioMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQAudioMediaItem` to provide additional functionality or behavior.
 */
@interface JSQAudioMediaItem : JSQMediaItem <JSQMessageMediaData, AVAudioPlayerDelegate, NSCoding, NSCopying>

/**
 *  The delegate object for audio event notifications.
 */
@property (nonatomic, weak, nullable) id<JSQAudioMediaItemDelegate> delegate;

/**
 *  The view attributes to configure the appearance of the audio media view.
 */
@property (nonatomic, strong, readonly) JSQAudioMediaViewAttributes *audioViewAttributes;

/**
 *  A data object that contains an audio resource.
 */
@property (nonatomic, strong, nullable) NSData *audioData;

/**
 *  Initializes and returns a audio media item having the given audioData.
 *
 *  @param audioData              The data object that contains the audio resource.
 *  @param audioViewAttributes The view attributes to configure the appearance of the audio media view.
 *
 *  @return An initialized `JSQAudioMediaItem`.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `JSQVideoMediaItem` with a `nil` audioData.
 *  Once the audio is available you can set the `audioData` property.
 */
- (instancetype)initWithData:(nullable NSData *)audioData
         audioViewAttributes:(JSQAudioMediaViewAttributes *)audioViewAttributes NS_DESIGNATED_INITIALIZER;

/**
 *  Initializes and returns a default audio media item.
 *
 *  @return An initialized `JSQAudioMediaItem`.
 *
 *  @discussion You must set `audioData` to enable the play button.
 */
- (instancetype)init;

/**
 Initializes and returns a default audio media using the specified view attributes.

 @param audioViewAttributes The view attributes to configure the appearance of the audio media view.

 @return  An initialized `JSQAudioMediaItem`.
 */
- (instancetype)initWithAudioViewAttributes:(JSQAudioMediaViewAttributes *)audioViewAttributes;

/**
 *  Initializes and returns an audio media item having the given audioData.
 *
 *  @param audioData The data object that contains the audio resource.
 *
 *  @return An initialized `JSQAudioMediaItem`.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `JSQAudioMediaItem` with a `nil` audioData.
 *  Once the audio is available you can set the `audioData` property.
 */
- (instancetype)initWithData:(nullable NSData *)audioData;

/**
 *  Sets or updates the data object in an audio media item with the data specified at audioURL.
 *
 *  @param audioURL A File URL containing the location of the audio data.
 */
- (void)setAudioDataWithUrl:(nonnull NSURL *)audioURL;

@end

NS_ASSUME_NONNULL_END
