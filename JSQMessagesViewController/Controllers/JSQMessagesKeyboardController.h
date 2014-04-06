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

- (CGFloat)keyboardTriggerOffset;

@end



@interface JSQMessagesKeyboardController : NSObject

@property (weak, nonatomic) id<JSQMessagesKeyboardControllerDelegate> delegate;

@property (weak, nonatomic) UIView *referenceView;

@property (weak, nonatomic) UITextView *textView;

- (instancetype)initWithTextView:(UITextView *)textView
                   referenceView:(UIView *)referenceView
                        delegate:(id<JSQMessagesKeyboardControllerDelegate>)delegate;

- (void)add;
- (void)remove;

@end
