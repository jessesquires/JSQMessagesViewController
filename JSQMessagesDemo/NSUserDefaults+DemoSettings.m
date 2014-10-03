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

static NSString * const kSettingExtraMessages = @"kSettingExtraMessages";
static NSString * const kSettingLongMessage = @"kSettingLongMessage";
static NSString * const kSettingSpringiness = @"kSettingSpringiness";


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

+ (void)saveSpringinessSetting:(BOOL)value
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kSettingSpringiness];
}

+ (BOOL)springinessSetting
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSettingSpringiness];
}

@end
