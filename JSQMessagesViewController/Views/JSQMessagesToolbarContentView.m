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

#import "JSQMessagesToolbarContentView.h"

#import "JSQMessagesComposerTextView.h"
#import "JSQMessagesRecorderButton.h"

#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault = 4.0f;


@interface JSQMessagesToolbarContentView ()

@property (weak, nonatomic) IBOutlet JSQMessagesComposerTextView *textView;
@property (weak, nonatomic) IBOutlet JSQMessagesRecorderButton *button;

@property (weak, nonatomic) IBOutlet UIView *leftBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButton2ContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButton2ContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHorizontalSpacingConstraint2;

@end



@implementation JSQMessagesToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesToolbarContentView class])
                          bundle:[NSBundle mainBundle]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.leftBarButtonContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightBarButtonContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.rightBarButton2ContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightHorizontalSpacingConstraint2.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    
    self.leftBarButtonItem = nil;
    self.rightBarButtonItem = nil;
    self.rightBarButtonItem2 = nil;
    
    self.button.hidden = YES;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc
{
    _textView = nil;
    _button = nil;
    _leftBarButtonItem = nil;
    _rightBarButtonItem = nil;
    _rightBarButtonItem2 = nil;
    _leftBarButtonContainerView = nil;
    _rightBarButtonContainerView = nil;
    _rightBarButton2ContainerView = nil;
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftBarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButton2ContainerView.backgroundColor = backgroundColor;
}

- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }
    
    if (!leftBarButtonItem) {
        self.leftHorizontalSpacingConstraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        _leftBarButtonItem = nil;
        self.leftBarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(leftBarButtonItem.frame, CGRectZero)) {
        leftBarButtonItem.frame = CGRectMake(0.0f,
                                             0.0f,
                                             CGRectGetWidth(self.leftBarButtonContainerView.frame),
                                             CGRectGetHeight(self.leftBarButtonContainerView.frame));
    }
    
    self.leftBarButtonContainerView.hidden = NO;
    self.leftHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonItemWidth = CGRectGetWidth(leftBarButtonItem.frame);
    
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

- (void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }
    
    if (!rightBarButtonItem) {
        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        _rightBarButtonItem = nil;
        self.rightBarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(rightBarButtonItem.frame, CGRectZero)) {
        rightBarButtonItem.frame = CGRectMake(0.0f,
                                              0.0f,
                                              CGRectGetWidth(self.rightBarButtonContainerView.frame),
                                              CGRectGetHeight(self.rightBarButtonContainerView.frame));
    }
    
    self.rightBarButtonContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItemWidth = CGRectGetWidth(rightBarButtonItem.frame);
    
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


- (void)setRightBarButtonItem2:(UIButton *)rightBarButtonItem2
{
    if (_rightBarButtonItem2) {
        [_rightBarButtonItem2 removeFromSuperview];
    }
    
    if (!rightBarButtonItem2) {
        self.rightHorizontalSpacingConstraint2.constant = 0.0f;
        self.rightBarButtonItem2Width = 0.0f;
        _rightBarButtonItem2 = nil;
        self.rightBarButton2ContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(rightBarButtonItem2.frame, CGRectZero)) {
        rightBarButtonItem2.frame = CGRectMake(0.0f,
                                               0.0f,
                                               CGRectGetWidth(self.rightBarButton2ContainerView.frame),
                                               CGRectGetHeight(self.rightBarButton2ContainerView.frame));
    }
    
    self.rightBarButton2ContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint2.constant = kJSQMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItem2Width = CGRectGetWidth(rightBarButtonItem2.frame);
    
    [self.rightBarButton2ContainerView addSubview:rightBarButtonItem2];
    [self.rightBarButton2ContainerView jsq_pinAllEdgesOfSubview:rightBarButtonItem2];
    [self setNeedsUpdateConstraints];
    
    _rightBarButtonItem2 = rightBarButtonItem2;
}

- (void)setRightBarButtonItem2Width:(CGFloat)rightBarButtonItem2Width
{
    self.rightBarButton2ContainerViewWidthConstraint.constant = rightBarButtonItem2Width;
    [self setNeedsUpdateConstraints];
}


#pragma mark - Getters

- (CGFloat)leftBarButtonItemWidth
{
    return self.leftBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightBarButtonItemWidth
{
    return self.rightBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightBarButtonItem2Width
{
    return self.rightBarButton2ContainerViewWidthConstraint.constant;
}

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}

@end
