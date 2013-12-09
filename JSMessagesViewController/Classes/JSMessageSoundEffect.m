//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSMessageSoundEffect.h"
#import <JSQSystemSoundPlayer/JSQSystemSoundPlayer.h>

static NSString * const kJSMessageReceived = @"message-received";
static NSString * const kJSMessageSent = @"message-sent";

@implementation JSMessageSoundEffect

+ (void)playMessageReceivedSound
{
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:kJSMessageReceived
                                                 extension:kJSQSystemSoundTypeAIFF];
}

+ (void)playMessageReceivedAlert
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:kJSMessageReceived
                                                      extension:kJSQSystemSoundTypeAIFF];
}

+ (void)playMessageSentSound
{
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:kJSMessageSent
                                                 extension:kJSQSystemSoundTypeAIFF];
}

+ (void)playMessageSentAlert
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:kJSMessageSent
                                                      extension:kJSQSystemSoundTypeAIFF];
}

@end