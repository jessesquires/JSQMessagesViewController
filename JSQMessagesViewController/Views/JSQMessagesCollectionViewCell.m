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

#import "JSQMessagesCollectionViewCell.h"

#import "JSQMessagesCollectionViewTextCellIncoming.h"
#import "JSQMessagesCollectionViewTextCellOutgoing.h"
#import "JSQMessagesCollectionViewLayoutAttributes.h"

#import "UIView+JSQMessages.h"


@interface JSQMessagesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet JSQMessagesLabel *cellTopLabel;
@property (weak, nonatomic) IBOutlet JSQMessagesLabel *messageBubbleTopLabel;
@property (weak, nonatomic) IBOutlet JSQMessagesLabel *cellBottomLabel;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIView *messageBubbleContainerView;
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewTopVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewAvatarHorizontalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewMarginHorizontalSpaceConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTopLabelHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleTopLabelHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellBottomLabelHeightContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewWidthContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHeightContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleLeftRightMarginConstraint;

@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;

@property (assign, nonatomic) CGSize avatarViewSize;

@property (weak, nonatomic, readwrite) UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (weak, nonatomic, readwrite) UITapGestureRecognizer *tapGestureRecognizer;

- (void)jsq_handleLongPressGesture:(UILongPressGestureRecognizer *)longPress;
- (void)jsq_handleTapGesture:(UITapGestureRecognizer *)tap;

- (void)jsq_didReceiveMenuWillHideNotification:(NSNotification *)notification;
- (void)jsq_didReceiveMenuWillShowNotification:(NSNotification *)notification;

@end



@implementation JSQMessagesCollectionViewCell

#pragma mark - Class methods

+ (UINib *)nib
{
    NSAssert(NO, @"ERROR: method must be overridden in subclasses: %s", __PRETTY_FUNCTION__);
    return nil;
}

+ (NSString *)cellReuseIdentifier
{
    NSAssert(NO, @"ERROR: method must be overridden in subclasses: %s", __PRETTY_FUNCTION__);
    return nil;
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor whiteColor];
    
    self.cellTopLabelHeightContraint.constant = 0.0f;
    self.messageBubbleTopLabelHeightContraint.constant = 0.0f;
    self.cellBottomLabelHeightContraint.constant = 0.0f;
    
    self.avatarViewSize = CGSizeZero;
    
    self.cellTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellTopLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.cellTopLabel.textColor = [UIColor lightGrayColor];
    
    self.messageBubbleTopLabel.font = [UIFont systemFontOfSize:12.0f];
    self.messageBubbleTopLabel.textColor = [UIColor lightGrayColor];
    
    self.cellBottomLabel.font = [UIFont systemFontOfSize:11.0f];
    self.cellBottomLabel.textColor = [UIColor lightGrayColor];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleLongPressGesture:)];
    longPress.minimumPressDuration = 0.4f;
    [self addGestureRecognizer:longPress];
    self.longPressGestureRecognizer = longPress;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleTapGesture:)];
    [self.avatarContainerView addGestureRecognizer:tap];
    self.tapGestureRecognizer = tap;
}

- (void)dealloc
{
    _delegate = nil;
    
    _cellTopLabel = nil;
    _messageBubbleTopLabel = nil;
    _cellBottomLabel = nil;
    _messageBubbleImageView = nil;
    _avatarImageView = nil;
    
    [_longPressGestureRecognizer removeTarget:nil action:NULL];
    _longPressGestureRecognizer = nil;
    
    [_tapGestureRecognizer removeTarget:nil action:NULL];
    _tapGestureRecognizer = nil;
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.cellTopLabel.text = nil;
    self.messageBubbleTopLabel.text = nil;
    self.cellBottomLabel.text = nil;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    
    self.messageBubbleLeftRightMarginConstraint.constant = customAttributes.messageBubbleLeftRightMargin;
    self.textViewFrameInsets = customAttributes.textViewFrameInsets;
    self.cellTopLabelHeightContraint.constant = customAttributes.cellTopLabelHeight;
    self.messageBubbleTopLabelHeightContraint.constant = customAttributes.messageBubbleTopLabelHeight;
    self.cellBottomLabelHeightContraint.constant = customAttributes.cellBottomLabelHeight;
    
    if ([self isKindOfClass:[JSQMessagesCollectionViewTextCellIncoming class]]) {
        self.avatarViewSize = customAttributes.incomingAvatarViewSize;
    }
    else if ([self isKindOfClass:[JSQMessagesCollectionViewTextCellOutgoing class]]) {
        self.avatarViewSize = customAttributes.outgoingAvatarViewSize;
    }
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    self.cellTopLabel.backgroundColor = backgroundColor;
    self.messageBubbleTopLabel.backgroundColor = backgroundColor;
    self.cellBottomLabel.backgroundColor = backgroundColor;
    
    self.messageBubbleImageView.backgroundColor = backgroundColor;
    self.avatarImageView.backgroundColor = backgroundColor;
    
    self.messageBubbleContainerView.backgroundColor = backgroundColor;
    self.avatarContainerView.backgroundColor = backgroundColor;
}

