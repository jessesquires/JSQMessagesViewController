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

#import "JSQMessagesToolbarContentView.h"

#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault = 8.0f;


@interface JSQMessagesToolbarContentView ()

@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewSpacingBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewSpacingTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *leftBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewSpacingLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewSpacingRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewSpacingBottomConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewSpacingLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewSpacingRightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewSpacingBottomConstraint;

@end



@implementation JSQMessagesToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesToolbarContentView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesToolbarContentView class]]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.leftBarButtonContainerViewSpacingLeftConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonContainerViewSpacingRightConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonContainerViewSpacingLeftConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonContainerViewSpacingRightConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc
{
    _textView = nil;
    _leftBarButtonItem = nil;
    _rightBarButtonItem = nil;
    _leftBarButtonContainerView = nil;
    _rightBarButtonContainerView = nil;
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftBarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButtonContainerView.backgroundColor = backgroundColor;
}

- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }
    
    if (!leftBarButtonItem) {
        _leftBarButtonItem = nil;
        self.leftBarButtonContainerViewSpacingLeftConstraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        self.leftBarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(leftBarButtonItem.frame, CGRectZero)) {
        leftBarButtonItem.frame = self.leftBarButtonContainerView.bounds;
    }
    
    self.leftBarButtonContainerView.hidden = NO;
    self.leftBarButtonContainerViewSpacingLeftConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonItemWidth = CGRectGetWidth(leftBarButtonItem.frame);
    
    [leftBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.leftBarButtonContainerView addSubview:leftBarButtonItem];
    [self.leftBarButtonContainerView jsq_pinAllEdgesOfSubview:leftBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _leftBarButtonItem = leftBarButtonItem;
}

- (void)setLeftBarButtonItemWidth:(CGFloat)leftBarButtonItemWidth
{
    self.leftBarButtonContainerViewWidthConstraint.constant = leftBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setLeftBarButtonItemLeftSpacing:(CGFloat)leftBarButtonItemLeftSpacing
{
    self.leftBarButtonContainerViewSpacingLeftConstraint.constant = leftBarButtonItemLeftSpacing;
    [self setNeedsUpdateConstraints];
}

- (void)setLeftBarButtonItemRightSpacing:(CGFloat)leftBarButtonItemRightSpacing
{
    self.leftBarButtonContainerViewSpacingRightConstraint.constant = leftBarButtonItemRightSpacing;
    [self setNeedsUpdateConstraints];
}

- (void)setLeftBarButtonItemBottomSpacing:(CGFloat)leftBarButtonItemBottomSpacing
{
    self.leftBarButtonContainerViewSpacingBottomConstraint.constant = leftBarButtonItemBottomSpacing;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }
    
    if (!rightBarButtonItem) {
        _rightBarButtonItem = nil;
        self.rightBarButtonContainerViewSpacingRightConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        self.rightBarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(rightBarButtonItem.frame, CGRectZero)) {
        rightBarButtonItem.frame = self.rightBarButtonContainerView.bounds;
    }
    
    self.rightBarButtonContainerView.hidden = NO;
    self.rightBarButtonContainerViewSpacingRightConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItemWidth = CGRectGetWidth(rightBarButtonItem.frame);
    
    [rightBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightBarButtonContainerView addSubview:rightBarButtonItem];
    [self.rightBarButtonContainerView jsq_pinAllEdgesOfSubview:rightBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _rightBarButtonItem = rightBarButtonItem;
}

- (void)setRightBarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.rightBarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItemLeftSpacing:(CGFloat)rightBarButtonItemLeftSpacing
{
    self.rightBarButtonContainerViewSpacingLeftConstraint.constant = rightBarButtonItemLeftSpacing;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItemRighttSpacing:(CGFloat)rightBarButtonItemRightSpacing
{
    self.rightBarButtonContainerViewSpacingRightConstraint.constant = rightBarButtonItemRightSpacing;
    [self setNeedsUpdateConstraints];
}

- (void)setRightBarButtonItemBottomSpacing:(CGFloat)rightBarButtonItemBottomSpacing
{
    self.rightBarButtonContainerViewSpacingBottomConstraint.constant = rightBarButtonItemBottomSpacing;
    [self setNeedsUpdateConstraints];
}

- (void)setTextViewTopSpacing:(CGFloat)textViewTopSpacing
{
    self.textViewSpacingTopConstraint.constant = textViewTopSpacing;
    [self setNeedsUpdateConstraints];
}

- (void)setTextViewBottomSpacing:(CGFloat)textViewBottomSpacing
{
    self.textViewSpacingBottomConstraint.constant = textViewBottomSpacing;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (CGFloat)leftBarButtonItemWidth
{
    return self.leftBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)leftBarButtonItemLeftSpacing
{
    return self.leftBarButtonContainerViewSpacingLeftConstraint.constant;
}

- (CGFloat)leftBarButtonItemRightSpacing
{
    return self.leftBarButtonContainerViewSpacingRightConstraint.constant;
}

- (CGFloat)leftBarButtonItemBottomSpacing
{
    return self.leftBarButtonContainerViewSpacingBottomConstraint.constant;
}

- (CGFloat)rightBarButtonItemWidth
{
    return self.rightBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightBarButtonItemLeftSpacing
{
    return self.rightBarButtonContainerViewSpacingLeftConstraint.constant;
}

- (CGFloat)rightBarButtonItemRightSpacing
{
    return self.rightBarButtonContainerViewSpacingRightConstraint.constant;
}

- (CGFloat)rightBarButtonItemBottomSpacing
{
    return self.rightBarButtonContainerViewSpacingBottomConstraint.constant;
}

- (CGFloat)textViewTopSpacing
{
    return self.textViewSpacingTopConstraint.constant;
}

- (CGFloat)textViewBottomSpacing
{
    return self.textViewSpacingBottomConstraint.constant;
}

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}

@end
