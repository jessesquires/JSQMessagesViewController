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
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQSystemSoundPlayer+JSQMessages.h"

static NSString * const kJSQMessageReceivedSoundName = @"message_received";
static NSString * const kJSQMessageSentSoundName = @"message_sent";


@implementation JSQSystemSoundPlayer (JSQMessages)

+ (void)playMessageReceivedSound
{
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:kJSQMessageReceivedSoundName
                                                 extension:kJSQSystemSoundTypeAIFF];
}

+ (void)playMessageReceivedAlert
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:kJSQMessageReceivedSoundName
                                                      extension:kJSQSystemSoundTypeAIFF];
}

+ (void)playMessageSentSound
{
    [[JSQSystemSoundPlayer sharedPlayer] playSoundWithName:kJSQMessageSentSoundName
                                                 extension:kJSQSystemSoundTypeAIFF];
}

+ (void)playMessageSentAlert
{
    [[JSQSystemSoundPlayer sharedPlayer] playAlertSoundWithName:kJSQMessageSentSoundName
                                                      extension:kJSQSystemSoundTypeAIFF];
}

@end
