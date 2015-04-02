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
//
//  Ideas for keyboard controller taken from Daniel Amitay
//  DAKeyboardControl
//  https://github.com/danielamitay/DAKeyboardControl
//

#import "JSQMessagesKeyboardController.h"

#import "UIDevice+JSQMessages.h"


NSString * const JSQMessagesKeyboardControllerNotificationKeyboardDidChangeFrame = @"JSQMessagesKeyboardControllerNotificationKeyboardDidChangeFrame";
NSString * const JSQMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame = @"JSQMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame";

static void * kJSQMessagesKeyboardControllerKeyValueObservingContext = &kJSQMessagesKeyboardControllerKeyValueObservingContext;

typedef void (^JSQAnimationCompletionBlock)(BOOL finished);



@interface JSQMessagesKeyboardController () <UIGestureRecognizerDelegate>

@property (assign, nonatomic) BOOL jsq_isObserving;

@property (assign, nonatomic) JSQMessagesKeyboardState keyboardState;
@property (strong, nonatomic) UIView *keyboardView;
@property (assign, nonatomic) CGRect currentKeyboardFrame;

- (void)jsq_registerForNotifications;
- (void)jsq_unregisterForNotifications;

- (void)jsq_didReceiveKeyboardNotification:(NSNotification *)notification;
- (void)jsq_handleKeyboardNotification:(NSNotification *)notification completion:(JSQAnimationCompletionBlock)completion;

- (void)jsq_setKeyboardViewHidden:(BOOL)hidden;
- (void)jsq_notifyKeyboardFrameNotificationForFrame:(CGRect)frame;
- (void)jsq_resetKeyboardAndTextView;
- (void)jsq_updateKeyboardState;

- (NSArray *)jsq_observedLayerKeyPaths;
- (void)jsq_addKeyboardObserver;
- (void)jsq_removeKeyboardObserver;

- (void)jsq_handlePanGestureRecognizer:(UIPanGestureRecognizer *)pan;

@end



@implementation JSQMessagesKeyboardController

#pragma mark - Initialization

- (instancetype)initWithTextView:(UITextView *)textView
                     contextView:(UIView *)contextView
            panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
                        delegate:(id<JSQMessagesKeyboardControllerDelegate>)delegate

{
    NSParameterAssert(textView != nil);
    NSParameterAssert(contextView != nil);
    NSParameterAssert(panGestureRecognizer != nil);

    self = [super init];
    if (self) {
        _textView = textView;
        _contextView = contextView;
        _panGestureRecognizer = panGestureRecognizer;
        _delegate = delegate;
        _jsq_isObserving = NO;
    }
    return self;
}

- (void)dealloc
{
    [self jsq_removeKeyboardObserver];
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
    if (keyboardView == _keyboardView) {
        return;
    }
    
    if (_keyboardView) {
        [self jsq_removeKeyboardObserver];
    }

    _keyboardView = keyboardView;
    self.currentKeyboardFrame = keyboardView? keyboardView.frame: CGRectNull;
    
    if (_keyboardView) {
        [self jsq_addKeyboardObserver];
    }
}

#pragma mark - Getters

- (BOOL)keyboardIsVisible
{
    return self.keyboardState == JSQMessagesKeyboardStateDocked || self.keyboardState == JSQMessagesKeyboardStateUndocked;
}

#pragma mark - Keyboard controller

- (void)beginListeningForKeyboard
{
    if (self.keyboardState != JSQMessagesKeyboardStateUnknown) {
        // already listening
        return;
    }
    
    if (self.textView.inputAccessoryView == nil) {
        self.textView.inputAccessoryView = [[UIView alloc] init];
    }

    [self jsq_registerForNotifications];
    [self jsq_updateKeyboardState];
}

- (void)endListeningForKeyboard
{
    if (self.keyboardState == JSQMessagesKeyboardStateUnknown) {
        return;
    }
    
    [self jsq_unregisterForNotifications];

    [self jsq_setKeyboardViewHidden:NO];
    self.keyboardView = nil;
    self.keyboardState = JSQMessagesKeyboardStateUnknown;
}

#pragma mark - Notifications

- (void)jsq_registerForNotifications
{
    [self jsq_unregisterForNotifications];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    NSArray *notificationNames = @[
        UIKeyboardDidShowNotification,
        UIKeyboardDidHideNotification,
        UIKeyboardWillChangeFrameNotification,
        UIKeyboardDidChangeFrameNotification,
    ];
    
    for (NSString *name in notificationNames) {
        [nc addObserver:self
               selector:@selector(jsq_didReceiveKeyboardNotification:)
                   name:name
                 object:nil];
    }
}

