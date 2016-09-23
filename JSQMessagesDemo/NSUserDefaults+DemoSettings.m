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

#import "NSUserDefaults+DemoSettings.h"

static NSString * const kSettingExtraMessages           = @"kSettingExtraMessages";
static NSString * const kSettingLongMessage             = @"kSettingLongMessage";
static NSString * const kSettingEmptyMessages           = @"kSettingEmptyMessages";
static NSString * const kSettingSpringiness             = @"kSettingSpringiness";
static NSString * const kSettingIncomingAvatar          = @"kSettingIncomingAvatar";
static NSString * const kSettingOutgoingAvatar          = @"kSettingOutgoingAvatar";
static NSString * const kSettingAccessoryButtonForMedia = @"kSettingAccessoryButtonForMedia";

@implementation NSUserDefaults (DemoSettings)

+ (void)saveExtraMessagesSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingExtraMessages];
}

+ (BOOL)extraMessagesSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingExtraMessages];
}

+ (void)saveLongMessageSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingLongMessage];
}

+ (BOOL)longMessageSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingLongMessage];
}

+ (void)saveEmptyMessagesSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingEmptyMessages];
}

+ (BOOL)emptyMessagesSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingEmptyMessages];
}

+ (void)saveSpringinessSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingSpringiness];
}

+ (BOOL)springinessSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingSpringiness];
}

+ (void)saveOutgoingAvatarSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingOutgoingAvatar];
}

+ (BOOL)outgoingAvatarSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingOutgoingAvatar];
}

+ (void)saveIncomingAvatarSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingIncomingAvatar];
}

+ (BOOL)incomingAvatarSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingIncomingAvatar];
}

+ (BOOL)accessoryButtonForMediaMessages
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingAccessoryButtonForMedia];
}

+ (void)saveAccessoryButtonForMediaMessages:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingAccessoryButtonForMedia];
}
@end
