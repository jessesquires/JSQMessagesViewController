//
//  JSQAudioMediaItem.h
//

#import "JSQMediaItem.h"

#import "AVFoundation/AVFoundation.h"

@class JSQAudioMediaItem;
@protocol JSQAudioMediaItemDelegate <NSObject>
@optional

/* didChangeOriginalAudioCategory is called if JSQAudioMediaItem changes the sound category or categoryOptions */
- (void)audioMediaItem:(JSQAudioMediaItem*)audioMediaItem didChangeOriginalAudioCategory:(NSString *)category originalOptions:(AVAudioSessionCategoryOptions)options;

/* didNotChangeCategory is called if JSQAudioMediaItem fails to change the category or categoryOptions */
- (void)audioMediaItem:(JSQAudioMediaItem*)audioMediaItem didNotChangeCategory:(NSError*)error;

@end

/**
 *  The `JSQAudioMediaItem` class is a concrete `JSQMediaItem` subclass that implements the `JSQMessageMediaData` protocol
 *  and represents a video media message. An initialized `JSQAudioMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQAudioMediaItem` to provide additional functionality or behavior.
 */
@interface JSQAudioMediaItem : JSQMediaItem <JSQMessageMediaData, AVAudioPlayerDelegate, NSCoding, NSCopying>

/**
 *  delegate used for notification of audio events
 */
@property (nonatomic, weak) id<JSQAudioMediaItemDelegate> delegate;

/**
 *  The URL that identifies a video resource.
 */
@property (nonatomic, strong) NSURL *audioURL;

/**
 *  An NSData object that contains an audio resource.
 */
@property (nonatomic, strong) NSData *audioData;

/**
 *  A boolean value that specifies whether or not the audio is ready to be played.
 *
 *  @discussion When set to `YES`, the audio is ready. When set to `NO` it is not ready.
 */
@property (nonatomic, assign) BOOL isReadyToPlay;

/**
 *  A UIImage to be used for the play button. A default value will be used if not set.
 */
@property (strong, nonatomic) UIImage * playButtonImage;

/**
 *  A UIImage to be used for the pause button. A default value will be used if not set.
 */
@property (strong, nonatomic) UIImage * pauseButtonImage;

/**
 *  A UIFont to be used for the elapsed time label. A system font will be used if not set.
 */
@property (strong, nonatomic) UIFont * labelFont;

/**
 *  A UIColor to be used for the player's background.
 */
@property (strong, nonatomic) UIColor * backgroundColor;

/**
 *  A UIColor to be used for the player's tint.
 */
@property (strong, nonatomic) UIColor * tintColor;

/**
 * UIEdgeInsets used to determine padding around the play/pause button and timer label
 */
@property (nonatomic) UIEdgeInsets controlInsets;

/**
 * CGFloat used to determine padding between the button, progress bar, and label
 */
@property (nonatomic) CGFloat controlPadding;

/**
 * Audio Category set prior to playback. Original value
 */
@property (nonatomic) NSString * audioCategory;

/**
 * Audio Category options set prior to playback 
 */
@property (nonatomic) AVAudioSessionCategoryOptions audioCategoryOptions;

/**
 *  Initializes and returns an audio media item having the given audioURL.
 *
 *  @param audioURL      The URL that identifies the audio resource.
 *  @param isReadyToPlay A boolean value that specifies if the audio is ready to play.
 *
 *  @return An initialized `JSQAudioMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `JSQAudioMediaItem` with a `nil` audioURL or specify `NO` for
 *  isReadyToPlay. Once the audio has been saved to disk, or is ready to stream, you can
 *  set the audioURL property or isReadyToPlay property, respectively.
 */
- (instancetype)initWithURL:(NSURL *)audioURL isReadyToPlay:(BOOL)isReadyToPlay;

/**
 *  Initializes and returns a audio media item having the given audioData.
 *
 *  @param audioData       The data object that contains the audio resource.
 *
 *  @return An initialized `JSQAudioMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the audio must be downloaded from the network,
 *  you may initialize a `JSQVideoMediaItem` with a `nil` audioData.
 *  Once the audio is available you can set the file data property.
 */
- (instancetype)initWithData:(NSData *)fileData;

@end
