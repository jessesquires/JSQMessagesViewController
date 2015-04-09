//
//  JSQHTMLMediaItem.m
//  JSQMessages
//
//  Created by Aaron Jubbal on 3/8/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "JSQHTMLMediaItem.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

@interface JSQHTMLMediaItem () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *cachedWebView;
@property (assign, nonatomic) NSUInteger webViewLoadingCount;
@property (nonatomic) CGFloat   webHeight;

@end

@implementation JSQHTMLMediaItem

#pragma mark - Initialization

- (instancetype)initWithHTMLString:(NSString *)htmlString
{
    self = [super init];
    if (self) {
        _webView = nil;
        self.htmlString = [htmlString copy];
        _cachedWebView = nil;
        _webViewLoadingCount = 0;
        _webHeight = 0.f;
    }
    return self;
}

- (void)dealloc
{
    _htmlString = nil;
    _webView = nil;
    _cachedWebView = nil;
}

#pragma mark - Setters

- (void)setHtmlString:(NSString *)htmlString {
    _htmlString = [htmlString copy];
    
    if (!_webView) {
        CGSize size = [self mediaViewDisplaySize];
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        _webView.delegate = self;
        //[JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:_webView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedWebView = _webView;
    }
    [_webView loadHTMLString:htmlString baseURL:nil];
}

- (void)setWebView:(UIWebView *)webView {
    _webView = [webView copy];
    _cachedWebView = nil;
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedWebView = nil;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.webView == nil) {
        return nil;
    }
    
    if (self.cachedWebView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        webView.delegate = self;
        [webView loadHTMLString:self.htmlString baseURL:nil];
        webView.contentMode = UIViewContentModeScaleAspectFill;
        webView.clipsToBounds = YES;
        webView.scrollView.scrollEnabled = NO;
        //[JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:webView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedWebView = webView;
    }
    
    return self.cachedWebView;
}

#pragma mark - NSObject

- (NSUInteger)hash
{
    return super.hash ^ self.webView.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: image=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.webView, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _webView = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(webView))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.webView forKey:NSStringFromSelector(@selector(webView))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQHTMLMediaItem *copy = [[[self class] allocWithZone:zone] initWithHTMLString:self.htmlString];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _webViewLoadingCount++;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _webViewLoadingCount--;
    if (_webViewLoadingCount < 1) {
        // finished loading
        
        NSString *output = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"foo\").offsetHeight;"];
        CGSize size = [self mediaViewDisplaySize];
        self.webHeight = [output floatValue] + 20.f; //20 for some padding
        webView.frame = CGRectMake(0.0f, 0.0f, size.width, self.webHeight);
        self.cachedWebView = webView;
        
        if (self.reloadCallback) {
            self.reloadCallback();
        }
    };
}

- (CGSize)mediaViewDisplaySize
{
    if(self.webHeight <= 0.f) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            return CGSizeMake(355.0f, 225.0f);
        }
        
        return CGSizeMake(250.0f, 150.0f);
    } else {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            return CGSizeMake(355.0f, self.webHeight);
        }
        return CGSizeMake(250.0f, self.webHeight);
    }
    
}

@end
