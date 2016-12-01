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

#import "JSQAudioMediaViewAttributes.h"

#import "UIImage+JSQMessages.h"
#import "UIColor+JSQMessages.h"

@implementation JSQAudioMediaViewAttributes

- (instancetype)initWithPlayButtonImage:(UIImage *)playButtonImage
                       pauseButtonImage:(UIImage *)pauseButtonImage
                              labelFont:(UIFont *)labelFont
                  showFractionalSecodns:(BOOL)showFractionalSeconds
                        backgroundColor:(UIColor *)backgroundColor
                              tintColor:(UIColor *)tintColor
                          controlInsets:(UIEdgeInsets)controlInsets
                         controlPadding:(CGFloat)controlPadding
                          audioCategory:(NSString *)audioCategory
                   audioCategoryOptions:(AVAudioSessionCategoryOptions)audioCategoryOptions {
    NSParameterAssert(playButtonImage != nil);
    NSParameterAssert(pauseButtonImage != nil);
    NSParameterAssert(labelFont != nil);
    NSParameterAssert(backgroundColor != nil);
    NSParameterAssert(tintColor != nil);
    NSParameterAssert(audioCategory != nil);

    self = [super init];
    if (self) {
        _playButtonImage = playButtonImage;
        _pauseButtonImage = pauseButtonImage;
        _labelFont = labelFont;
        _showFractionalSeconds = showFractionalSeconds;
        _backgroundColor = backgroundColor;
        _tintColor = tintColor;
        _controlInsets = controlInsets;
        _controlPadding = controlPadding;
        _audioCategory = audioCategory;
        _audioCategoryOptions = audioCategoryOptions;
    }
    return self;
}

- (instancetype)init
{
    UIColor *tintColor = [UIColor jsq_messageBubbleBlueColor];
    AVAudioSessionCategoryOptions options = AVAudioSessionCategoryOptionDuckOthers
    | AVAudioSessionCategoryOptionDefaultToSpeaker
    | AVAudioSessionCategoryOptionAllowBluetooth;

    return [self initWithPlayButtonImage:[[UIImage jsq_defaultPlayImage] jsq_imageMaskedWithColor:tintColor]
                        pauseButtonImage:[[UIImage jsq_defaultPauseImage] jsq_imageMaskedWithColor:tintColor]
                               labelFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]
                   showFractionalSecodns:NO
                         backgroundColor:[UIColor jsq_messageBubbleLightGrayColor]
                               tintColor:tintColor
                           controlInsets:UIEdgeInsetsMake(6, 6, 6, 18)
                          controlPadding:6
                           audioCategory:@"AVAudioSessionCategoryPlayback"
                    audioCategoryOptions:options];
}

- (void)setPlayButtonImage:(UIImage *)playButtonImage
{
    NSParameterAssert(playButtonImage != nil);
    _playButtonImage = playButtonImage;
}

- (void)setPauseButtonImage:(UIImage *)pauseButtonImage
{
    NSParameterAssert(pauseButtonImage != nil);
    _pauseButtonImage = pauseButtonImage;
}

- (void)setLabelFont:(UIFont *)labelFont
{
    NSParameterAssert(labelFont != nil);
    _labelFont = labelFont;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    NSParameterAssert(backgroundColor != nil);
    _backgroundColor = backgroundColor;
}

- (void)setTintColor:(UIColor *)tintColor
{
    NSParameterAssert(tintColor != nil);
    _tintColor = tintColor;
}

- (void)setAudioCategory:(NSString *)audioCategory
{
    NSParameterAssert(audioCategory != nil);
    _audioCategory = audioCategory;
}

@end
