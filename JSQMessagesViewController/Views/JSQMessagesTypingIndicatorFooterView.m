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

#import "JSQMessagesTypingIndicatorFooterView.h"

#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"

const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight = 46.0f;


@interface JSQMessagesTypingIndicatorFooterView ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewLeftHorizontalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *typingIndicatorImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewLeftHorizontalConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewRightHorizontalConstraint;

@end



@implementation JSQMessagesTypingIndicatorFooterView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesTypingIndicatorFooterView class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)footerReuseIdentifier
{
    return NSStringFromClass([JSQMessagesTypingIndicatorFooterView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc
{
    _bubbleImageView = nil;
    _typingIndicatorImageView = nil;
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.bubbleImageView.backgroundColor = backgroundColor;
}

#pragma mark - Typing indicator

- (void)configureForIncoming:(BOOL)isIncoming
              indicatorColor:(UIColor *)indicatorColor
                 bubbleColor:(UIColor *)bubbleColor
              collectionView:(UICollectionView *)collectionView

{
    NSParameterAssert(indicatorColor != nil);
    NSParameterAssert(bubbleColor != nil);
    NSParameterAssert(collectionView != nil);
    
    CGFloat collectionViewWidth = CGRectGetWidth(collectionView.frame);
    CGFloat bubbleWidth = CGRectGetWidth(self.bubbleImageView.frame);
    CGFloat indicatorWidth = CGRectGetWidth(self.typingIndicatorImageView.frame);
    
    CGFloat bubbleMarginMinimumSpacing = 6.0f;
    CGFloat indicatorMarginMinimumSpacing = 24.0f;
    
    CGFloat bubbleMarginMaximumSpacing = collectionViewWidth - bubbleWidth - bubbleMarginMinimumSpacing;
    CGFloat indicatorMarginMaximumSpacing = collectionViewWidth - indicatorWidth - indicatorMarginMinimumSpacing;
    
    if (isIncoming) {
        self.bubbleImageView.image = [JSQMessagesBubbleImageFactory incomingMessageBubbleImageViewWithColor:bubbleColor].image;
        
        self.bubbleImageViewLeftHorizontalConstraint.constant = bubbleMarginMinimumSpacing;
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMaximumSpacing;
        
        self.typingIndicatorImageViewLeftHorizontalConstraint.constant = indicatorMarginMinimumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMaximumSpacing;
    }
    else {
        self.bubbleImageView.image = [JSQMessagesBubbleImageFactory outgoingMessageBubbleImageViewWithColor:bubbleColor].image;
        
        self.bubbleImageViewLeftHorizontalConstraint.constant = bubbleMarginMaximumSpacing;
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMinimumSpacing;
        
        self.typingIndicatorImageViewLeftHorizontalConstraint.constant = indicatorMarginMaximumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMinimumSpacing;
    }
    
    [self setNeedsUpdateConstraints];
    
    self.typingIndicatorImageView.image = [[UIImage imageNamed:@"typing"] jsq_imageMaskedWithColor:indicatorColor];
    self.typingIndicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
