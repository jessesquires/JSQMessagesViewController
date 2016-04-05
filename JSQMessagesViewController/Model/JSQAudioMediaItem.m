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

#import "JSQAudioMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

#import "UIImage+JSQMessages.h"
#import "UIColor+JSQMessages.h"

@interface JSQAudioMediaItem ()

@property (strong, nonatomic) UIView *cachedMediaView;

@property (strong, nonatomic) UIButton *playButton;

@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) NSTimer *progressTimer;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation JSQAudioMediaItem

#pragma mark - Initialization

- (instancetype)initWithData:(NSData *)audioData audioViewAttributes:(nonnull JSQAudioMediaViewAttributes *)attributes
{
    self = [super init];
    if (self) {
        _cachedMediaView = nil;
        _audioData = [audioData copy];
        _audioViewAttributes = attributes;
    }
    return self;
}

- (instancetype)initWithData:(NSData *)audioData
{
    return [self initWithData:audioData audioViewAttributes:[[JSQAudioMediaViewAttributes alloc] init]];
}

- (instancetype)initWithAudioViewAttributes:(JSQAudioMediaViewAttributes *)attributes
{
    return [self initWithData:nil audioViewAttributes:attributes];
}

- (instancetype)init
{
    return [self initWithData:nil audioViewAttributes:[[JSQAudioMediaViewAttributes alloc] init]];
}

- (void)dealloc
{
    _audioData = nil;
    [self clearCachedMediaViews];
}

- (void)clearCachedMediaViews
{
    [_audioPlayer stop];
    _audioPlayer = nil;
    
    _playButton = nil;
    _progressView = nil;
    _progressLabel = nil;
    [self stopProgressTimer];
    
    _cachedMediaView = nil;
    [super clearCachedMediaViews];
}

#pragma mark - Setters

- (void)setAudioData:(NSData *)audioData
{
    _audioData = [audioData copy];
    [self clearCachedMediaViews];
}

- (void)setAudioDataWithUrl:(NSURL *)audioURL
{
    _audioData = [NSData dataWithContentsOfURL:audioURL];
    [self clearCachedMediaViews];
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedMediaView = nil;
}

#pragma mark - Private

