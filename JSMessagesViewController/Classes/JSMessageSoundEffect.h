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

#import <Foundation/Foundation.h>

@interface JSMessageSoundEffect : NSObject

+ (void)playMessageReceivedSound;

+ (void)playMessageReceivedAlert;

+ (void)playMessageSentSound;

+ (void)playMessageSentAlert;

@end