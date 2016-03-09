//
//  JSQAudioMediaItem.m
//

#import "JSQAudioMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

#import "UIImage+JSQMessages.h"
#import "UIColor+JSQMessages.h"

@interface JSQAudioMediaItem ()

@property (strong, nonatomic) UIView *          cachedMediaView;

@property (strong, nonatomic) UIButton *        playButton;

@property (strong, nonatomic) UIProgressView *  progressView;
@property (strong, nonatomic) UILabel *         progressLabel;
@property (strong, nonatomic) NSTimer *         progressTimer;

@property (strong, nonatomic) AVAudioPlayer *   audioPlayer;

@end

@implementation JSQAudioMediaItem

#pragma mark - Initialization

- (instancetype)initWithURL:(NSURL *)audioURL isReadyToPlay:(BOOL)isReadyToPlay
{
    self = [super init];
    if (self) {
        _audioURL = [audioURL copy];
        _isReadyToPlay = isReadyToPlay;
        _cachedMediaView = nil;
        [self defaultsInit];
    }
    return self;
}

- (instancetype)initWithData:(NSData *)audioData
{
    self = [super init];
    if (self) {
        _audioData = [audioData copy];
        _isReadyToPlay = [audioData length] > 0;
        _cachedMediaView = nil;
        [self defaultsInit];
    }
    return self;
}

- (void)defaultsInit
{
    // set defaults when initialized; user can override
    
    _controlPadding = 6;
    _controlInsets = UIEdgeInsetsMake(6, 6, 6, 18);
    
    _labelFont = [UIFont systemFontOfSize:12];

    _backgroundColor = [UIColor jsq_messageBubbleLightGrayColor];
    _tintColor = [UIButton buttonWithType:UIButtonTypeSystem].tintColor;
}

- (void)dealloc
{
    _audioURL = nil;
    _audioData = nil;
    [self clearCachedMediaViews];
}

- (void)clearCachedMediaViews
{
    [super clearCachedMediaViews];
    _cachedMediaView = nil;
    
    [_audioPlayer stop];
    _audioPlayer = nil;

    [_progressTimer invalidate];
    _progressTimer = nil;
    
    _progressLabel = nil;
    _progressView = nil;
    _playButton = nil;
}

#pragma mark - Setters

- (void)setAudioURL:(NSURL *)audioURL
{
    [self clearCachedMediaViews];
    _audioURL = [audioURL copy];
    _audioData = nil;
}

- (void)setAudioData:(NSData *)audioData
{
    [self clearCachedMediaViews];
    _audioData = [audioData copy];
    _audioURL = nil;
    _isReadyToPlay = [audioData length] > 0;
}

- (void)setIsReadyToPlay:(BOOL)isReadyToPlay
{
    _isReadyToPlay = isReadyToPlay;
    _cachedMediaView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedMediaView = nil;
}

#pragma mark - Internal logic

- (NSString *)timestampString:(NSTimeInterval)currentTime forDuration:(NSTimeInterval)duration {
    // print the time as ss.x up to 59 seconds
    // print the time as m:ss up to 59:59 seconds
    // print the time as h:mm:ss for anything longer
    if (duration < 60) {
        return [NSString stringWithFormat:@"%.01f", currentTime];
    } else if (duration < 3600) {
        return [NSString stringWithFormat:@"%d:%02d",
                (int)currentTime / 60, (int)currentTime % 60];
    } else {
        return [NSString stringWithFormat:@"%d:%02d:%02d",
                (int)currentTime / 3600, (int)currentTime / 60, (int)currentTime % 60];
    }
}

- (void)updateProgress:(id)sender {
    // update the elapsed time label
    if (_audioPlayer.playing) {
        _progressView.progress = _audioPlayer.currentTime/_audioPlayer.duration;
        _progressLabel.text = [self timestampString:_audioPlayer.currentTime
                                        forDuration:_audioPlayer.duration];
    }
}

