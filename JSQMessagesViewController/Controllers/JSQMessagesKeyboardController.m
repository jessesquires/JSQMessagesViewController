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
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQMessagesKeyboardController.h"

#import "UIView+JSQMessages.h"

static void * kJSQMessagesKeyboardControllerKeyValueObservingContext = &kJSQMessagesKeyboardControllerKeyValueObservingContext;

typedef void (^JSQAnimationCompletionBlock)(BOOL finished);



@interface JSQMessagesKeyboardController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *keyboardView;

@end



@implementation JSQMessagesKeyboardController

#pragma mark - Initialization

- (instancetype)initWithTextView:(UITextView *)textView
                   referenceView:(UIView *)referenceView
                        delegate:(id<JSQMessagesKeyboardControllerDelegate>)delegate
{
    self = [super init];
    if (self) {
        _textView = textView;
        _referenceView = referenceView;
        _delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    _textView = nil;
    _referenceView = nil;
    _delegate = nil;
    _keyboardView = nil;
}

#pragma mark - Setters

- (void)setKeyboardView:(UIView *)keyboardView
{
    if (_keyboardView) {
        @try {
            [_keyboardView removeObserver:self
                               forKeyPath:NSStringFromSelector(@selector(frame))
                                  context:kJSQMessagesKeyboardControllerKeyValueObservingContext];
        }
        @catch (NSException *exception) {
            NSLog(@"%s EXCEPTION CAUGHT : %@, %@", __PRETTY_FUNCTION__, exception, [exception userInfo]);
        }
    }
    
    _keyboardView = keyboardView;
    
    if (keyboardView) {
        [_keyboardView addObserver:self
                        forKeyPath:NSStringFromSelector(@selector(frame))
                           options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
                           context:kJSQMessagesKeyboardControllerKeyValueObservingContext];
    }
}

#pragma mark - Keyboard controller

- (void)beginListeningForKeyboard
{
    self.textView.inputAccessoryView = [[UIView alloc] init];
    [self jsq_registerForNotifications];
    
    // todo: add pan if text == firstResponder ?
}

- (void)endListeningForKeyboard
{
    self.textView.inputAccessoryView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)jsq_registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveKeyboardDidShowNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveKeyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveKeyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveKeyboardDidHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)jsq_didReceiveKeyboardDidShowNotification:(NSNotification *)notification
{
    self.keyboardView = self.textView.inputAccessoryView.superview;
    [self jsq_handleKeyboardNotification:notification];
}

- (void)jsq_didReceiveKeyboardWillChangeFrameNotification:(NSNotification *)notification
{
    [self jsq_handleKeyboardNotification:notification];
}

- (void)jsq_didReceiveKeyboardDidChangeFrameNotification:(NSNotification *)notification
{
    [self jsq_handleKeyboardNotification:notification];
}

- (void)jsq_didReceiveKeyboardDidHideNotification:(NSNotification *)notification
{
    self.keyboardView = nil;
    [self jsq_handleKeyboardNotification:notification];
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesKeyboardControllerKeyValueObservingContext) {
        
        if (object == self.keyboardView && [keyPath isEqualToString:NSStringFromSelector(@selector(frame))]) {
            
            CGRect oldKeyboardFrameSize = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue];
            CGRect newKeyboardFrameSize = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue];
            
            if (CGRectEqualToRect(newKeyboardFrameSize, oldKeyboardFrameSize)) {
                return;
            }
            
            if (!CGRectIsNull(newKeyboardFrameSize)) {
                [self.delegate keyboardDidChangeFrame:newKeyboardFrameSize];
            }
        }
    }
}

#pragma mark - Keyboard utilities

- (void)jsq_handleKeyboardNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSInteger animationCurveOption = (animationCurve << 16);
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         if (!CGRectIsNull(keyboardEndFrame)) {
                             [self.delegate keyboardDidChangeFrame:keyboardEndFrame];
                         }
                     }
                     completion:nil];
}

@end