- (void)jsq_unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)jsq_didReceiveKeyboardNotification:(NSNotification *)notification
{
    JSQMessagesKeyboardState prevState = self.keyboardState;
    JSQMessagesKeyboardState nextState = prevState;
    
    if ([notification.name isEqualToString:UIKeyboardDidChangeFrameNotification]) {
        
        [self jsq_setKeyboardViewHidden:NO];
        [self jsq_updateKeyboardState];
        
        nextState = self.keyboardState;
    }
    
    [self jsq_handleKeyboardNotification:notification completion:^(BOOL finished) {

        if (prevState != nextState) {
            
            if (nextState == JSQMessagesKeyboardStateDocked) {
                // enter `JSQMessagesKeyboardStateDocked`
                [self.panGestureRecognizer addTarget:self action:@selector(jsq_handlePanGestureRecognizer:)];
            }
            
            if (prevState == JSQMessagesKeyboardStateDocked) {
                // leave `JSQMessagesKeyboardStateDocked`
                [self.panGestureRecognizer removeTarget:self action:NULL];
            }
        }
    }];
}

- (void)jsq_handleKeyboardNotification:(NSNotification *)notification completion:(JSQAnimationCompletionBlock)completion
{
    NSDictionary *userInfo = [notification userInfo];

    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    if (CGRectIsNull(keyboardEndFrame)) {
        return;
    }

    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);

    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    CGRect keyboardEndFrameConverted = [self.contextView convertRect:keyboardEndFrame fromView:nil];

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:animationCurveOption
                     animations:^{
                         [self jsq_notifyKeyboardFrameNotificationForFrame:keyboardEndFrameConverted];
                     }
                     completion:^(BOOL finished) {
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

#pragma mark - Utilities

- (void)jsq_setKeyboardViewHidden:(BOOL)hidden
{
    self.keyboardView.hidden = hidden;
    self.keyboardView.userInteractionEnabled = !hidden;
}

- (void)jsq_notifyKeyboardFrameNotificationForFrame:(CGRect)frame
{
    [self.delegate keyboardController:self keyboardDidChangeFrame:frame];

    [[NSNotificationCenter defaultCenter] postNotificationName:JSQMessagesKeyboardControllerNotificationKeyboardDidChangeFrame
                                                        object:self
                                                      userInfo:@{ JSQMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame : [NSValue valueWithCGRect:frame] }];
}

- (void)jsq_resetKeyboardAndTextView
{
    [self jsq_setKeyboardViewHidden:YES];
    [self jsq_removeKeyboardObserver];
    [self.textView resignFirstResponder];
}

- (void)jsq_updateKeyboardState
{
    // determine an actual keyboard state
    UIView *keyboardView = self.textView.inputAccessoryView.superview;
    self.keyboardView = keyboardView;
    
    if (!keyboardView) {
        self.keyboardState = JSQMessagesKeyboardStateHidden;
    }
    else if (keyboardView) {
        UIWindow *window = self.textView.window;
        CGRect keyboardRect = keyboardView.bounds;
        CGRect windowRect = [window convertRect:window.bounds toView:keyboardView];
        NSInteger dockedSidesCount =
            (CGRectGetMinX(keyboardRect) == CGRectGetMinX(windowRect)) +
            (CGRectGetMaxX(keyboardRect) == CGRectGetMaxX(windowRect)) +
            (CGRectGetMaxY(keyboardRect) == CGRectGetMaxY(windowRect));
        
        self.keyboardState = (dockedSidesCount < 3)? JSQMessagesKeyboardStateUndocked: JSQMessagesKeyboardStateDocked;
    }
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesKeyboardControllerKeyValueObservingContext) {

        UIView *keyboardView = self.keyboardView;
        if (object == keyboardView.layer || object == keyboardView) {

            CGRect oldKeyboardFrame = self.currentKeyboardFrame;
            CGRect newKeyboardFrame = keyboardView.frame;

            self.currentKeyboardFrame = newKeyboardFrame;
            
            if (CGRectEqualToRect(newKeyboardFrame, oldKeyboardFrame) || CGRectIsNull(newKeyboardFrame)) {
                return;
            }
            
            CGRect keyboardEndFrameConverted = [self.contextView convertRect:newKeyboardFrame fromView:nil];
            [self jsq_notifyKeyboardFrameNotificationForFrame:keyboardEndFrameConverted];
        }
    }
}

