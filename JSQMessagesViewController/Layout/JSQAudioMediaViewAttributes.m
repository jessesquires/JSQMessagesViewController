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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _controlPadding = 6;
        
        _controlInsets = UIEdgeInsetsMake(6, 6, 6, 18);
        
        _labelFont = [UIFont systemFontOfSize:12];
        
        _showFractionalSeconds = NO;
        
        _backgroundColor = [UIColor jsq_messageBubbleLightGrayColor];
        
        _tintColor = [UIButton buttonWithType:UIButtonTypeSystem].tintColor;
        
        _playButtonImage = [[UIImage jsq_defaultPlayImage] jsq_imageMaskedWithColor:_tintColor];
        
        _pauseButtonImage = [[UIImage jsq_defaultPauseImage] jsq_imageMaskedWithColor:_tintColor];
        
        _audioCategory = @"AVAudioSessionCategoryPlayback";
        
        _audioCategoryOptions = AVAudioSessionCategoryOptionDuckOthers | AVAudioSessionCategoryOptionDefaultToSpeaker | AVAudioSessionCategoryOptionAllowBluetooth;
    }
    
    return self;
}

@end
