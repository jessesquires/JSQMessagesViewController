//
//  JSQAudioMediaItem.h
//

#import "JSQMediaItem.h"

#import "AVFoundation/AVFoundation.h"

@class JSQAudioMediaItem;
@class JSQAudioMediaViewConfiguration;

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
@property (nonatomic, weak) id<JSQAudioMediaItemDelegate> delegate;

/**
 * The configuration object for the audio media view.
 *
 * @discussion Default values are used if this is `nil`.
 */
@property (nonatomic, strong, nonnull) JSQAudioMediaViewConfiguration *audioViewConfiguration;

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
- (nullable instancetype)initWithAudioViewConfiguration:(nonnull JSQAudioMediaViewConfiguration*)config;

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
- (nullable instancetype)initWithData:(nullable NSData *)audioData audioViewConfiguration:(nonnull JSQAudioMediaViewConfiguration*)config NS_DESIGNATED_INITIALIZER;


/**
 *  Set or update the data object in an audio media item
 *
 *  @param audioURL       A File URL containing the location of the audio data.
 */
- (void)setAudioDataWithUrl:(nonnull NSURL *)audioURL;

@end

@interface JSQAudioMediaViewConfiguration : NSObject

/**
 *  A UIImage to be used for the play button. A default value will be used if not set.
 */
@property (strong, nonatomic, nonnull) UIImage * playButtonImage;

/**
 *  A UIImage to be used for the pause button. A default value will be used if not set.
 */
@property (strong, nonatomic, nonnull) UIImage * pauseButtonImage;

/**
 *  A UIFont to be used for the elapsed time label. A system font will be used if not set.
 */
@property (strong, nonatomic, nonnull) UIFont * labelFont;

/**
 *  Show fractions of a second (for audio files with a duration < 1 minute)
 */
@property (nonatomic) BOOL showFractionalSeconds;

/**
 *  A UIColor to be used for the player's background.
 */
@property (strong, nonatomic, nonnull) UIColor * backgroundColor;

/**
 *  A UIColor to be used for the player's tint.
 */
@property (strong, nonatomic, nonnull) UIColor * tintColor;

/**
 * UIEdgeInsets used to determine padding around the play/pause button and timer label
 */
@property (nonatomic) UIEdgeInsets controlInsets;

/**
 * CGFloat used to determine padding between the button, progress bar, and label
 */
@property (nonatomic) CGFloat controlPadding;

/**
 * Audio Category set prior to playback
 */
@property (nonatomic, nonnull) NSString * audioCategory;

/**
 * Audio Category options set prior to playback
 */
@property (nonatomic) AVAudioSessionCategoryOptions audioCategoryOptions;

@end