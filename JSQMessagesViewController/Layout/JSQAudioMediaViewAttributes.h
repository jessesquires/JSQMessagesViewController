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
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 An instance of `JSQAudioMediaViewAttributes` specifies the appearance configuration of a `JSQAudioMediaItem`.
 Use this class to customize the appearance of `JSQAudioMediaItem`.
 */
@interface JSQAudioMediaViewAttributes : NSObject

/**
 *  The image for the play button. The default is a play icon.
 */
@property (nonatomic, strong) UIImage *playButtonImage;

/**
 *  The image for the pause button. The default is a pause icon.
 */
@property (nonatomic, strong) UIImage *pauseButtonImage;

/**
 *  The font for the elapsed time label. The default is a system font.
 */
@property (strong, nonatomic) UIFont *labelFont;

/**
 *  Specifies whether to show fractions of a second for audio files with a duration of less than 1 minute.
 */
@property (nonatomic, assign) BOOL showFractionalSeconds;

/**
 *  The background color for the player.
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  The tint color for the player.
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 *  Insets that sepcify the padding around the play/pause button and time label.
 */
@property (nonatomic, assign) UIEdgeInsets controlInsets;

/**
 *  Specifies the padding between the button, progress bar, and label.
 */
@property (nonatomic, assign) CGFloat controlPadding;

/**
 *  Specifies the audio category set prior to playback.
 */
@property (nonatomic, copy) NSString *audioCategory;

/**
 *  Specifies the audio category options set prior to playback.
 */
@property (nonatomic) AVAudioSessionCategoryOptions audioCategoryOptions;

/**
 Initializes and returns a `JSQAudioMediaViewAttributes` instance having the specified attributes.

 @param playButtonImage        The image for the play button.
 @param pauseButtonImage      The image for the pause button.
 @param labelFont             The font for the elapsed time label.
 @param showFractionalSeconds Specifies whether to show fractions of a second for audio files with a duration of less than 1 minute.
 @param backgroundColor       The background color for the player.
 @param tintColor             The tint color for the player.
 @param controlInsets         Insets that sepcify the padding around the play/pause button and time label.
 @param controlPadding        Specifies the padding between the button, progress bar, and label.
 @param audioCategory         Specifies the audio category set prior to playback.
 @param audioCategoryOptions  Specifies the audio category options set prior to playback.

 @return A new `JSQAudioMediaViewAttributes` instance
 */
- (instancetype)initWithPlayButtonImage:(UIImage *)playButtonImage
                       pauseButtonImage:(UIImage *)pauseButtonImage
                              labelFont:(UIFont *)labelFont
                  showFractionalSecodns:(BOOL)showFractionalSeconds
                        backgroundColor:(UIColor *)backgroundColor
                              tintColor:(UIColor *)tintColor
                          controlInsets:(UIEdgeInsets)controlInsets
                         controlPadding:(CGFloat)controlPadding
                          audioCategory:(NSString *)audioCategory
                   audioCategoryOptions:(AVAudioSessionCategoryOptions)audioCategoryOptions NS_DESIGNATED_INITIALIZER;

/**
 Initializes and returns a default `JSQAudioMediaViewAttributes` instance.

 @return A new `JSQAudioMediaViewAttributes` instance
 */
- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