- (void)setMessageBubbleImageView:(UIImageView *)messageBubbleImageView
{
    if (_messageBubbleImageView) {
        [_messageBubbleImageView removeFromSuperview];
    }
    
    if (!messageBubbleImageView) {
        _messageBubbleImageView = nil;
        return;
    }
    
    messageBubbleImageView.frame = CGRectMake(0.0f,
                                              0.0f,
                                              CGRectGetWidth(self.messageBubbleContainerView.bounds),
                                              CGRectGetHeight(self.messageBubbleContainerView.bounds));
    
    [messageBubbleImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.messageBubbleContainerView insertSubview:messageBubbleImageView belowSubview:self.contentView];
    [self.messageBubbleContainerView jsq_pinAllEdgesOfSubview:messageBubbleImageView];
    [self setNeedsUpdateConstraints];
    
    _messageBubbleImageView = messageBubbleImageView;
}

- (void)setAvatarImageView:(UIImageView *)avatarImageView
{
    if (_avatarImageView) {
        [_avatarImageView removeFromSuperview];
    }
    
    if (!avatarImageView) {
        self.avatarViewSize = CGSizeZero;
        _avatarImageView = nil;
        self.avatarContainerView.hidden = YES;
        return;
    }
    
    self.avatarContainerView.hidden = NO;
    self.avatarViewSize = CGSizeMake(CGRectGetWidth(avatarImageView.bounds), CGRectGetHeight(avatarImageView.bounds));
    
    [avatarImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.avatarContainerView addSubview:avatarImageView];
    [self.avatarContainerView jsq_pinAllEdgesOfSubview:avatarImageView];
    [self setNeedsUpdateConstraints];
    
    _avatarImageView = avatarImageView;
}

- (void)setAvatarViewSize:(CGSize)avatarViewSize
{
    self.avatarContainerViewWidthContraint.constant = avatarViewSize.width;
    self.avatarContainerViewHeightContraint.constant = avatarViewSize.height;
    [self setNeedsUpdateConstraints];
}

- (void)setContentViewFrameInsets:(UIEdgeInsets)contentViewFrameInsets
{
    self.contentViewTopVerticalSpaceConstraint.constant = contentViewFrameInsets.top;
    self.contentViewBottomVerticalSpaceConstraint.constant = contentViewFrameInsets.bottom;
    self.contentViewAvatarHorizontalSpaceConstraint.constant = contentViewFrameInsets.right;
    self.contentViewMarginHorizontalSpaceConstraint.constant = contentViewFrameInsets.left;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (CGSize)avatarViewSize
{
    return CGSizeMake(self.avatarContainerViewWidthContraint.constant,
                      self.avatarContainerViewHeightContraint.constant);
}

- (UIEdgeInsets)contentViewFrameInsets
{
    return UIEdgeInsetsMake(self.contentViewTopVerticalSpaceConstraint.constant,
                            self.contentViewMarginHorizontalSpaceConstraint.constant,
                            self.contentViewBottomVerticalSpaceConstraint.constant,
                            self.contentViewAvatarHorizontalSpaceConstraint.constant);
}

#pragma mark - Gesture recognizers

- (void)jsq_handleLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state != UIGestureRecognizerStateBegan || ![self becomeFirstResponder]) {
        return;
    }
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    CGRect targetRect = [self convertRect:self.messageBubbleImageView.bounds fromView:self.messageBubbleImageView];
    
    [menu setTargetRect:CGRectInset(targetRect, 0.0f, 4.0f) inView:self];
    
    self.messageBubbleImageView.highlighted = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:menu];
    
    [menu setMenuVisible:YES animated:YES];
}

- (void)jsq_handleTapGesture:(UITapGestureRecognizer *)tap
{
    [self.delegate messagesCollectionViewCellDidTapAvatar:self];
}

#pragma mark - Notifications

- (void)jsq_didReceiveMenuWillHideNotification:(NSNotification *)notification
{
    self.messageBubbleImageView.highlighted = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
}

- (void)jsq_didReceiveMenuWillShowNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveMenuWillHideNotification:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:[notification object]];
}

@end
