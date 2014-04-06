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

#import <Foundation/Foundation.h>


@protocol JSQMessagesKeyboardControllerDelegate <NSObject>

@required
- (void)keyboardDidChangeFrame:(CGRect)keyboardFrame;

@end



@interface JSQMessagesKeyboardController : NSObject

@property (weak, nonatomic) id<JSQMessagesKeyboardControllerDelegate> delegate;

@property (weak, nonatomic, readonly) UITextView *textView;

@property (weak, nonatomic, readonly) UIView *contextView;

@property (weak, nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer;

@property (assign, nonatomic) CGPoint keyboardTriggerPoint;

- (instancetype)initWithTextView:(UITextView *)textView
                     contextView:(UIView *)contextView
            panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
                        delegate:(id<JSQMessagesKeyboardControllerDelegate>)delegate;

- (void)beginListeningForKeyboard;

- (void)endListeningForKeyboard;

@end
