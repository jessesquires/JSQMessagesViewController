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
#import "JSBubbleView.h"
#import "NSString+JSMessagesView.h"

#define SEND_BUTTON_WIDTH 78.0f

@interface JSMessageInputView ()

- (void)setup;
- (void)configureWithStyle:(JSMessageInputViewStyle)style;

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

- (void)configureWithStyle:(JSMessageInputViewStyle)style
{
    CGFloat width = self.frame.size.width - SEND_BUTTON_WIDTH;
    CGFloat height = [JSMessageInputView textViewLineHeight];
    
    JSMessageTextView *textView = [[JSMessageTextView  alloc] initWithFrame:CGRectZero];
    [self addSubview:textView];
	_textView = textView;
    
    if(style == JSMessageInputViewStyleFlat) {
        _textView.frame = CGRectMake(4.0f, 4.5f, width, height);
        _textView.backgroundColor = [UIColor clearColor];
        _textView.layer.borderColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
        _textView.layer.borderWidth = 0.65f;
        _textView.layer.cornerRadius = 6.0f;
        
        self.image = [[UIImage imageNamed:@"input-bar-flat"] resizableImageWithCapInsets:UIEdgeInsetsZero
                                                                            resizingMode:UIImageResizingModeStretch];
    }
    else if(style == JSMessageInputViewStyleClassic) {
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
}

- (instancetype)initWithFrame:(CGRect)frame
                        style:(JSMessageInputViewStyle)style
                     delegate:(id<UITextViewDelegate, JSDismissiveTextViewDelegate>)delegate
         panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
        [self configureWithStyle:style];
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
    
    [self addSubview:btn];
    _sendButton = btn;
}

#pragma mark - Message input view

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight
{
    CGRect prevFrame = self.textView.frame;
    
    int numLines = MAX([self.textView numberOfLinesOfText],
                       [self.textView.text js_numberOfLines]);
    
    self.textView.frame = CGRectMake(prevFrame.origin.x,
                                     prevFrame.origin.y,
                                     prevFrame.size.width,
                                     prevFrame.size.height + changeInHeight);
    
    self.textView.contentInset = UIEdgeInsetsMake((numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f,
                                                  (numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f);
    
    self.textView.scrollEnabled = (numLines >= 4);
    
    if(numLines >= 6) {
        CGPoint bottomOffset = CGPointMake(0.0f, self.textView.contentSize.height - self.textView.bounds.size.height);
        [self.textView setContentOffset:bottomOffset animated:YES];
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