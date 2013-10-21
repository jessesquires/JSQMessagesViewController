//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//  http://www.hexedbits.com
//
//
//  Originally based on work by Sam Soffes
//  https://github.com/soffes
//
//  SSMessagesViewController
//  https://github.com/soffes/ssmessagesviewcontroller
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "JSMessageInputView.h"
#import "JSBubbleView.h"

#import "NSString+JSMessagesView.h"
#import "UIImage+JSMessagesBubble.h"
#import "UIImage+JSMessagesInputBar.h"

#define SEND_BUTTON_WIDTH 78.0f

@interface JSMessageInputView ()

- (void)setup;
- (void)setupTextView;

@end



@implementation JSMessageInputView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
             textViewDelegate:(id<UITextViewDelegate>)delegate
             keyboardDelegate:(id<JSDismissiveTextViewDelegate>)keyboardDelegate
         panGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
        _textView.delegate = delegate;
        _textView.keyboardDelegate = keyboardDelegate;
        _textView.dismissivePanGestureRecognizer = pan;
    }
    return self;
}

- (void)dealloc
{
    _textView = nil;
    _sendButton = nil;
}

- (BOOL)resignFirstResponder
{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}

#pragma mark - Setup

- (void)setup
{
    self.image = [UIImage js_inputBar_iOS6];
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
    self.opaque = YES;
    self.userInteractionEnabled = YES;
    [self setupTextView];
}

- (void)setupTextView
{
    CGFloat width = self.frame.size.width - SEND_BUTTON_WIDTH;
    CGFloat height = [JSMessageInputView textViewLineHeight];
    
    _textView = [[JSMessageTextView  alloc] initWithFrame:CGRectMake(6.0f, 3.0f, width, height)];
    [self addSubview:_textView];
	
    UIImageView *inputFieldBack = [[UIImageView alloc] initWithFrame:CGRectMake(_textView.frame.origin.x - 1.0f,
                                                                                0.0f,
                                                                                _textView.frame.size.width + 2.0f,
                                                                                self.frame.size.height)];
    inputFieldBack.image = [UIImage js_inputField_iOS6];
    inputFieldBack.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    inputFieldBack.backgroundColor = [UIColor clearColor];
    [self addSubview:inputFieldBack];
}

#pragma mark - Setters

- (void)setSendButton:(UIButton *)btn
{
    if(_sendButton)
        [_sendButton removeFromSuperview];
    
    _sendButton = btn;
    [self addSubview:_sendButton];
}

#pragma mark - Message input view

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight
{
    CGRect prevFrame = self.textView.frame;
    
    int numLines = MAX([JSBubbleView numberOfLinesForMessage:self.textView.text],
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
    return 30.0f; // for fontSize 15.0f
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