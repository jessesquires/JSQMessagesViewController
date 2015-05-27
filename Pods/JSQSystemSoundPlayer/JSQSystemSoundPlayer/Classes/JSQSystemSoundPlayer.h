//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQSystemSoundPlayer
//
//
//  GitHub
//  https://github.com/jessesquires/JSQSystemSoundPlayer
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>

/**
 *  String constant for .caf audio file extension.
 */
FOUNDATION_EXPORT NSString * const kJSQSystemSoundTypeCAF;

/**
 *  String constant for .aif audio file extension.
 */
FOUNDATION_EXPORT NSString * const kJSQSystemSoundTypeAIF;

/**
 *  String constant for .aiff audio file extension.
 */
FOUNDATION_EXPORT NSString * const kJSQSystemSoundTypeAIFF;

/**
 *  String constant for .wav audio file extension.
 */
FOUNDATION_EXPORT NSString * const kJSQSystemSoundTypeWAV;

/**
 *  A completion block to be called after a system sound has finished playing.
 */
typedef void(^JSQSystemSoundPlayerCompletionBlock)(void);

/**
 *  The `JSQSystemSoundPlayer` class enables you to play sound effects, alert sounds, or other short sounds.
 *  It lazily loads and caches all `SystemSoundID` objects and purges them upon
 *  receiving the `UIApplicationDidReceiveMemoryWarningNotification` notification.
 */
@interface JSQSystemSoundPlayer : NSObject

/**
 *  Returns whether or not the sound player is on.
 *  That is, whether the sound player is enabled or disabled.
 *  If disabled, it will not play sounds.
 *
 *  @see `toggleSoundPlayerOn:`
 */
@property (assign, nonatomic, readonly) BOOL on;

/**
 *  The bundle in which the sound player uses to search for sound file resources. You may change this property as needed.
 *  The default value is the main bundle. This value must not be `nil`.
 */
@property (strong, nonatomic) NSBundle *bundle;

/**
 *  Returns the shared `JSQSystemSoundPlayer` object. This method always returns the same sound system player object.
 *
 *  @return An initialized `JSQSystemSoundPlayer` object if successful, `nil` otherwise.
 */
+ (JSQSystemSoundPlayer *)sharedPlayer;

/**
 *  Toggles the sound player on or off by setting the `kJSQSystemSoundPlayerUserDefaultsKey` key in `NSUserDefaults` to the given value.
 *  This will enable or disable the playing of sounds via `JSQSystemSoundPlayer` globally.
 *  This setting is persisted across application launches.
 *
 *  @param on A boolean indicating whether or not to enable or disable the sound player settings.
 *  Pass `YES` to turn sounds on, and `NO` to turn sounds off.
 *
 *  @warning Disabling the sound player (passing a value of `NO`) will invoke the `stopAllSounds` method.
 */
- (void)toggleSoundPlayerOn:(BOOL)on;

/**
 *  Plays a system sound object corresponding to an audio file with the given filename and extension.
 *  The system sound player will lazily initialize and load the file before playing it, and then cache its corresponding `SystemSoundID`.
 *  If this file has previously been played, it will be loaded from cache and played immediately.
 *
 *  @param filename      A string containing the base name of the audio file to play.
 *  @param fileExtension A string containing the extension of the audio file to play.
 *  This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, `kJSQSystemSoundTypeAIFF`, or `kJSQSystemSoundTypeWAV`.
 *
 *  @warning If the system sound object cannot be created, this method does nothing.
 */
- (void)playSoundWithFilename:(NSString *)filename fileExtension:(NSString *)fileExtension;

/**
 *  Plays a system sound object corresponding to an audio file with the given filename and extension,
 *  and excutes completionBlock when the sound has stopped playing.
 *  The system sound player will lazily initialize and load the file before playing it, and then cache its corresponding `SystemSoundID`.
 *  If this file has previously been played, it will be loaded from cache and played immediately.
 *
 *  @param filename      A string containing the base name of the audio file to play.
 *  @param fileExtension A string containing the extension of the audio file to play.
 *  This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, `kJSQSystemSoundTypeAIFF`, or `kJSQSystemSoundTypeWAV`.
 *
 *  @param completionBlock A block called after the sound has stopped playing.
 *  This block is retained by `JSQSystemSoundPlayer`, temporarily cached, and released after its execution.
 *
 *  @warning If the system sound object cannot be created, this method does nothing.
 */
