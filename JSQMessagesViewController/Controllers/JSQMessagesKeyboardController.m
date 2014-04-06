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

typedef void (^JSQAnimationCompletionBlock)(BOOL finished);


@interface JSQMessagesKeyboardController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIResponder *keyboardActiveInput;
@property (weak, nonatomic) UIView *keyboardActiveView;
@property (assign, nonatomic) CGRect previousKeyboardRect;
@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;

- (void)jsq_handlePanGestureRecognizer:(UIPanGestureRecognizer *)pan;

- (void)jsq_registerForNotifications;
- (void)jsq_didReceiveTextViewTextDidBeginEditingNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardWillShowNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardDidShowNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardWillChangeFrameNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardDidChangeFrameNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardWillHideNotification:(NSNotification *)notification;
- (void)jsq_didReceiveKeyboardDidHideNotification:(NSNotification *)notification;

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
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    _textView = nil;
//    _referenceView = nil;
//    _delegate = nil;
}

#pragma mark - 

- (void)add
{
    if (!self.textView.inputAccessoryView) {
        UIView *nullView = [[UIView alloc] initWithFrame:CGRectZero];
        nullView.backgroundColor = [UIColor clearColor];
        self.textView.inputAccessoryView = nullView;
    }
    
    self.keyboardActiveInput = [self.referenceView jsq_findFirstResponder];
    
    if (self.keyboardActiveInput) {
        self.keyboardActiveView = self.keyboardActiveInput.inputAccessoryView.superview;
        if (self.keyboardActiveView && !self.panGestureRecognizer) {
            [self jsq_addPanGestureRecognizer];
        }
    }
    
    [self jsq_registerForNotifications];
}

- (void)remove
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self jsq_removePanGestureRecognizer];
    
    _textView = nil;
    _referenceView = nil;
    _delegate = nil;
}

#pragma mark - Setters

- (void)setKeyboardActiveView:(UIView *)keyboardActiveView
{
    [_keyboardActiveView removeObserver:self forKeyPath:@"frame"];
    
    _keyboardActiveView = keyboardActiveView;
    
    if (keyboardActiveView) {
        [keyboardActiveView addObserver:self
                             forKeyPath:@"frame"
                                options:0
                                context:NULL];
    }
}

#pragma mark - Actions

- (void)jsq_handlePanGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    
}

#pragma mark - Notifications

- (void)jsq_registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveTextViewTextDidBeginEditingNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:_textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveKeyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
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
                                             selector:@selector(jsq_didReceiveKeyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveKeyboardDidHideNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)jsq_didReceiveTextViewTextDidBeginEditingNotification:(NSNotification *)notification
{
    NSLog(@"NOTIF = %@", notification.name);
    NSLog(@"OBJECT = %@", notification.object);
    
    self.keyboardActiveInput = [notification object];
    
    if (!self.keyboardActiveInput.inputAccessoryView) {
        UITextField *textField = (UITextField *)self.keyboardActiveInput;
        
        if ([textField respondsToSelector:@selector(setInputAccessoryView:)]) {
            UIView *nullView = [[UIView alloc] initWithFrame:CGRectZero];
            nullView.backgroundColor = [UIColor clearColor];
            textField.inputAccessoryView = nullView;
        }
        
        self.keyboardActiveInput = (UIResponder *)textField;
        
        // Force the keyboard active view reset
        [self inputKeyboardDidShow];
    }
}

- (void)jsq_didReceiveKeyboardWillShowNotification:(NSNotification *)notification
{
    NSLog(@"NOTIF = %@", notification.name);
    NSLog(@"OBJECT = %@", notification.object);
    
    self.keyboardActiveView.hidden = NO;
    
    [self jsq_handleKeyboardNotification:notification completion:^(BOOL finished) {
        [self jsq_addPanGestureRecognizer];
    }];
}

- (void)jsq_didReceiveKeyboardDidShowNotification:(NSNotification *)notification
{
    
    NSLog(@"NOTIF = %@", notification.name);
    NSLog(@"OBJECT = %@", notification.object);
    
    [self inputKeyboardDidShow];
}

