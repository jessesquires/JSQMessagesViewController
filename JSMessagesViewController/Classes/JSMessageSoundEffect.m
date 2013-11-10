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

@interface JSMessageSoundEffect ()

+ (void)playSoundWithName:(NSString *)name type:(NSString *)type;

@end



@implementation JSMessageSoundEffect

+ (void)playSoundWithName:(NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &sound);
        AudioServicesPlaySystemSound(sound);
    }
    else {
        NSLog(@"Error: audio file not found at path: %@", path);
    }
}

+ (void)playMessageReceivedSound
{
    [JSMessageSoundEffect playSoundWithName:@"message-received" type:@"aiff"];
}

+ (void)playMessageSentSound
{
    [JSMessageSoundEffect playSoundWithName:@"message-sent" type:@"aiff"];
}

@end