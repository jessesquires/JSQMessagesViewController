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

#import "NSBundle+JSQMessages.h"

#import "JSQMessagesViewController.h"

@implementation NSBundle (JSQMessages)

+ (NSBundle *)jsq_messagesBundle
{
    return [NSBundle bundleForClass:[JSQMessagesViewController class]];
}

+ (NSBundle *)jsq_messagesAssetBundle
{
    NSString *bundleResourcePath = [NSBundle jsq_messagesBundle].resourcePath;
    NSString *assetPath = [bundleResourcePath stringByAppendingPathComponent:@"JSQMessagesAssets.bundle"];
    return [NSBundle bundleWithPath:assetPath];
}

+ (NSString *)jsq_localizedStringForKey:(NSString *)key
{
    NSString *value = NSLocalizedStringFromTableInBundle(key, @"JSQMessages", [NSBundle jsq_messagesAssetBundle], nil);
    
    if ([value isEqualToString:key]) {
        // This translation is partial, and the key we're looking up is missing
        // Fall back to the Base localization
        if (![[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"en"]) {
            NSString *baseTranslationPath = [[NSBundle jsq_messagesAssetBundle] pathForResource:@"Base" ofType:@"lproj"];
            NSBundle *baseTranslationBundle = [NSBundle bundleWithPath:baseTranslationPath];
            value = [baseTranslationBundle localizedStringForKey:key value:@"" table:@"JSQMessages"];
        }
    }
    
    return value;
}

@end
