//
//  JSQAudioPlayerView.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-6.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQAudioPlayerView.h"

#import <AVFoundation/AVFoundation.h>
#import "JSQMessage.h"

@interface JSQAudioPlayerView ()

@property (strong, nonatomic) UILabel *durationLabel;
@property (strong, nonatomic) UIImageView *animationContainer;

@end

@implementation JSQAudioPlayerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _incomingMessage = YES;
        
        _durationLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _durationLabel.textAlignment = NSTextAlignmentCenter;
        _durationLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_durationLabel];
        
        _animationContainer = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"demo_audio_normal"] highlightedImage:[UIImage imageNamed:@"demo_audio_press"]];
        _animationContainer.frame = CGRectZero;
        _animationContainer.userInteractionEnabled = YES;
        _animationContainer.animationImages = @[[UIImage imageNamed:@"demo_audio_play_1"],
                                                [UIImage imageNamed:@"demo_audio_play_2"],
                                                [UIImage imageNamed:@"demo_audio_normal"]];
        [self addSubview:_animationContainer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.durationLabel.frame = CGRectMake(10, (CGRectGetHeight(self.bounds) - 20) / 2, 50, 20);
    self.animationContainer.frame = CGRectMake(CGRectGetMaxX(self.durationLabel.frame), CGRectGetMinY(self.durationLabel.frame), 34, 34);
}

- (void)setMessage:(JSQMessage *)message
{
    if (_message != message) {
        
        CGFloat duration = [self durationFromAudioFileURL:message.sourceURL];
        self.durationLabel.text = [NSString stringWithFormat:@"%d \"", (NSUInteger)ceil(duration)];
        
        _message = message;
    }
}

- (void)setIncomingMessage:(BOOL)incomingMessage
{
    if (_incomingMessage != incomingMessage) {
        
        self.animationContainer.transform = incomingMessage ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(M_PI);
        
        _incomingMessage = incomingMessage;
    }
}


- (CGFloat)durationFromAudioFileURL:(NSURL *)url
{
    NSParameterAssert(url != nil);
    
    AVURLAsset* audioAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    CMTime audioDuration = audioAsset.duration;
    return CMTimeGetSeconds(audioDuration);
}

- (void)startAnimation
{
    [self.animationContainer startAnimating];
}

- (void)stopAnimation
{
    [self.animationContainer stopAnimating];
}

@end
