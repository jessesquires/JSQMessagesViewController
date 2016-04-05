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

@interface JSQAudioMediaViewAttributes : NSObject

/**
 *  A UIImage to be used for the play button. A default value will be used if not set.
 */
@property (strong, nonatomic, nonnull) UIImage *playButtonImage;

/**
 *  A UIImage to be used for the pause button. A default value will be used if not set.
 */
@property (strong, nonatomic, nonnull) UIImage *pauseButtonImage;

/**
 *  A UIFont to be used for the elapsed time label. A system font will be used if not set.
 */
@property (strong, nonatomic, nonnull) UIFont *labelFont;

/**
 *  Show fractions of a second (for audio files with a duration < 1 minute)
 */
@property (nonatomic) BOOL showFractionalSeconds;

/**
 *  A UIColor to be used for the player's background.
 */
@property (strong, nonatomic, nonnull) UIColor *backgroundColor;

/**
 *  A UIColor to be used for the player's tint.
 */
@property (strong, nonatomic, nonnull) UIColor *tintColor;

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
@property (nonatomic, nonnull) NSString *audioCategory;

/**
 * Audio Category options set prior to playback
 */
@property (nonatomic) AVAudioSessionCategoryOptions audioCategoryOptions;

/**
 *  Returns a default JSQAudioMediaViewAttributes object to set the appearance of JSQAudioMediaItem
 */
- (nullable instancetype)init;

@end