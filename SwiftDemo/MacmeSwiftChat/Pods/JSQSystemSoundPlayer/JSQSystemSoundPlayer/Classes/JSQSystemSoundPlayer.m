//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQSystemSoundPlayer
//
//
//  GitHub
//  https://github.com/jessesquires/JSQSystemSoundPlayer
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQSystemSoundPlayer.h"

#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>


static NSString * const kJSQSystemSoundPlayerUserDefaultsKey = @"kJSQSystemSoundPlayerUserDefaultsKey";

NSString * const kJSQSystemSoundTypeCAF = @"caf";
NSString * const kJSQSystemSoundTypeAIF = @"aif";
NSString * const kJSQSystemSoundTypeAIFF = @"aiff";
NSString * const kJSQSystemSoundTypeWAV = @"wav";

@interface JSQSystemSoundPlayer ()

@property (strong, nonatomic) NSMutableDictionary *sounds;
@property (strong, nonatomic) NSMutableDictionary *completionBlocks;

- (void)playSoundWithName:(NSString *)filename
                extension:(NSString *)extension
                  isAlert:(BOOL)isAlert
          completionBlock:(JSQSystemSoundPlayerCompletionBlock)completionBlock;

- (BOOL)readSoundPlayerOnFromUserDefaults;

- (NSData *)dataWithSoundID:(SystemSoundID)soundID;
- (SystemSoundID)soundIDFromData:(NSData *)data;

- (SystemSoundID)soundIDForFilename:(NSString *)filenameKey;
- (void)addSoundIDForAudioFileWithName:(NSString *)filename
                             extension:(NSString *)extension;

- (JSQSystemSoundPlayerCompletionBlock)completionBlockForSoundID:(SystemSoundID)soundID;
- (void)addCompletionBlock:(JSQSystemSoundPlayerCompletionBlock)block
                 toSoundID:(SystemSoundID)soundID;
- (void)removeCompletionBlockForSoundID:(SystemSoundID)soundID;

- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)extension;

- (void)unloadSoundIDs;
- (void)unloadSoundIDForFileNamed:(NSString *)filename;

- (void)logError:(OSStatus)error withMessage:(NSString *)message;

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification;

@end



static void systemServicesSoundCompletion(SystemSoundID  soundID, void *data)
{
    JSQSystemSoundPlayer *player = [JSQSystemSoundPlayer sharedPlayer];
    
    JSQSystemSoundPlayerCompletionBlock block = [player completionBlockForSoundID:soundID];
    if (block) {
        block();
        [player removeCompletionBlockForSoundID:soundID];
    }
}



@implementation JSQSystemSoundPlayer

#pragma mark - Init

+ (JSQSystemSoundPlayer *)sharedPlayer
{
    static JSQSystemSoundPlayer *sharedPlayer;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPlayer = [[JSQSystemSoundPlayer alloc] init];
    });
    
    return sharedPlayer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bundle = [NSBundle mainBundle];
        _on = [self readSoundPlayerOnFromUserDefaults];
        _sounds = [[NSMutableDictionary alloc] init];
        _completionBlocks = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarningNotification:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [self unloadSoundIDs];
    _sounds = nil;
    _completionBlocks = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil];
}

#pragma mark - Playing sounds

- (void)playSoundWithName:(NSString *)filename
                extension:(NSString *)extension
                  isAlert:(BOOL)isAlert
          completionBlock:(JSQSystemSoundPlayerCompletionBlock)completionBlock
{
    if (!self.on) {
        return;
    }
    
    if (!filename || !extension) {
        return;
    }
    
    if (![self.sounds objectForKey:filename]) {
        [self addSoundIDForAudioFileWithName:filename extension:extension];
    }
    
    SystemSoundID soundID = [self soundIDForFilename:filename];
    if (soundID) {
        if (completionBlock) {
            OSStatus error = AudioServicesAddSystemSoundCompletion(soundID,
                                                                   NULL,
                                                                   NULL,
                                                                   systemServicesSoundCompletion,
                                                                   NULL);
            
            if (error) {
                [self logError:error withMessage:@"Warning! Completion block could not be added to SystemSoundID."];
            }
            else {
                [self addCompletionBlock:completionBlock toSoundID:soundID];
            }
        }
        
        if (isAlert) {
            AudioServicesPlayAlertSound(soundID);
        }
        else {
            AudioServicesPlaySystemSound(soundID);
        }
    }
}

- (BOOL)readSoundPlayerOnFromUserDefaults
{
    NSNumber *setting = [[NSUserDefaults standardUserDefaults] objectForKey:kJSQSystemSoundPlayerUserDefaultsKey];
    
    if (!setting) {
        [self toggleSoundPlayerOn:YES];
        return YES;
    }
    
    return [setting boolValue];
}

#pragma mark - Public API

- (void)toggleSoundPlayerOn:(BOOL)on
{
    _on = on;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:on] forKey:kJSQSystemSoundPlayerUserDefaultsKey];
    [userDefaults synchronize];
    
    if (!on) {
        [self stopAllSounds];
    }
}

- (void)playSoundWithFilename:(NSString *)filename fileExtension:(NSString *)extension
{
    [self playSoundWithFilename:filename
                  fileExtension:extension
                     completion:nil];
}

- (void)playSoundWithFilename:(NSString *)filename
                fileExtension:(NSString *)extension
                   completion:(JSQSystemSoundPlayerCompletionBlock)completionBlock
{
    [self playSoundWithName:filename
                  extension:extension
                    isAlert:NO
            completionBlock:completionBlock];
}

