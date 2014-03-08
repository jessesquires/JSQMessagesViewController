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

#import "JSQSystemSoundPlayer.h"

@interface JSQSystemSoundPlayer (JSQMessages)

/**
 *  Plays the default sound for received messages.
 */
+ (void)playMessageReceivedSound;

/**
 *  Plays the default sound for received messages *as an alert*, invoking device vibration if available.
 */
+ (void)playMessageReceivedAlert;

/**
 *  Plays the default sound for sent messages.
 */
+ (void)playMessageSentSound;

/**
 *  Plays the default sound for sent messages *as an alert*, invoking device vibration if available.
 */
+ (void)playMessageSentAlert;

@end