- (NSArray *)jsq_observedLayerKeyPaths
{
    static NSArray *keyPaths = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyPaths = @[
            NSStringFromSelector(@selector(bounds)),
            NSStringFromSelector(@selector(transform)),
            NSStringFromSelector(@selector(position)),
            NSStringFromSelector(@selector(zPosition)),
            NSStringFromSelector(@selector(anchorPoint)),
            NSStringFromSelector(@selector(anchorPointZ)),
            NSStringFromSelector(@selector(frame)),
        ];
    });
    
    return keyPaths;
}

- (void)jsq_addKeyboardObserver
{
    if (_jsq_isObserving) {
        return;
    }
    
    void *context = kJSQMessagesKeyboardControllerKeyValueObservingContext;
    [_keyboardView addObserver:self
                    forKeyPath:NSStringFromSelector(@selector(frame))
                       options:0
                       context:context];
    for (NSString *keyPath in [self jsq_observedLayerKeyPaths]) {
        [_keyboardView.layer addObserver:self forKeyPath:keyPath options:0 context:context];
    }

    _jsq_isObserving = YES;
}

- (void)jsq_removeKeyboardObserver
{
    if (!_jsq_isObserving) {
        return;
    }

    void *context = kJSQMessagesKeyboardControllerKeyValueObservingContext;
    [_keyboardView removeObserver:self
                       forKeyPath:NSStringFromSelector(@selector(frame))
                          context:context];
    for (NSString *keyPath in [self jsq_observedLayerKeyPaths]) {
        [_keyboardView.layer removeObserver:self forKeyPath:keyPath context:context];
    }
    _jsq_isObserving = NO;
}

#pragma mark - Pan gesture recognizer

- (void)jsq_handlePanGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    CGPoint touch = [pan locationInView:self.contextView];

    //  system keyboard is added to a new UIWindow, need to operate in window coordinates
    //  also, keyboard always slides from bottom of screen, not the bottom of a view
    CGFloat contextViewWindowHeight = CGRectGetHeight(self.contextView.window.frame);

    if ([UIDevice jsq_isCurrentDeviceBeforeiOS8]) {
        //  handle iOS 7 bug when rotating to landscape
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            contextViewWindowHeight = CGRectGetWidth(self.contextView.window.frame);
        }
    }

    CGFloat keyboardViewHeight = CGRectGetHeight(self.keyboardView.frame);

    CGFloat dragThresholdY = (contextViewWindowHeight - keyboardViewHeight - self.keyboardTriggerPoint.y);

    CGRect newKeyboardViewFrame = self.keyboardView.frame;

    BOOL userIsDraggingNearThresholdForDismissing = (touch.y > dragThresholdY);

    self.keyboardView.userInteractionEnabled = !userIsDraggingNearThresholdForDismissing;

    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
        {
            newKeyboardViewFrame.origin.y = touch.y + self.keyboardTriggerPoint.y;

            //  bound frame between bottom of view and height of keyboard
            newKeyboardViewFrame.origin.y = MIN(newKeyboardViewFrame.origin.y, contextViewWindowHeight);
            newKeyboardViewFrame.origin.y = MAX(newKeyboardViewFrame.origin.y, contextViewWindowHeight - keyboardViewHeight);

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
            BOOL keyboardViewIsHidden = (CGRectGetMinY(self.keyboardView.frame) >= contextViewWindowHeight);
            if (keyboardViewIsHidden) {
                [self jsq_resetKeyboardAndTextView];
                return;
            }

            CGPoint velocity = [pan velocityInView:self.contextView];
            BOOL userIsScrollingDown = (velocity.y > 0.0f);
            BOOL shouldHide = (userIsScrollingDown && userIsDraggingNearThresholdForDismissing);

            newKeyboardViewFrame.origin.y = shouldHide ? contextViewWindowHeight : (contextViewWindowHeight - keyboardViewHeight);

            [UIView animateWithDuration:0.25
                                  delay:0.0
                                options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationCurveEaseOut
                             animations:^{
                                 self.keyboardView.frame = newKeyboardViewFrame;
                             }
                             completion:^(BOOL finished) {
                                 self.keyboardView.userInteractionEnabled = !shouldHide;

                                 if (shouldHide) {
                                     [self jsq_resetKeyboardAndTextView];
                                 }
                             }];
        }
            break;

        default:
            break;
    }
}

@end