- (void)playAlertSoundWithFilename:(NSString *)filename
                     fileExtension:(NSString *)extension
                        completion:(JSQSystemSoundPlayerCompletionBlock)completionBlock
{
    [self playSoundWithName:filename
                  extension:extension
                    isAlert:YES
            completionBlock:completionBlock];
}

- (void)playAlertSoundWithFilename:(NSString *)filename fileExtension:(NSString *)extension
{
    [self playAlertSoundWithFilename:filename
                       fileExtension:extension
                          completion:nil];
}

- (void)playVibrateSound
{
    if (self.on) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

- (void)stopAllSounds
{
    [self unloadSoundIDs];
}

- (void)stopSoundWithFilename:(NSString *)filename
{
    SystemSoundID soundID = [self soundIDForFilename:filename];
    NSData *data = [self dataWithSoundID:soundID];
    
    [self unloadSoundIDForFileNamed:filename];
    
    [_sounds removeObjectForKey:filename];
    [_completionBlocks removeObjectForKey:data];
}

- (void)preloadSoundWithFilename:(NSString *)filename fileExtension:(NSString *)extension
{
    if (![self.sounds objectForKey:filename]) {
        [self addSoundIDForAudioFileWithName:filename extension:extension];
    }
}

#pragma mark - Sound data

- (NSData *)dataWithSoundID:(SystemSoundID)soundID
{
    return [NSData dataWithBytes:&soundID length:sizeof(SystemSoundID)];
}

- (SystemSoundID)soundIDFromData:(NSData *)data
{
    if (data == nil) {
        return 0;
    }
    
    SystemSoundID soundID;
    [data getBytes:&soundID length:sizeof(SystemSoundID)];
    return soundID;
}

#pragma mark - Sound files

- (SystemSoundID)soundIDForFilename:(NSString *)filenameKey
{
    NSData *soundData = [self.sounds objectForKey:filenameKey];
    return [self soundIDFromData:soundData];
}

- (void)addSoundIDForAudioFileWithName:(NSString *)filename
                             extension:(NSString *)extension
{
    SystemSoundID soundID = [self createSoundIDWithName:filename
                                              extension:extension];
    if (soundID) {
        NSData *data = [self dataWithSoundID:soundID];
        [self.sounds setObject:data forKey:filename];
    }
}

#pragma mark - Sound completion blocks

- (JSQSystemSoundPlayerCompletionBlock)completionBlockForSoundID:(SystemSoundID)soundID
{
    NSData *data = [self dataWithSoundID:soundID];
    return [self.completionBlocks objectForKey:data];
}

- (void)addCompletionBlock:(JSQSystemSoundPlayerCompletionBlock)block
                 toSoundID:(SystemSoundID)soundID
{
    NSData *data = [self dataWithSoundID:soundID];
    [self.completionBlocks setObject:block forKey:data];
}

- (void)removeCompletionBlockForSoundID:(SystemSoundID)soundID
{
    NSData *key = [self dataWithSoundID:soundID];
    [self.completionBlocks removeObjectForKey:key];
    AudioServicesRemoveSystemSoundCompletion(soundID);
}

#pragma mark - Managing sounds

- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)extension
{
    NSURL *fileURL = [self.bundle URLForResource:filename withExtension:extension];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
        SystemSoundID soundID;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &soundID);
        
        if (error) {
            [self logError:error withMessage:@"Warning! SystemSoundID could not be created."];
            return 0;
        }
        else {
            return soundID;
        }
    }
    
    NSLog(@"[%@] Error: audio file not found at URL: %@", [self class], fileURL);
    return 0;
}

- (void)unloadSoundIDs
{
    for(NSString *eachFilename in [_sounds allKeys]) {
        [self unloadSoundIDForFileNamed:eachFilename];
    }
    
    [_sounds removeAllObjects];
    [_completionBlocks removeAllObjects];
}

- (void)unloadSoundIDForFileNamed:(NSString *)filename
{
    SystemSoundID soundID = [self soundIDForFilename:filename];
    
    if (soundID) {
        AudioServicesRemoveSystemSoundCompletion(soundID);
        
        OSStatus error = AudioServicesDisposeSystemSoundID(soundID);
        if (error) {
            [self logError:error withMessage:@"Warning! SystemSoundID could not be disposed."];
        }
    }
}

- (void)logError:(OSStatus)error withMessage:(NSString *)message
{
    NSString *errorMessage = nil;
    
    switch (error) {
        case kAudioServicesUnsupportedPropertyError:
            errorMessage = @"The property is not supported.";
            break;
        case kAudioServicesBadPropertySizeError:
            errorMessage = @"The size of the property data was not correct.";
            break;
        case kAudioServicesBadSpecifierSizeError:
            errorMessage = @"The size of the specifier data was not correct.";
            break;
        case kAudioServicesSystemSoundUnspecifiedError:
            errorMessage = @"An unspecified error has occurred.";
            break;
        case kAudioServicesSystemSoundClientTimedOutError:
            errorMessage = @"System sound client message timed out.";
            break;
    }
    
    NSLog(@"[%@] %@ Error: (code %d) %@", [self class], message, (int)error, errorMessage);
}

#pragma mark - Notifications

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification
{
    [self unloadSoundIDs];
}

@end
