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

#import "JSQMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"


@interface JSQMediaItem ()

@property (strong, nonatomic) UIView *cachedPlaceholderView;

@end


@implementation JSQMediaItem

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithMaskAsOutgoing:YES];
}

- (instancetype)initWithMaskAsOutgoing:(BOOL)maskAsOutgoing
{
    self = [super init];
    if (self) {
        _appliesMediaViewMaskAsOutgoing = maskAsOutgoing;
        _cachedPlaceholderView = nil;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarningNotification:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    _appliesMediaViewMaskAsOutgoing = appliesMediaViewMaskAsOutgoing;
    _cachedPlaceholderView = nil;
}

- (void)clearCachedMediaViews
{
    _cachedPlaceholderView = nil;
}

#pragma mark - Notifications

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification
{
    [self clearCachedMediaViews];
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
    return nil;
}

+ (void)addLabelView:(UIView *)labelView toMediaView:(UIView *)mediaView blurredBackground:(BOOL)blurred
{
    CGRect effectFrame = mediaView.bounds;
    effectFrame.origin.y = effectFrame.size.height - labelView.frame.size.height;
    effectFrame.size.height = labelView.frame.size.height;
    
    // add effect to an effect view
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = effectFrame;
    [effectView addSubview:labelView];
    
    // add the effect view to the image view
    [mediaView addSubview:effectView];
}

+ (void)addLabelText:(NSString*)labelText toMediaView:(UIView *)mediaView font:(UIFont*)font insets:(UIEdgeInsets)insets
{
    UIEdgeInsets internalInsets = UIEdgeInsetsMake(4, 8, 8, 6);
    if (! UIEdgeInsetsEqualToEdgeInsets(insets, UIEdgeInsetsZero))
        internalInsets = insets;
    
    CGRect labelFrame = mediaView.bounds;
    labelFrame.size.height = 24;
    UITextView * labelView = [[UITextView alloc] initWithFrame:labelFrame];
    labelView.textContainerInset = internalInsets;
    labelView.backgroundColor = [UIColor clearColor];
    labelView.textColor = [UIColor blackColor];
    labelView.text = labelText;
    if (font) {
        labelView.font = font;
    }
    
    CGSize textSize = [labelView.text sizeWithAttributes:@{NSFontAttributeName:[labelView font]}];
    labelFrame.size.height = textSize.height + internalInsets.top + internalInsets.bottom;
    labelView.frame = labelFrame;
    
    [self addLabelView:labelView toMediaView:mediaView blurredBackground:YES];
}

- (CGSize)mediaViewDisplaySize
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return CGSizeMake(315.0f, 225.0f);
    }
    
    return CGSizeMake(210.0f, 150.0f);
}

- (UIView *)mediaPlaceholderView
{
    if (self.cachedPlaceholderView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIView *view = [JSQMessagesMediaPlaceholderView viewWithActivityIndicator];
        view.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:view isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedPlaceholderView = view;
    }
    
    return self.cachedPlaceholderView;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    JSQMediaItem *item = (JSQMediaItem *)object;
    
    return self.appliesMediaViewMaskAsOutgoing == item.appliesMediaViewMaskAsOutgoing;
}

- (NSUInteger)hash
{
    return [NSNumber numberWithBool:self.appliesMediaViewMaskAsOutgoing].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: appliesMediaViewMaskAsOutgoing=%@>",
            [self class], @(self.appliesMediaViewMaskAsOutgoing)];
}

- (id)debugQuickLookObject
{
    return [self mediaView] ?: [self mediaPlaceholderView];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _appliesMediaViewMaskAsOutgoing = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(appliesMediaViewMaskAsOutgoing))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:self.appliesMediaViewMaskAsOutgoing forKey:NSStringFromSelector(@selector(appliesMediaViewMaskAsOutgoing))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithMaskAsOutgoing:self.appliesMediaViewMaskAsOutgoing];
}

@end
