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

#import "JSQHTMLMessageView.h"


@interface JSQHTMLMessageView () <UIWebViewDelegate>
@end

@implementation JSQHTMLMessageView

@synthesize webView = _webView;

- (UIWebView *)webView {
    if (_webView != nil) {
        return _webView;
    }

    _webView = [[UIWebView alloc] initWithFrame:self.bounds];
    _webView.delegate = self;
    _webView.contentMode = UIViewContentModeScaleAspectFill;
    _webView.clipsToBounds = YES;
    _webView.userInteractionEnabled = NO;
    _webView.scrollView.scrollEnabled = NO;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = NO;

    [self addSubview:_webView];
    return _webView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    _webView.translatesAutoresizingMaskIntoConstraints = NO;

    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_webView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)];
    [self addConstraints:constraints];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_webView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)];
    [self addConstraints:constraints];
}

- (CGSize)desiredContentSize {
    if (self.webView == nil || CGSizeEqualToSize(self.webView.frame.size, CGSizeZero)) {
        return [super desiredContentSize];
    }
    CGSize size = self.webView.scrollView.contentSize;
    return CGSizeMake(size.width, size.height);
}

- (void)setPreferredTextColor:(UIColor *)preferredTextColor {
    [super setPreferredTextColor:preferredTextColor];
    [self changeTextColor];
}

- (void)changeFont {

    NSString *script = [NSString stringWithFormat:@"document.body.style.fontFamily = \"-apple-system\""];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
}

- (void)changeTextColor {
    if (self.webView == nil || self.preferredTextColor == nil) {
        return;
    }

    NSString *htmlColor = nil;

    CGFloat red, green, blue, alpha;
    if([self.preferredTextColor getRed:&red green:&green blue:&blue alpha:&alpha]) {
        htmlColor = [NSString stringWithFormat:@"rgb(%i, %i, %i)", (int)red * 255, (int)green * 255, (int)blue * 255];
    }
    else {
        CGFloat white;
        [self.preferredTextColor getWhite:&white alpha:&alpha];
        htmlColor = [NSString stringWithFormat:@"rgb(%i, %i, %i)", (int)white * 255, (int)white * 255, (int)white * 255];
    }

    NSString *script = [NSString stringWithFormat:@"document.body.style.color = \"%@\"; document.body.style.opacity = %f;", htmlColor, alpha];
    [self.webView stringByEvaluatingJavaScriptFromString:script];
}


#pragma mark - UIWebViewDelegate Methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([self.webDelegate respondsToSelector:@selector(messageView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.webDelegate messageView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if ([self.webDelegate respondsToSelector:@selector(messageViewDidStartLoad:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.webDelegate messageViewDidStartLoad:self];
        });
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self changeFont];
    [self changeTextColor];

    if ([self.delegate respondsToSelector:@selector(customMediaView:contentSizeChanged:)]) {
        [self.delegate customMediaView:self contentSizeChanged:self.webView.scrollView.contentSize];
    }

    if ([self.webDelegate respondsToSelector:@selector(messageViewDidFinishLoad:)]) {
        [self.webDelegate messageViewDidFinishLoad:self];
    }

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([self.webDelegate respondsToSelector:@selector(messageView:didFailLoadWithError:)]) {
        [self.webDelegate messageView:self didFailLoadWithError:error];
    }
}



@end
