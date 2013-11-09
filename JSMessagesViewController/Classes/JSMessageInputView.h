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

#import <UIKit/UIKit.h>
#import "JSMessageTextView.h"

@interface JSMessageInputView : UIImageView

@property (strong, nonatomic) JSMessageTextView *textView;
@property (strong, nonatomic) UIButton *sendButton;

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
             textViewDelegate:(id<UITextViewDelegate>)delegate
             keyboardDelegate:(id<JSDismissiveTextViewDelegate>)keyboardDelegate
         panGestureRecognizer:(UIPanGestureRecognizer *)pan;

#pragma mark - Message input view

- (void)adjustTextViewHeightBy:(CGFloat)changeInHeight;

+ (CGFloat)textViewLineHeight;

+ (CGFloat)maxLines;

+ (CGFloat)maxHeight;

@end