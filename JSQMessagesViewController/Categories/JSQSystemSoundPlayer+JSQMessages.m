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

#import "JSQSystemSoundPlayer+JSQMessages.h"

#import "JSQMessagesViewController.h"


static NSString * const kJSQMessageReceivedSoundName = @"message_received";
static NSString * const kJSQMessageSentSoundName = @"message_sent";


@implementation JSQSystemSoundPlayer (JSQMessages)

#pragma mark - Public

+ (void)jsq_playMessageReceivedSound
{
    [self jsq_playSoundFromJSQMessagesBundleWithName:kJSQMessageReceivedSoundName asAlert:NO];
}

+ (void)jsq_playMessageReceivedAlert
{
    [self jsq_playSoundFromJSQMessagesBundleWithName:kJSQMessageReceivedSoundName asAlert:YES];
}

+ (void)jsq_playMessageSentSound
{
    [self jsq_playSoundFromJSQMessagesBundleWithName:kJSQMessageSentSoundName asAlert:NO];
}

+ (void)jsq_playMessageSentAlert
{
    [self jsq_playSoundFromJSQMessagesBundleWithName:kJSQMessageSentSoundName asAlert:YES];
}

#pragma mark - Private

+ (void)jsq_playSoundFromJSQMessagesBundleWithName:(NSString *)soundName asAlert:(BOOL)asAlert
{
    //  save sound player original bundle
    NSString *originalPlayerBundleIdentifier = [JSQSystemSoundPlayer sharedPlayer].bundle.bundleIdentifier;
    
    //  search for sounds in this library's bundle
    [JSQSystemSoundPlayer sharedPlayer].bundle = [NSBundle bundleForClass:[JSQMessagesViewController class]];
    
    NSString *fileName = [NSString stringWithFormat:@"JSQMessagesAssets.bundle/Sounds/%@", soundName];
    
    if (asAlert) {
        [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithFilename:fileName fileExtension:kJSQSystemSoundTypeAIFF];
    }
    else {
        [[JSQSystemSoundPlayer sharedPlayer] playSoundWithFilename:fileName fileExtension:kJSQSystemSoundTypeAIFF];
    }
    
    //  restore original bundle
    [JSQSystemSoundPlayer sharedPlayer].bundle = [NSBundle bundleWithIdentifier:originalPlayerBundleIdentifier];
}

@end