- (void)startProgressTimer {
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(updateProgressTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)stopProgressTimer {
    [_progressTimer invalidate];
    _progressTimer = nil;
}

- (void)updateProgressTimer:(id)sender {
    if (_audioPlayer.playing) {
        _progressView.progress = _audioPlayer.currentTime/_audioPlayer.duration;
        _progressLabel.text = [self timestampString:_audioPlayer.currentTime
                                        forDuration:_audioPlayer.duration];
    }
}

- (NSString *)timestampString:(NSTimeInterval)currentTime forDuration:(NSTimeInterval)duration {
    // print the time as 0:ss or ss.x up to 59 seconds
    // print the time as m:ss up to 59:59 seconds
    // print the time as h:mm:ss for anything longer
    if (duration < 60) {
        if (self.audioViewAttributes.showFractionalSeconds) {
            return [NSString stringWithFormat:@"%.01f", currentTime];
        } else if (currentTime < duration) {
            return [NSString stringWithFormat:@"0:%02d", (int)round(currentTime)];
        }
        return [NSString stringWithFormat:@"0:%02d", (int)ceil(currentTime)];
    } else if (duration < 3600) {
        return [NSString stringWithFormat:@"%d:%02d",
                (int)currentTime / 60, (int)currentTime % 60];
    } else {
        return [NSString stringWithFormat:@"%d:%02d:%02d",
                (int)currentTime / 3600, (int)currentTime / 60, (int)currentTime % 60];
    }
}

- (void)onPlayButton:(id)sender {
    
    NSString * category = [AVAudioSession sharedInstance].category;
    AVAudioSessionCategoryOptions options = [AVAudioSession sharedInstance].categoryOptions;
    
    if (category != self.audioViewAttributes.audioCategory ||
        options != self.audioViewAttributes.audioCategoryOptions) {
        NSError * error;
        [[AVAudioSession sharedInstance] setCategory:self.audioViewAttributes.audioCategory
                                         withOptions:self.audioViewAttributes.audioCategoryOptions
                                               error:&error];
        if (self.delegate) {
            [self.delegate audioMediaItem:self didChangeAudioCategory:category options:options error:error];
        }
    }
    
    if (_audioPlayer.playing) {
        _playButton.selected = NO;
        [self stopProgressTimer];
        [_audioPlayer stop];
    } else {
        
        // fade the button from play to pause
        [UIView transitionWithView:_playButton
                          duration:.2
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            _playButton.selected = YES;
                        }
                        completion:nil];
        
        [self startProgressTimer];
        [_audioPlayer play];
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag {
    
    // set progress to full, then fade back to the default state
    [self stopProgressTimer];
    _progressView.progress = 1;
    [UIView transitionWithView:self.cachedMediaView
                      duration:.2
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _progressView.progress = 0;
                        _playButton.selected = NO;
                        _progressLabel.text = [self timestampString:_audioPlayer.duration
                                                        forDuration:_audioPlayer.duration];
                    }
                    completion:nil];
}

#pragma mark - JSQMessageMediaData protocol

- (CGSize)mediaViewDisplaySize
{
    return CGSizeMake(160.0f,
                      self.audioViewAttributes.controlInsets.top +
                      self.audioViewAttributes.controlInsets.bottom +
                      self.audioViewAttributes.playButtonImage.size.height);
}

- (UIView *)mediaView
{
    if (self.audioData && self.cachedMediaView == nil) {

        if (_audioData) {
            _audioPlayer = [[AVAudioPlayer alloc] initWithData:_audioData error:nil];
            _audioPlayer.delegate = self;
        }
        
        // create container view for the various controls
        CGSize size = [self mediaViewDisplaySize];
        UIView * playView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        playView.backgroundColor = self.audioViewAttributes.backgroundColor;
        playView.contentMode = UIViewContentModeCenter;
        playView.clipsToBounds = YES;

        // create the play button
        CGRect buttonFrame = CGRectMake(self.audioViewAttributes.controlInsets.left,
                                        self.audioViewAttributes.controlInsets.top,
                                        self.audioViewAttributes.playButtonImage.size.width,
                                        self.audioViewAttributes.playButtonImage.size.height);
        _playButton = [[UIButton alloc] initWithFrame:buttonFrame];
        [_playButton setImage:self.audioViewAttributes.playButtonImage forState:UIControlStateNormal];
        [_playButton setImage:self.audioViewAttributes.pauseButtonImage forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(onPlayButton:) forControlEvents:UIControlEventTouchUpInside];
        [playView addSubview:_playButton];

        // create a label to show the duration / elapsed time
        NSString * durationString = [self timestampString:_audioPlayer.duration
                                              forDuration:_audioPlayer.duration];
        NSString * maxWidthString = [@"" stringByPaddingToLength:[durationString length] withString:@"0" startingAtIndex:0];
        
        // this is cheesy, but it centers the progress bar without extra space and
        // without causing it to wiggle from side to side as the label text changes
        CGSize labelSize = CGSizeMake(36,18);
        if ([durationString length] < 4)
            labelSize = CGSizeMake(18,18);
        else if ([durationString length] < 5)
            labelSize = CGSizeMake(24,18);
        else if ([durationString length] < 6)
            labelSize = CGSizeMake(30, 18);
        CGRect labelFrame = CGRectMake(size.width - labelSize.width - self.audioViewAttributes.controlInsets.right,
                                       self.audioViewAttributes.controlInsets.top, labelSize.width, labelSize.height);
        _progressLabel = [[UILabel alloc] initWithFrame:labelFrame];
        _progressLabel.textAlignment = NSTextAlignmentLeft;
        _progressLabel.adjustsFontSizeToFitWidth = YES;
        _progressLabel.textColor = self.audioViewAttributes.tintColor;
        _progressLabel.font = self.audioViewAttributes.labelFont;
        _progressLabel.text = maxWidthString;
        
        // sizeToFit adjusts the frame's height to the font
        [_progressLabel sizeToFit];
        labelFrame.origin.x = size.width - _progressLabel.frame.size.width - self.audioViewAttributes.controlInsets.right;
        labelFrame.origin.y =  ((size.height - _progressLabel.frame.size.height) / 2);
        labelFrame.size.width = _progressLabel.frame.size.width;
        labelFrame.size.height =  _progressLabel.frame.size.height;
        _progressLabel.frame = labelFrame;
        _progressLabel.text = durationString;
        [playView addSubview:_progressLabel];

        // create a progress bar
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        CGFloat xOffset = _playButton.frame.origin.x + _playButton.frame.size.width + self.audioViewAttributes.controlPadding;
        CGFloat width = labelFrame.origin.x - xOffset - self.audioViewAttributes.controlPadding;
        _progressView.frame = CGRectMake(xOffset, (size.height - _progressView.frame.size.height) / 2,
                                          width, _progressView.frame.size.height);
        _progressView.tintColor = self.audioViewAttributes.tintColor;
        [playView addSubview:_progressView];

        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:playView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedMediaView = playView;
    }
    
    return self.cachedMediaView;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }
    
    JSQAudioMediaItem *audioItem = (JSQAudioMediaItem *)object;
    if (self.audioData && ![self.audioData isEqualToData:audioItem.audioData]) {
        return NO;
    }
    
    return YES;
}

- (NSUInteger)hash
{
    return super.hash ^ self.audioData.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: audioData=%ld bytes, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], (unsigned long)[self.audioData length],
            @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSData * data = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(audioData))];
    return [self initWithData:data];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.audioData forKey:NSStringFromSelector(@selector(audioData))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQAudioMediaItem *copy;
    copy = [[[self class] allocWithZone:zone] initWithData:self.audioData
                                       audioViewAttributes:self.audioViewAttributes];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