- (void)jsq_didReceiveKeyboardWillChangeFrameNotification:(NSNotification *)notification
{
    
    NSLog(@"NOTIF = %@", notification.name);
    NSLog(@"OBJECT = %@", notification.object);
    
    [self jsq_handleKeyboardNotification:notification completion:nil];
}

- (void)jsq_didReceiveKeyboardDidChangeFrameNotification:(NSNotification *)notification
{
    
    NSLog(@"NOTIF = %@", notification.name);
    NSLog(@"OBJECT = %@", notification.object);
    
    // nothing
}

- (void)jsq_didReceiveKeyboardWillHideNotification:(NSNotification *)notification
{
    
    NSLog(@"NOTIF = %@", notification.name);
    NSLog(@"OBJECT = %@", notification.object);
    
    [self jsq_handleKeyboardNotification:notification completion:^(BOOL finished) {
        [self jsq_removePanGestureRecognizer];
    }];
}

- (void)jsq_didReceiveKeyboardDidHideNotification:(NSNotification *)notification
{
    
    NSLog(@"NOTIF = %@", notification.name);
    NSLog(@"OBJECT = %@", notification.object);
    
    self.keyboardActiveView.hidden = NO;
    self.keyboardActiveView.userInteractionEnabled = YES;
    self.keyboardActiveView = nil;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"frame"] && object == self.keyboardActiveView) {
        
        CGRect keyboardEndFrameWindow = [[object valueForKeyPath:keyPath] CGRectValue];
        CGRect keyboardEndFrameView = [self.referenceView convertRect:keyboardEndFrameWindow fromView:self.keyboardActiveView.window];
        
        if (CGRectEqualToRect(keyboardEndFrameView, self.previousKeyboardRect)) {
            return;
        }
        
        if (!self.keyboardActiveView.hidden && !CGRectIsNull(keyboardEndFrameView)) {
            [self.delegate keyboardDidChangeFrame:keyboardEndFrameView];
        }
        
        self.previousKeyboardRect = keyboardEndFrameView;
    }
}

#pragma mark - Keyboard utilities

- (void)jsq_handleKeyboardNotification:(NSNotification *)notification completion:(JSQAnimationCompletionBlock)completion
{
    NSDictionary *userInfo = [notification userInfo];
    
    CGRect keyboardEndFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    double animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    NSInteger animationCurveOption = (animationCurve << 16);
    keyboardEndFrame = [self.referenceView convertRect:keyboardEndFrame fromView:nil];
    
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

- (void)inputKeyboardDidShow
{
    // Grab the keyboard view
    self.keyboardActiveView = self.keyboardActiveInput.inputAccessoryView.superview;
    self.keyboardActiveView.hidden = NO;
    
    NSLog(@"KEYBOARD ACTIVE VIEW = %@", self.keyboardActiveView);
    
    // If the active keyboard view could not be found (UITextViews...), try again
    if (!self.keyboardActiveView) {
        // Find the first responder on subviews and look re-assign first responder to it
        [self reAssignFirstResponder];
    }
}

- (void)reAssignFirstResponder
{
    // Find first responder
    UIView *inputView = [self.referenceView jsq_findFirstResponder];
    if (inputView != nil) {
        // Re assign the focus
        [inputView resignFirstResponder];
        [inputView becomeFirstResponder];
    }
}

#pragma mark - Pan gesture utilities

- (void)jsq_addPanGestureRecognizer
{
    if (self.panGestureRecognizer) {
        return;
    }
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handlePanGestureRecognizer:)];
    pan.delegate = self;
    pan.cancelsTouchesInView = NO;
    [self.referenceView addGestureRecognizer:pan];
    
    self.panGestureRecognizer = pan;
}

- (void)jsq_removePanGestureRecognizer
{
    if (!self.panGestureRecognizer) {
        return;
    }
    
    [self.panGestureRecognizer removeTarget:self action:NULL];
    self.panGestureRecognizer.delegate = nil;
    
    [self.referenceView removeGestureRecognizer:self.panGestureRecognizer];
    
    self.panGestureRecognizer = nil;
}



@end