- (void)playSoundWithFilename:(NSString *)filename
                fileExtension:(NSString *)fileExtension
                   completion:(JSQSystemSoundPlayerCompletionBlock)completionBlock;

/**
 *  Plays a system sound object *as an alert* corresponding to an audio file with the given filename and extension.
 *  The system sound player will lazily initialize and load the file before playing it, and then cache its corresponding `SystemSoundID`.
 *  If this file has previously been played, it will be loaded from cache and played immediately.
 *
 *  @param filename      A string containing the base name of the audio file to play.
 *  @param fileExtension A string containing the extension of the audio file to play.
 *  This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, `kJSQSystemSoundTypeAIFF`, or `kJSQSystemSoundTypeWAV`.
 *
 *  @warning If the system sound object cannot be created, this method does nothing.
 *
 *  @warning This method performs the same functions as `playSoundWithName: extension:`, with the excepion that,
 *  depending on the particular iOS device, this method may invoke vibration.
 */
- (void)playAlertSoundWithFilename:(NSString *)filename fileExtension:(NSString *)fileExtension;

/**
 *  Plays a system sound object *as an alert* corresponding to an audio file with the given filename and extension,
 *  and and excutes completionBlock when the sound has stopped playing.
 *  The system sound player will lazily initialize and load the file before playing it, and then cache its corresponding `SystemSoundID`.
 *  If this file has previously been played, it will be loaded from cache and played immediately.
 *
 *  @param filename      A string containing the base name of the audio file to play.
 *  @param fileExtension A string containing the extension of the audio file to play.
 *  This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, `kJSQSystemSoundTypeAIFF`, or `kJSQSystemSoundTypeWAV`.
 *
 *  @param completionBlock A block called after the sound has stopped playing.
 *  This block is retained by `JSQSystemSoundPlayer`, temporarily cached, and released after its execution.
 *
 *  @warning If the system sound object cannot be created, this method does nothing.
 *
 *  @warning This method performs the same functions as `playSoundWithName: extension: completion:`,
 *  with the excepion that, depending on the particular iOS device, this method may invoke vibration.
 */
- (void)playAlertSoundWithFilename:(NSString *)filename
                     fileExtension:(NSString *)fileExtension
                        completion:(JSQSystemSoundPlayerCompletionBlock)completionBlock;

/**
 *  On some iOS devices, you can call this method to invoke vibration.
 *  On other iOS devices this functionaly is not available, and calling this method does nothing.
 */
- (void)playVibrateSound;

/**
 *  Stops playing all sounds immediately.
 *
 *  @warning Any completion blocks attached to any currently playing sound will *not* be executed.
 *  Also, calling this method will purge all `SystemSoundID` objects from cache, regardless of whether or not they were currently playing.
 */
- (void)stopAllSounds;

/**
 *  Stops playing the sound with the given filename immediately.
 *
 *  @param filename The filename of the sound to stop playing.
 *
 *  @warning If a completion block is attached to the given sound, it will *not* be executed.
 *  Also, calling this method will purge the `SystemSoundID` object for this file from cache, regardless of whether or not it was currently playing.
 */
- (void)stopSoundWithFilename:(NSString *)filename;

/**
 *  Preloads a system sound object corresponding to an audio file with the given filename and extension.
 *  The system sound player will initialize, load, and cache the corresponding `SystemSoundID`.
 *
 *  @param filename      A string containing the base name of the audio file to play.
 *  @param fileExtension A string containing the extension of the audio file to play.
 *  This parameter must be one of `kJSQSystemSoundTypeCAF`, `kJSQSystemSoundTypeAIF`, `kJSQSystemSoundTypeAIFF`, or `kJSQSystemSoundTypeWAV`.
 *
 */
- (void)preloadSoundWithFilename:(NSString *)filename fileExtension:(NSString *)fileExtension;

@end