- (void)onPlayButton:(id)sender {
    
    if (_audioPlayer.playing) {
        [_progressTimer invalidate];
        _progressTimer = nil;
        
        _playButton.selected = NO;
        [_audioPlayer stop];
    } else {
        
        // fade the button from play to pause
        [UIView transitionWithView:_playButton
                          duration:.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            _playButton.selected = YES;
                        }
                        completion:nil];
        
        // set a timer for updating the elapsed time
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                          target:self
                                                        selector:@selector(updateProgress:)
                                                        userInfo:nil
                                                         repeats:YES];
        [_audioPlayer play];
    }
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag {
    
    [_progressTimer invalidate];
    _progressTimer = nil;
    
    // set progress to full, then fade back to the default state
    _progressView.progress = 1;
    [UIView transitionWithView:self.cachedMediaView
                      duration:.3
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
    // load button images if not already available
    if (! self.playButtonImage) {
        self.playButtonImage = [[UIImage jsq_defaultPlayImage] jsq_imageMaskedWithColor:self.tintColor];
    }
    if (! self.pauseButtonImage) {
        self.pauseButtonImage = [[UIImage jsq_defaultPauseImage] jsq_imageMaskedWithColor:self.tintColor];
    }

    return CGSizeMake(160.0f, self.playButtonImage.size.height + self.controlInsets.top + self.controlInsets.bottom);
}

- (UIView *)mediaView
{
    if ((self.audioURL == nil && self.audioData == nil) || !self.isReadyToPlay) {
        return nil;
    }
    
    if (self.cachedMediaView == nil) {

        if (_audioData) {
            _audioPlayer = [[AVAudioPlayer alloc] initWithData:_audioData error:nil];
            _audioPlayer.delegate = self;
        } else if (_audioURL) {
            _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_audioURL error:nil];
            _audioPlayer.delegate = self;
        }
        
        // create container view for the various controls
        CGSize size = [self mediaViewDisplaySize];
        UIView * playView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        playView.backgroundColor = self.backgroundColor;
        playView.contentMode = UIViewContentModeCenter;
        playView.clipsToBounds = YES;

        // create the play button
        CGRect buttonFrame = CGRectMake(self.controlInsets.left,
                                        self.controlInsets.top,
                                        self.playButtonImage.size.width,
                                        self.playButtonImage.size.height);
        _playButton = [[UIButton alloc] initWithFrame:buttonFrame];
        [_playButton setImage:self.playButtonImage forState:UIControlStateNormal];
        [_playButton setImage:self.pauseButtonImage forState:UIControlStateSelected];
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
        CGRect labelFrame = CGRectMake(size.width - labelSize.width - self.controlInsets.right,
                                       self.controlInsets.top, labelSize.width, labelSize.height);
        _progressLabel = [[UILabel alloc] initWithFrame:labelFrame];
        _progressLabel.textAlignment = NSTextAlignmentLeft;
        _progressLabel.adjustsFontSizeToFitWidth = YES;
        _progressLabel.textColor = self.tintColor;
        _progressLabel.font = self.labelFont;
        _progressLabel.text = maxWidthString;
        
        // sizeToFit adjusts the frame's height to the font
        [_progressLabel sizeToFit];
        labelFrame.origin.x = size.width - _progressLabel.frame.size.width - self.controlInsets.right;
        labelFrame.origin.y =  ((size.height - _progressLabel.frame.size.height) / 2);
        labelFrame.size.width = _progressLabel.frame.size.width;
        labelFrame.size.height =  _progressLabel.frame.size.height;
        _progressLabel.frame = labelFrame;
        _progressLabel.text = durationString;
        [playView addSubview:_progressLabel];

        // create a progress bar
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        CGFloat xOffset = _playButton.frame.origin.x + _playButton.frame.size.width + self.controlPadding;
        CGFloat width = labelFrame.origin.x - xOffset - self.controlPadding;
        _progressView.frame = CGRectMake(xOffset, (size.height - _progressView.frame.size.height) / 2,
                                          width, _progressView.frame.size.height);
        _progressView.tintColor = self.tintColor;
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
    
    if ((self.audioURL && [self.audioURL isEqual:audioItem.audioURL]) ||
        (self.audioData && [self.audioData isEqualToData:audioItem.audioData]))
        return self.isReadyToPlay == audioItem.isReadyToPlay;
    else return NO;
}

- (NSUInteger)hash
{
    if (self.audioURL)
        return super.hash ^ self.audioURL.hash;
    else return super.hash ^ self.audioData.hash;
}

- (NSString *)description
{
    if (_audioURL) {
        return [NSString stringWithFormat:@"<%@: audioURL=%@, isReadyToPlay=%@, appliesMediaViewMaskAsOutgoing=%@>",
                [self class], self.audioURL, @(self.isReadyToPlay), @(self.appliesMediaViewMaskAsOutgoing)];
    } else {
        return [NSString stringWithFormat:@"<%@: audioData=%ld bytes, isReadyToPlay=%@, appliesMediaViewMaskAsOutgoing=%@>",
                [self class], [self.audioData length],
                @(self.isReadyToPlay), @(self.appliesMediaViewMaskAsOutgoing)];
    }
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _audioURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(fileURL))];
        _audioData = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(audioData))];
        _isReadyToPlay = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(isReadyToPlay))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.audioURL forKey:NSStringFromSelector(@selector(audioURL))];
    [aCoder encodeObject:self.audioData forKey:NSStringFromSelector(@selector(audioData))];
    [aCoder encodeBool:self.isReadyToPlay forKey:NSStringFromSelector(@selector(isReadyToPlay))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQAudioMediaItem *copy;
    if (self.audioData) {
        copy = [[[self class] allocWithZone:zone] initWithData:self.audioData];
    } else {
        copy = [[[self class] allocWithZone:zone] initWithURL:self.audioURL
                                                isReadyToPlay:self.isReadyToPlay];
    }
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
