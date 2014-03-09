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

#import "JSQMessagesCollectionViewCell.h"

#import "UIView+JSQMessages.h"


const CGFloat kJSQMessagesCollectionViewCellLabelHeightDefault = 20.0f;
const CGFloat kJSQMessagesCollectionViewCellAvatarSizeDefault = 34.0f;
const CGFloat kJSQMessagesCollectionViewCellMessageBubblePaddingDefault = 40.0f;
const CGFloat kJSQMessagesCollectionViewCellMessageBubbleTopLabelHorizontalPaddingDefault = 20.0f;


@interface JSQMessagesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet JSQMessagesCollectionViewCellLabel *cellTopLabel;
@property (weak, nonatomic) IBOutlet JSQMessagesCollectionViewCellLabel *messageBubbleTopLabel;
@property (weak, nonatomic) IBOutlet JSQMessagesCollectionViewCellLabel *cellBottomLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIView *messageBubbleContainerView;
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTopLabelHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleTopLabelHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellBottomLabelHeightContraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewWidthContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHeightContraint;

@property (assign, nonatomic) CGSize avatarViewSize;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleTopLabelHorizontalPadding;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleContainerHorizontalPadding;

@end



@implementation JSQMessagesCollectionViewCell

@synthesize font = _font;

#pragma mark - Class methods

+ (UINib *)nib
{
    return nil;
}

+ (NSString *)cellReuseIdentifier
{
    return nil;
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.cellTopLabelHeight = kJSQMessagesCollectionViewCellLabelHeightDefault;
    self.messageBubbleTopLabelHeight = kJSQMessagesCollectionViewCellLabelHeightDefault;
    self.cellBottomLabelHeight = kJSQMessagesCollectionViewCellLabelHeightDefault;
    
    self.avatarViewSize = CGSizeMake(kJSQMessagesCollectionViewCellAvatarSizeDefault,
                                     kJSQMessagesCollectionViewCellAvatarSizeDefault);
    
    self.messageBubblePadding = kJSQMessagesCollectionViewCellMessageBubblePaddingDefault;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.cellTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellTopLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.cellTopLabel.textColor = [UIColor lightGrayColor];
    
    self.messageBubbleTopLabel.font = [UIFont systemFontOfSize:12.0f];
    self.messageBubbleTopLabel.textColor = [UIColor lightGrayColor];
    
    self.cellBottomLabel.font = [UIFont systemFontOfSize:11.0f];
    self.cellBottomLabel.textColor = [UIColor lightGrayColor];
    
    self.textView.textColor = [UIColor blackColor];
    self.textView.editable = NO;
    self.textView.userInteractionEnabled = YES;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.scrollEnabled = NO;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.contentInset = UIEdgeInsetsZero;
    self.textView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.textView.textContainerInset = UIEdgeInsetsMake(8.0f, 4.0f, 2.0f, 4.0f);
    self.textView.contentOffset = CGPointZero;
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.cellTopLabel.text = nil;
    self.messageBubbleTopLabel.text = nil;
    self.cellBottomLabel.text = nil;
    
    self.textView.text = nil;
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

- (void)setFont:(UIFont *)font
{
    _font = font;
    _textView.font = font;
    [self setNeedsLayout];
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
    [self.messageBubbleContainerView insertSubview:messageBubbleImageView belowSubview:self.textView];
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
    
    if (CGRectEqualToRect(avatarImageView.frame, CGRectZero)) {
        avatarImageView.frame = CGRectMake(0.0f,
                                           0.0f,
                                           kJSQMessagesCollectionViewCellAvatarSizeDefault,
                                           kJSQMessagesCollectionViewCellAvatarSizeDefault);
    }
    
    self.avatarContainerView.hidden = NO;
    self.avatarViewSize = CGSizeMake(CGRectGetWidth(avatarImageView.bounds), CGRectGetHeight(avatarImageView.bounds));
    
    [avatarImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.avatarContainerView addSubview:avatarImageView];
    [self.avatarContainerView jsq_pinAllEdgesOfSubview:avatarImageView];
    [self setNeedsUpdateConstraints];
    
    _avatarImageView = avatarImageView;
}

- (void)setCellTopLabelHeight:(CGFloat)cellTopLabelHeight
{
    self.cellTopLabelHeightContraint.constant = cellTopLabelHeight;
    [self setNeedsUpdateConstraints];
}

- (void)setMessageBubbleTopLabelHeight:(CGFloat)messageBubbleTopLabelHeight
{
    self.messageBubbleTopLabelHeightContraint.constant = messageBubbleTopLabelHeight;
    [self setNeedsUpdateConstraints];
}

- (void)setCellBottomLabelHeight:(CGFloat)cellBottomLabelHeight
{
    self.cellBottomLabelHeightContraint.constant = cellBottomLabelHeight;
    [self setNeedsUpdateConstraints];
}

- (void)setAvatarViewSize:(CGSize)avatarViewSize
{
    self.avatarContainerViewWidthContraint.constant = avatarViewSize.width;
    self.avatarContainerViewHeightContraint.constant = avatarViewSize.height;
    [self setNeedsUpdateConstraints];
}

- (void)setMessageBubblePadding:(CGFloat)messageBubblePadding
{
    self.messageBubbleTopLabelHorizontalPadding.constant = messageBubblePadding;
    self.messageBubbleContainerHorizontalPadding.constant = messageBubblePadding;
    [self setNeedsUpdateConstraints];
}

#pragma mark - Getters

- (UIFont *)font
{
    if (!_font) {
        _font = [[[self class] appearance] font];
    }
    
    return _font;
}

- (CGFloat)cellTopLabelHeight
{
    return self.cellTopLabelHeightContraint.constant;
}

- (CGFloat)messageBubbleTopLabelHeight
{
    return self.messageBubbleTopLabelHeightContraint.constant;
}

- (CGFloat)cellBottomLabelHeight
{
    return self.cellBottomLabelHeightContraint.constant;
}

- (CGSize)avatarViewSize
{
    return CGSizeMake(self.avatarContainerViewWidthContraint.constant,
                      self.avatarContainerViewHeightContraint.constant);
}

- (CGFloat)messageBubblePadding
{
    return self.messageBubbleContainerHorizontalPadding.constant;
}

@end
