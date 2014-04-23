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
//
//
//  Ideas for keyboard controller taken from Daniel Amitay
//  DAKeyboardControl
//
//  The MIT License
//  Copyright (c) 2012 Daniel Amitay
//  https://github.com/danielamitay/DAKeyboardControl
//

#import "JSQMessagesKeyboardController.h"

static void * kJSQMessagesKeyboardControllerKeyValueObservingContext = &kJSQMessagesKeyboardControllerKeyValueObservingContext;

typedef void (^JSQAnimationCompletionBlock)(BOOL finished);



@interface JSQMessagesKeyboardController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView *keyboardView;

- (void)jsq_registerForNotifications;
- (void)jsq_unregisterForNotifications;

- (void)jsq_didReceiveKeyboardDidShowNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardWillChangeFrameNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardDidChangeFrameNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardDidHideNotification:(NSNotification *)notification;
- (void)jsq_handleKeyboardNotification:(NSNotification *)notification completion:(JSQAnimationCompletionBlock)completion;

- (void)jsq_setKeyboardViewHidden:(BOOL)hidden;

- (void)jsq_removeKeyboardFrameObserver;

- (void)jsq_handlePanGestureRecognizer:(UIPanGestureRecognizer *)pan;

@end



@implementation JSQMessagesKeyboardController

#pragma mark - Initialization

- (instancetype)initWithTextView:(UITextView *)textView
                     contextView:(UIView *)contextView
            panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
                        delegate:(id<JSQMessagesKeyboardControllerDelegate>)delegate

{
    NSAssert(textView, @"ERROR: textView must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(contextView, @"ERROR: contextView must not be nil: %s", __PRETTY_FUNCTION__);
    NSAssert(panGestureRecognizer, @"ERROR: panGestureRecognizer must not be nil: %s", __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self) {
        _textView = textView;
        _contextView = contextView;
        _panGestureRecognizer = panGestureRecognizer;
        _delegate = delegate;
    }
    return self;
}

- (void)dealloc
{
    [self jsq_removeKeyboardFrameObserver];
    [self jsq_unregisterForNotifications];
    _textView = nil;
    _contextView = nil;
    _panGestureRecognizer = nil;
    _delegate = nil;
    _keyboardView = nil;
}

#pragma mark - Setters

- (void)setKeyboardView:(UIView *)keyboardView
{
    if (_keyboardView) {
        [self jsq_removeKeyboardFrameObserver];
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
}

- (void)endListeningForKeyboard
{
    self.textView.inputAccessoryView = nil;
    [self jsq_unregisterForNotifications];
}

#pragma mark - Notifications

- (void)jsq_registerForNotifications
{
    [self jsq_unregisterForNotifications];
    
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

- (void)jsq_unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)jsq_didReceiveKeyboardDidShowNotification:(NSNotification *)notification
{
    self.keyboardView = self.textView.inputAccessoryView.superview;
    [self jsq_setKeyboardViewHidden:NO];
    
    [self jsq_handleKeyboardNotification:notification completion:^(BOOL finished) {
        [self.panGestureRecognizer addTarget:self action:@selector(jsq_handlePanGestureRecognizer:)];
    }];
}

- (void)jsq_didReceiveKeyboardWillChangeFrameNotification:(NSNotification *)notification
{
    [self jsq_handleKeyboardNotification:notification completion:nil];
}

- (void)jsq_didReceiveKeyboardDidChangeFrameNotification:(NSNotification *)notification
{
    [self jsq_setKeyboardViewHidden:NO];
    
    [self jsq_handleKeyboardNotification:notification completion:nil];
}

- (void)jsq_didReceiveKeyboardDidHideNotification:(NSNotification *)notification
{
    self.keyboardView = nil;
    
    [self jsq_handleKeyboardNotification:notification completion:^(BOOL finished) {
        [self.panGestureRecognizer removeTarget:self action:NULL];
        
        [self jsq_setKeyboardViewHidden:YES];
        [self.textView resignFirstResponder];
    }];
}

- (void)jsq_handleKeyboardNotification:(NSNotification *)notification completion:(JSQAnimationCompletionBlock)completion
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
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

- (void)jsq_setKeyboardViewHidden:(BOOL)hidden
{
    self.keyboardView.hidden = hidden;
    self.keyboardView.userInteractionEnabled = !hidden;
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

- (void)jsq_removeKeyboardFrameObserver
{
    @try {
        [_keyboardView removeObserver:self
                           forKeyPath:NSStringFromSelector(@selector(frame))
                              context:kJSQMessagesKeyboardControllerKeyValueObservingContext];
    }
    @catch (NSException * __unused exception) { }
}

#pragma mark - Pan gesture recognizer

- (void)jsq_handlePanGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    CGPoint touch = [pan locationInView:nil];
    
    CGFloat contextViewHeight = CGRectGetHeight(self.contextView.frame);
    CGFloat keyboardViewHeight = CGRectGetHeight(self.keyboardView.frame);
    CGFloat dragThresholdY = (contextViewHeight - keyboardViewHeight - self.keyboardTriggerPoint.y);
    
    CGRect newKeyboardViewFrame = self.keyboardView.frame;
    
    BOOL userIsDraggingNearThresholdForDismissing = (touch.y > dragThresholdY);
    
    self.keyboardView.userInteractionEnabled = !userIsDraggingNearThresholdForDismissing;
    
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
        {
            newKeyboardViewFrame.origin.y = touch.y + self.keyboardTriggerPoint.y;
            
            //  bound frame between bottom of view and height of keyboard
            newKeyboardViewFrame.origin.y = MIN(newKeyboardViewFrame.origin.y, contextViewHeight);
            newKeyboardViewFrame.origin.y = MAX(newKeyboardViewFrame.origin.y, contextViewHeight - keyboardViewHeight);
            
            if (CGRectGetMinY(newKeyboardViewFrame) == CGRectGetMinY(self.keyboardView.frame)) {
                return;
            }
            
            [UIView animateWithDuration:0.0
                                  delay:0.0
                                options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionNone
                             animations:^{
                                 self.keyboardView.frame = newKeyboardViewFrame;
                             }
                             completion:nil];
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            BOOL keyboardViewIsHidden = (CGRectGetMinY(self.keyboardView.frame) >= CGRectGetMaxY([UIScreen mainScreen].bounds));
            if (keyboardViewIsHidden) {
                return;
            }
            
            CGPoint velocity = [pan velocityInView:self.contextView];
            BOOL userIsScrollingDown = (velocity.y > 0.0f);
            BOOL shouldHide = (userIsScrollingDown && userIsDraggingNearThresholdForDismissing);
            
            newKeyboardViewFrame.origin.y = shouldHide ? contextViewHeight : (contextViewHeight - keyboardViewHeight);
            
            [UIView animateWithDuration:0.25
                                  delay:0.0
                                options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.keyboardView.frame = newKeyboardViewFrame;
                             }
                             completion:^(BOOL finished) {
                                 self.keyboardView.userInteractionEnabled = !shouldHide;
                                 
                                 if (shouldHide) {
                                     [self jsq_setKeyboardViewHidden:YES];
                                     [self jsq_removeKeyboardFrameObserver];
                                     [self.textView resignFirstResponder];
                                 }
                             }];
        }
            break;
            
        default:
            break;
    }
}

@end
