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

@class JSQHTMLMessageView;
@class JSQMessage;


/**
 *  The JSQHTMLMessageViewDelegate is pretty much just a wrapper around the UIWebView delegate. The UIWebView
 *  delegate is used internally and therefore the webView.delegate property should not be set. Use the webDelegate
 *  property instead in order to access these methods.
 */
@protocol JSQHTMLMessageViewDelegate <NSObject>

@optional

/**
 *  See the UIWebViewDelegate for details.
 */
- (BOOL)messageView:(JSQHTMLMessageView *)view shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

/**
 *  See the UIWebViewDelegate for details.
 */
- (void)messageViewDidStartLoad:(JSQHTMLMessageView *)view;

/**
 *  See the UIWebViewDelegate for details.
 */
- (void)messageViewDidFinishLoad:(JSQHTMLMessageView *)view;

/**
 *  See the UIWebViewDelegate for details.
 */
- (void)messageView:(JSQHTMLMessageView *)view didFailLoadWithError:(NSError *)error;

@end

/**
 *  Allows HTML to be included inside a message bubble. The web view does not (and should not) allow for user interactions. Therefore, links and other
 *  user actions are not enabled. If complex layouts and user interactions are required, look towards a subclass of `JSQCustomMediaView`.
 *  
 *  To load HTML in the view, call one of the UIWebView load methods on the `webView` property
 *  (loadData:MIMEType:textEncodingName:baseURL:, loadHTMLString:baseURL:, or loadRequest).
 */
@interface JSQHTMLMessageView : JSQCustomMediaView

/**
 *
 *  @discussion Do not set the delegate on the webView! If you need access to the webView delegate, set the webDelegate property.
 */
@property (nonatomic, readonly) UIWebView *webView;

/**
 *  Set this delegate to gain access to the UIWebView delegate callbacks.
 */
@property (nonatomic, assign) id<JSQHTMLMessageViewDelegate> webDelegate;

@end
