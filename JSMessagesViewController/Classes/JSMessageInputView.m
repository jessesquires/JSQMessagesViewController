//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSMessageInputView.h"

#import <QuartzCore/QuartzCore.h>
#import "JSBubbleView.h"
#import "NSString+JSMessagesView.h"
#import "UIColor+JSMessagesView.h"

@interface JSMessageInputView ()

- (void)setup;
- (void)configureInputBarWithStyle:(JSMessageInputViewStyle)style;
- (void)configureSendButtonWithStyle:(JSMessageInputViewStyle)style;

@end



@implementation JSMessageInputView

#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    self.opaque = YES;
    self.userInteractionEnabled = YES;
}

- (void)configureInputBarWithStyle:(JSMessageInputViewStyle)style
{
    CGFloat sendButtonWidth = (style == JSMessageInputViewStyleClassic) ? 78.0f : 64.0f;
    
    CGFloat width = self.frame.size.width - sendButtonWidth;
    CGFloat height = [JSMessageInputView textViewLineHeight];
    
    JSMessageTextView *textView = [[JSMessageTextView  alloc] initWithFrame:CGRectZero];
    [self addSubview:textView];
	_textView = textView;
    
    if(style == JSMessageInputViewStyleClassic) {
        _textView.frame = CGRectMake(6.0f, 3.0f, width, height);
        _textView.backgroundColor = [UIColor whiteColor];
        
        self.image = [[UIImage imageNamed:@"input-bar-background"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)
                                                                                  resizingMode:UIImageResizingModeStretch];
        
        UIImageView *inputFieldBack = [[UIImageView alloc] initWithFrame:CGRectMake(_textView.frame.origin.x - 1.0f,
                                                                                    0.0f,
                                                                                    _textView.frame.size.width + 2.0f,
                                                                                    self.frame.size.height)];
        inputFieldBack.image = [[UIImage imageNamed:@"input-field-cover"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 12.0f, 18.0f, 18.0f)];
        inputFieldBack.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        inputFieldBack.backgroundColor = [UIColor clearColor];
        [self addSubview:inputFieldBack];
    }
    else {
        _textView.frame = CGRectMake(4.0f, 4.5f, width, height);
        _textView.backgroundColor = [UIColor clearColor];
        _textView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
        _textView.layer.borderWidth = 0.65f;
        _textView.layer.cornerRadius = 6.0f;
        
        self.image = [[UIImage imageNamed:@"input-bar-flat"] resizableImageWithCapInsets:UIEdgeInsetsMake(2.0f, 0.0f, 0.0f, 0.0f)
                                                                            resizingMode:UIImageResizingModeStretch];
    }
}

- (void)configureSendButtonWithStyle:(JSMessageInputViewStyle)style
{
    UIButton *sendButton;
    
    if(style == JSMessageInputViewStyleClassic) {
        sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, 13.0f, 0.0f, 13.0f);
        UIImage *sendBack = [[UIImage imageNamed:@"send-button"] resizableImageWithCapInsets:insets];
        UIImage *sendBackHighLighted = [[UIImage imageNamed:@"send-button-pressed"] resizableImageWithCapInsets:insets];
        [sendButton setBackgroundImage:sendBack forState:UIControlStateNormal];
        [sendButton setBackgroundImage:sendBack forState:UIControlStateDisabled];
        [sendButton setBackgroundImage:sendBackHighLighted forState:UIControlStateHighlighted];
        
        UIColor *titleShadow = [UIColor colorWithRed:0.325f green:0.463f blue:0.675f alpha:1.0f];
        [sendButton setTitleShadowColor:titleShadow forState:UIControlStateNormal];
        [sendButton setTitleShadowColor:titleShadow forState:UIControlStateHighlighted];
        sendButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
        
        [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [sendButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
        
        sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    else {
        sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sendButton.backgroundColor = [UIColor clearColor];
        
        [sendButton setTitleColor:[UIColor js_bubbleBlueColor] forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor js_bubbleBlueColor] forState:UIControlStateHighlighted];
        [sendButton setTitleColor:[UIColor js_bubbleLightGrayColor] forState:UIControlStateDisabled];
        
        sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    }
    
    NSString *title = NSLocalizedString(@"Send", nil);
    [sendButton setTitle:title forState:UIControlStateNormal];
    [sendButton setTitle:title forState:UIControlStateHighlighted];
    [sendButton setTitle:title forState:UIControlStateDisabled];
    
    sendButton.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin);
    
    [self setSendButton:sendButton];
}

- (instancetype)initWithFrame:(CGRect)frame
                        style:(JSMessageInputViewStyle)style
                     delegate:(id<UITextViewDelegate, JSDismissiveTextViewDelegate>)delegate
         panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    self = [super initWithFrame:frame];
    if(self) {
        _style = style;
        [self setup];
        [self configureInputBarWithStyle:style];
        [self configureSendButtonWithStyle:style];
        
        _textView.delegate = delegate;
        _textView.keyboardDelegate = delegate;
        _textView.dismissivePanGestureRecognizer = panGestureRecognizer;
    }
    return self;
}

- (void)dealloc
{
    _textView = nil;
    _sendButton = nil;
}

#pragma mark - UIView

- (BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}

#pragma mark - Setters

- (void)setSendButton:(UIButton *)btn
{
    if(_sendButton)
        [_sendButton removeFromSuperview];
    
    if(self.style == JSMessageInputViewStyleClassic) {
        btn.frame = CGRectMake(self.frame.size.width - 65.0f, 8.0f, 59.0f, 26.0f);
    }
    else {
        CGFloat padding = 8.0f;
        btn.frame = CGRectMake(self.textView.frame.origin.x + self.textView.frame.size.width,
                               padding,
                               60.0f,
                               self.textView.frame.size.height - padding);
    }
    
    [self addSubview:btn];
    _sendButton = btn;
}

#pragma mark - Message input view

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight
{
    CGRect prevFrame = self.textView.frame;
    
    NSUInteger numLines = MAX([self.textView numberOfLinesOfText],
                              [self.textView.text js_numberOfLines]);
    
    //  below iOS 7, if you set the text view frame programmatically, the KVO will continue notifying
    //  to avoid that, we are removing the observer before setting the frame and add the observer after setting frame here.
    [self.textView removeObserver:_textView.keyboardDelegate
                       forKeyPath:@"contentSize"];
    
    self.textView.frame = CGRectMake(prevFrame.origin.x,
                                     prevFrame.origin.y,
                                     prevFrame.size.width,
                                     prevFrame.size.height + changeInHeight);
    
    [self.textView addObserver:_textView.keyboardDelegate
                    forKeyPath:@"contentSize"
                       options:NSKeyValueObservingOptionNew
                       context:nil];

    self.textView.contentInset = UIEdgeInsetsMake((numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f,
                                                  (numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f);
    
    // from iOS 7, the content size will be accurate only if the scrolling is enabled.
    self.textView.scrollEnabled = YES;
    
    if(numLines >= 6) {
        CGPoint bottomOffset = CGPointMake(0.0f, self.textView.contentSize.height - self.textView.bounds.size.height);
        [self.textView setContentOffset:bottomOffset animated:YES];
        [self.textView scrollRangeToVisible:NSMakeRange(self.textView.text.length - 2, 1)];
    }
}

+ (CGFloat)textViewLineHeight
{
    return 36.0f; // for fontSize 16.0f
}

+ (CGFloat)maxLines
{
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) ? 4.0f : 8.0f;
}

+ (CGFloat)maxHeight
{
    return ([JSMessageInputView maxLines] + 1.0f) * [JSMessageInputView textViewLineHeight];
}

@end
