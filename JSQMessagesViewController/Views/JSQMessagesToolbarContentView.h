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

#import <UIKit/UIKit.h>

@class JSQMessagesComposerTextView;

FOUNDATION_EXPORT const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault;


@interface JSQMessagesToolbarContentView : UIView

@property (weak, nonatomic, readonly) JSQMessagesComposerTextView *textView;

@property (weak, nonatomic) UIButton *leftBarButtonItem;
@property (assign, nonatomic) CGFloat leftBarButtonItemWidth;

@property (weak, nonatomic) UIButton *rightBarButtonItem;
@property (assign, nonatomic) CGFloat rightBarButtonItemWidth;

#pragma mark - Class methods

+ (UINib *)nib;

@end
