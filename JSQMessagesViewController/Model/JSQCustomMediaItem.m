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
//

#import "JSQCustomMediaItem.h"

@interface JSQCustomMediaItem () <JSQCustomMediaViewDelegate>
- (CGSize)calculateMediaDisplaySizeForView:(JSQCustomMediaView *) view includeLayoutMargins:(BOOL)includeLayoutMargins;
@end

@implementation JSQCustomMediaItem

#pragma mark - Initialization

- (instancetype)initWithView:(JSQCustomMediaView *)view
{
    self = [super init];
    if (self) {
        self.preferredDefaultHeight = 100;
        self.customView = view;
    }
    return self;
}

- (CGSize)calculateMediaDisplaySizeForView:(JSQCustomMediaView *) view includeLayoutMargins:(BOOL)includeLayoutMargins
{
    UIEdgeInsets layoutMargins = UIEdgeInsetsZero;
    CGSize displaySize = CGSizeZero;
    CGSize viewSize = view.frame.size;
    if (view == nil || viewSize.height <= 0 || viewSize.width <= 0) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            displaySize = CGSizeMake(355.0f, self.preferredDefaultHeight);
        }
        else {
            displaySize = CGSizeMake(250.0f, self.preferredDefaultHeight);
        }
        layoutMargins = [JSQCustomMediaView defaultLayoutMargins];
    }
    else {
        displaySize = view.desiredContentSize;
        layoutMargins = view.layoutMargins;
    }

    if (includeLayoutMargins) {
        displaySize.width = displaySize.width + layoutMargins.left + layoutMargins.right;
        displaySize.height = displaySize.height + layoutMargins.top + layoutMargins.bottom;
    }

    return displaySize;
}

#pragma mark - Setters

- (void)setCustomView:(JSQCustomMediaView *)customView
{
    if (customView != nil) {
        _customView = customView;

        CGSize defaultSize = [self calculateMediaDisplaySizeForView:customView includeLayoutMargins:NO];
        customView.frame = CGRectMake(0, 0, defaultSize.width, defaultSize.height);
        customView.delegate = self;
    }
    else {
        _customView.delegate = nil;
    }
}

- (void)customMediaView:(JSQCustomMediaView *)mediaView contentSizeChanged:(CGSize)newSize
{
    CGRect frame = self.customView.frame;
    frame.size = newSize;
    self.customView.frame = frame;

    newSize.width = newSize.width + mediaView.layoutMargins.left + mediaView.layoutMargins.right;
    newSize.height = newSize.height + mediaView.layoutMargins.top + mediaView.layoutMargins.bottom;

    if ([self.delegate respondsToSelector:@selector(customMediaItem:customViewSizeChanged:)]) {
        [self.delegate customMediaItem:self customViewSizeChanged:newSize];
    }
}

- (void)setPreferredTextColor:(UIColor *)preferredTextColor
{
    self.customView.preferredTextColor = preferredTextColor;
}

- (UIColor *)preferredTextColor
{
    return self.customView.preferredTextColor;
}

#pragma mark - JSQMessageMediaData protocol

- (JSQCustomMediaView *)mediaView
{
    return self.customView;
}

- (NSUInteger)mediaHash
{
    return self.customView.hash;
}

- (CGSize)mediaViewDisplaySize
{
    return [self calculateMediaDisplaySizeForView:self.customView includeLayoutMargins:YES];
}


#pragma mark - NSObject

- (NSUInteger)hash
{
    return self.customView.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: customView=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.customView, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.preferredDefaultHeight = [aDecoder decodeFloatForKey:NSStringFromSelector(@selector(preferredDefaultHeight))];
        self.customView = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(customView))];
        self.preferredTextColor = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(preferredTextColor))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.customView forKey:NSStringFromSelector(@selector(customView))];
    [aCoder encodeFloat:self.preferredDefaultHeight forKey:NSStringFromSelector(@selector(preferredDefaultHeight))];
    [aCoder encodeObject:self.preferredTextColor forKey:NSStringFromSelector(@selector(preferredTextColor))];

}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQCustomMediaItem *copy = [[[self class] allocWithZone:zone] initWithView:self.customView];
    copy.delegate = self.delegate;
    copy.preferredDefaultHeight = self.preferredDefaultHeight;
    copy.preferredTextColor = self.preferredTextColor;
    return copy;
}

@end
