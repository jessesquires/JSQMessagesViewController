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

#import "JSQMessagesTypingIndicatorFooterView.h"

#import "JSQMessagesBubbleImageFactory.h"
// Animator
#import "JSQMessagesTypingIndicatorAnimator.h"
#import "JSQMessagesTypingIndicatorCircleView.h"


#import "UIImage+JSQMessages.h"
#import "UIColor+JSQMessages.h"

const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight = 46.0f;

@interface JSQMessagesTypingIndicatorFooterView ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewRightHorizontalConstraint;
// Views to be animated
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView1;
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView2;
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView3;
// Animator
@property (nonatomic, strong) JSQMessagesTypingIndicatorAnimator *animator;

@end



@implementation JSQMessagesTypingIndicatorFooterView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesTypingIndicatorFooterView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesTypingIndicatorFooterView class]]];
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
    self.userInteractionEnabled = NO;
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.bubbleImageView.backgroundColor = backgroundColor;
}

#pragma mark - Typing indicator

- (void)configureWithEllipsisColor:(UIColor *)ellipsisColor
                messageBubbleColor:(UIColor *)messageBubbleColor
                          animated:(BOOL)animated
               shouldDisplayOnLeft:(BOOL)shouldDisplayOnLeft
                 forCollectionView:(UICollectionView *)collectionView
{
    NSParameterAssert(ellipsisColor != nil);
    NSParameterAssert(messageBubbleColor != nil);
    NSParameterAssert(collectionView != nil);
    
    CGFloat bubbleMarginMinimumSpacing = 6.0f;
    CGFloat indicatorMarginMinimumSpacing = 24.0f;
    
    JSQMessagesBubbleImageFactory *bubbleImageFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    
    if (shouldDisplayOnLeft) {
        self.bubbleImageView.image = [bubbleImageFactory incomingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
        
        CGFloat collectionViewWidth = CGRectGetWidth(collectionView.frame);
        CGFloat bubbleWidth = CGRectGetWidth(self.bubbleImageView.frame);
        // Constraint relies on just the first of the 3 bubble indicators
        CGFloat indicatorWidth = self.typingIndicatorView1.frame.size.width;
        
        CGFloat bubbleMarginMaximumSpacing = collectionViewWidth - bubbleWidth - bubbleMarginMinimumSpacing;
        CGFloat indicatorMarginMaximumSpacing = collectionViewWidth - indicatorWidth - indicatorMarginMinimumSpacing;
        
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMaximumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMaximumSpacing;
    }
    else {
        self.bubbleImageView.image = [bubbleImageFactory outgoingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
        
        self.bubbleImageViewRightHorizontalConstraint.constant = bubbleMarginMinimumSpacing;
        self.typingIndicatorImageViewRightHorizontalConstraint.constant = indicatorMarginMinimumSpacing;
    }
    
    [self setNeedsUpdateConstraints];
    
    // Configure correct color and (whether/not) animated
    [self setTypingIndicatorAnimated:animated ellipsisColor:ellipsisColor];
}

- (void) setTypingIndicatorEllipsisColor:(UIColor*) ellipsisColor
{
    self.typingIndicatorView1.backgroundColor = ellipsisColor;
    self.typingIndicatorView2.backgroundColor = ellipsisColor;
    self.typingIndicatorView3.backgroundColor = ellipsisColor;
}

- (void) setTypingIndicatorAnimated:(BOOL) animated ellipsisColor:(UIColor*) ellipsisColor
{
    // Configure Base Color
    [self setTypingIndicatorEllipsisColor:ellipsisColor];
    // Remove existing animator if exist
    if (self.animator) {
        [self.animator stopAnimating];
    }
    // If animated -> New Animator
    if (animated) {
        self.animator = [[JSQMessagesTypingIndicatorAnimator alloc] initWithTypingIndicatorView:self color:ellipsisColor];
        [self.animator startAnimating];
    }
}

@end
