//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

#import "JSQMessagesInputToolbar.h"

#import "JSQMessagesToolbarContentView.h"
#import "JSQMessagesComposerTextView.h"
#import "JSQMessagesRecorderButton.h"

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesInputToolbarHeightDefault = 44.0f;

static void * kJSQMessagesInputToolbarKeyValueObservingContext = &kJSQMessagesInputToolbarKeyValueObservingContext;


@interface JSQMessagesInputToolbar ()

- (void)jsq_leftBarButtonPressed:(UIButton *)sender;
- (void)jsq_rightBarButtonPressed:(UIButton *)sender;
- (void)jsq_rightBarButton2Pressed:(UIButton *)sender;
- (void)jsq_recorderButtonTouchDown:(UIButton *)sender;
- (void)jsq_recorderButtonTouchUpInside:(UIButton *)sender;
- (void)jsq_recorderButtonTouchUpOutside:(UIButton *)sender;
- (void)jsq_recorderButtonTouchDragExit:(UIButton *)sender;
- (void)jsq_recorderButtonTouchDragEnter:(UIButton *)sender;

- (void)jsq_addObservers;
- (void)jsq_removeObservers;

@end



@implementation JSQMessagesInputToolbar

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSQMessagesToolbarContentView class]) owner:nil options:nil];
    JSQMessagesToolbarContentView *toolbarContentView = [nibViews firstObject];
    toolbarContentView.frame = self.frame;
    [self addSubview:toolbarContentView];
    [self jsq_pinAllEdgesOfSubview:toolbarContentView];
    [self setNeedsUpdateConstraints];
    _contentView = toolbarContentView;
    
    [self jsq_addObservers];
    
    self.contentView.leftBarButtonItem = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
    self.contentView.rightBarButtonItem = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
    self.contentView.rightBarButtonItem2 = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
}

- (void)dealloc
{
    [self jsq_removeObservers];
    _contentView = nil;
}

- (void)toggleRecorderButtonHidden
{
    BOOL isRecording = self.contentView.textView.alpha == 0.f;
    
    [UIView animateWithDuration:.2f
                     animations:^{
                         self.contentView.button.alpha = isRecording ? 0.f : 1.f;
                         self.contentView.textView.alpha = isRecording ? 1.f : 0.f;
                     } completion:^(BOOL finished) {
                         isRecording
                         ? [self.contentView.textView becomeFirstResponder]
                         : [self.contentView.textView resignFirstResponder];
                     }];
}

#pragma mark - Actions

- (void)jsq_leftBarButtonPressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressLeftBarButton:sender];
}

- (void)jsq_rightBarButtonPressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressRightBarButton:sender];
}

- (void)jsq_rightBarButton2Pressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressRightBarButton2:sender];
}


#pragma mark - Input toolbar

- (void)jsq_recorderButtonTouchDown:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self recorderButtonDidTouchDown:sender];
}

- (void)jsq_recorderButtonTouchUpInside:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self recorderButtonDidTouchUpInside:sender];
}

- (void)jsq_recorderButtonTouchUpOutside:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self recorderButtonDidTouchUpOutside:sender];
}

- (void)jsq_recorderButtonTouchDragExit:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self recorderButtonDidTouchDragExit:sender];
}

- (void)jsq_recorderButtonTouchDragEnter:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self recorderButtonDidTouchDragEnter:sender];
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesInputToolbarKeyValueObservingContext) {
        if (object == self.contentView) {
            
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(leftBarButtonItem))]) {
                
                [self.contentView.leftBarButtonItem removeTarget:self
                                                          action:NULL
                                                forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.leftBarButtonItem addTarget:self
                                                       action:@selector(jsq_leftBarButtonPressed:)
                                             forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:NSStringFromSelector(@selector(rightBarButtonItem))]) {
                
                [self.contentView.rightBarButtonItem removeTarget:self
                                                           action:NULL
                                                 forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.rightBarButtonItem addTarget:self
                                                        action:@selector(jsq_rightBarButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:NSStringFromSelector(@selector(rightBarButtonItem2))]) {
                [self.contentView.rightBarButtonItem2 removeTarget:self
                                                            action:NULL
                                                  forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.rightBarButtonItem2 addTarget:self
                                                         action:@selector(jsq_rightBarButton2Pressed:)
                                               forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:[NSStringFromSelector(@selector(button)) stringByAppendingString:@".alpha"]]) {
                [self.contentView.button removeTarget:self
                                               action:@selector(jsq_recorderButtonTouchDown:)
                                     forControlEvents:UIControlEventTouchDown];
                
                [self.contentView.button removeTarget:self
                                            action:@selector(jsq_recorderButtonTouchUpInside:)
                                  forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.button removeTarget:self
                                               action:@selector(jsq_recorderButtonTouchUpOutside:)
                                     forControlEvents:UIControlEventTouchUpOutside];
                
                [self.contentView.button removeTarget:self
                                               action:@selector(jsq_recorderButtonTouchDragExit:)
                                     forControlEvents:UIControlEventTouchDragExit];
                
                [self.contentView.button removeTarget:self
                                               action:@selector(jsq_recorderButtonTouchDragEnter:)
                                     forControlEvents:UIControlEventTouchDragEnter];
                
                
                [self.contentView.button addTarget:self
                                               action:@selector(jsq_recorderButtonTouchDown:)
                                     forControlEvents:UIControlEventTouchDown];
                
                [self.contentView.button addTarget:self
                                               action:@selector(jsq_recorderButtonTouchUpInside:)
                                     forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.button addTarget:self
                                               action:@selector(jsq_recorderButtonTouchUpOutside:)
                                     forControlEvents:UIControlEventTouchUpOutside];
                
                [self.contentView.button addTarget:self
                                               action:@selector(jsq_recorderButtonTouchDragExit:)
                                     forControlEvents:UIControlEventTouchDragExit];
                
                [self.contentView.button addTarget:self
                                               action:@selector(jsq_recorderButtonTouchDragEnter:)
                                     forControlEvents:UIControlEventTouchDragEnter];
            }
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)jsq_addObservers
{
    [self jsq_removeObservers];
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem2))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
    
    [self.contentView addObserver:self
                       forKeyPath:[NSStringFromSelector(@selector(button)) stringByAppendingString:@".alpha"]
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
}

- (void)jsq_removeObservers
{
    @try {
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
        
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
        
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem2))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
        
        [_contentView removeObserver:self
                          forKeyPath:[NSStringFromSelector(@selector(button)) stringByAppendingString:@".alpha"]
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
    }
    @catch (NSException *__unused exception) { }
}

@end
