//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

static NSString * const kJSQMessageReceivedSoundName = @"message_received";
static NSString * const kJSQMessageSentSoundName = @"message_sent";


@implementation JSQSystemSoundPlayer (JSQMessages)

+ (void)jsq_playMessageReceivedSound
{
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:kJSQMessageReceivedSoundName
                                                 extension:kJSQSystemSoundTypeAIFF];
}

+ (void)jsq_playMessageReceivedAlert
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:kJSQMessageReceivedSoundName
                                                      extension:kJSQSystemSoundTypeAIFF];
}

+ (void)jsq_playMessageSentSound
{
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:kJSQMessageSentSoundName
                                                 extension:kJSQSystemSoundTypeAIFF];
}

+ (void)jsq_playMessageSentAlert
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:kJSQMessageSentSoundName
                                                      extension:kJSQSystemSoundTypeAIFF];
}

@end
