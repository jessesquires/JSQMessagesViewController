//
//  Created by Ryan Grimm
//  ryan@ryangrimm.com
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

#import "JSQCustomMediaView.h"
#import "JSQCustomMediaItem.h"
#import "JSQMessage.h"

@implementation JSQCustomMediaView

+ (UIEdgeInsets)defaultLayoutMargins {
    return UIEdgeInsetsMake(0, 10, 0, 5);
}

- (instancetype)init {
    self = [super init];
    if (self != nil)
    {
        CGRect rect = CGRectZero;
        rect.size = [self desiredContentSize];
        self.frame = rect;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self != nil)
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if(self != nil)
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.layoutMargins = [JSQCustomMediaView defaultLayoutMargins];
    self.includeMessageBubble = YES;
    _preferredFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void)setPreferredFont:(UIFont *)preferredFont {
    _preferredFont = preferredFont;
    if (self.textPropertiesChangedBlock) {
        self.textPropertiesChangedBlock(self);
    }
}

- (void)setPreferredTextColor:(UIColor *)preferredTextColor {
    _preferredTextColor = preferredTextColor;
    if (self.textPropertiesChangedBlock) {
        self.textPropertiesChangedBlock(self);
    }
}

- (NSUInteger)hash
{
    return arc4random();
}

- (CGSize)desiredContentSize
{
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            return CGSizeMake(355.0f, 100);
        }

        return CGSizeMake(250.0f, 100);
    }

    return self.frame.size;
}

- (JSQMessage *)generateMessageWithSenderId:(NSString *)senderId displayName:(NSString *)displayName
{
    JSQCustomMediaItem *customItem = [[JSQCustomMediaItem alloc] initWithView:self];
    return [JSQMessage messageWithSenderId:senderId displayName:displayName media:customItem];
}

- (JSQMessage *)generateMessageWithSenderId:(NSString *)senderId displayName:(NSString *)displayName date:(NSDate *)date
{
    JSQCustomMediaItem *customItem = [[JSQCustomMediaItem alloc] initWithView:self];
    return [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:displayName date:date media:customItem];
}

@end
