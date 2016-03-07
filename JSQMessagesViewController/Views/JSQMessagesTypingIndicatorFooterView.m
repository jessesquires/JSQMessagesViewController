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

#import "UIImage+JSQMessages.h"
#import "UIColor+JSQMessages.h"

const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight = 46.0f;

@interface JSQMessagesTypingIndicatorAnimator : NSObject
- (id) initWithTypingIndicatorView:(JSQMessagesTypingIndicatorFooterView*) view :(UIColor*) ellipsisColor;
@property (nonatomic, strong) JSQMessagesTypingIndicatorFooterView *typingView;
@property (nonatomic, strong) UIColor *ellipsisColor;
@property (nonatomic, assign) BOOL animating;
- (void) startAnimating;
- (void) stopAnimating;
@end

@interface JSQMessagesTypingIndicatorFooterView ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewRightHorizontalConstraint;
//
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView1;
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView2;
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView3;
// Animation
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
    [self setTypingIndicatorAnimated:animated :ellipsisColor];
}

- (void) setTypingIndicatorEllipsisColor:(UIColor*) ellipsisColor
{
    self.typingIndicatorView1.backgroundColor = ellipsisColor;
    self.typingIndicatorView2.backgroundColor = ellipsisColor;
    self.typingIndicatorView3.backgroundColor = ellipsisColor;
}

- (void) setTypingIndicatorAnimated:(BOOL) animated :(UIColor*) ellipsisColor
{
    // Configure Base Color
    [self setTypingIndicatorEllipsisColor:ellipsisColor];
    // Remove existing animator if exist
    if (self.animator) {
        [self.animator stopAnimating];
    }
    // If animated -> New Animator
    if (animated) {
        self.animator = [[JSQMessagesTypingIndicatorAnimator alloc] initWithTypingIndicatorView:self :ellipsisColor];
        [self.animator startAnimating];
    }
}

@end

@implementation JSQMessagesTypingIndicatorAnimator

- (id) initWithTypingIndicatorView:(JSQMessagesTypingIndicatorFooterView *)view :(UIColor*) ellipsisColor
{
    if (self = [self init]) {
        self.typingView = view;
        self.ellipsisColor = ellipsisColor;
        self.animating = NO;
        
        // Initialize Colors
        self.typingView.typingIndicatorView1.backgroundColor = ellipsisColor;
        self.typingView.typingIndicatorView2.backgroundColor = ellipsisColor;
        self.typingView.typingIndicatorView3.backgroundColor = ellipsisColor;
    }
    return self;
}

- (void) startAnimating
{
    self.animating = YES;
    [self startTypingIndicatorAnimating:self.ellipsisColor];
}

- (void) stopAnimating
{
    self.animating = NO;
}

// How long does each individual dot stay dark for?
#define kTypingIndicatorSingleDot_Darker_AnimationDuration 1.5f
// How long does it take to transition from one dark circle to another?
#define kTypingIndicatorSingleDot_TransitionTime 0.4f
// Darkening co-efficient
#define kTypingIndicatorAnimatedDot_Darkening_Coefficient 3.0f

- (void) startTypingIndicatorAnimating:(UIColor*) ellipseColor {
    [self startTypingIndicatorAnimating:0 :@[self.typingView.typingIndicatorView1, self.typingView.typingIndicatorView2, self.typingView.typingIndicatorView3] :ellipseColor :[ellipseColor jsq_colorByDarkeningColorWithValue:kTypingIndicatorAnimatedDot_Darkening_Coefficient]];
}

- (void) startTypingIndicatorAnimating:(int) typingIndex :(NSArray*)indicatorViews :(UIColor*)ellipseColor :(UIColor*)darkerEllipseColor {
    if (!self.animating) {
        // Exit
        return;
    }
    // Which one is dark now?
    __block int index = typingIndex % 3;
    int otherIndex1 = (index + 1) % 3;
    int otherIndex2 = (index + 2) % 3;
    
    __block UIView *darkerView = indicatorViews[index];
    __block UIView *lighterView1 = indicatorViews[otherIndex1];
    __block UIView *lighterView2 = indicatorViews[otherIndex2];
    
    [UIView animateWithDuration:kTypingIndicatorSingleDot_TransitionTime animations:^{
        // Darker
        darkerView.backgroundColor = darkerEllipseColor;
        // Lighter
        lighterView1.backgroundColor = ellipseColor;
        lighterView2.backgroundColor = ellipseColor;
        
    } completion:^(BOOL finished) {
        // Wait
        [UIView animateWithDuration:kTypingIndicatorSingleDot_Darker_AnimationDuration animations:^{
            // None
        } completion:^(BOOL finished) {
            [self startTypingIndicatorAnimating:++index :indicatorViews :ellipseColor :darkerEllipseColor];
        }];
    }];
}



@end


@implementation JSQMessagesTypingIndicatorCircleView

-(id) init {
    if (self = [super init]) {
        // Configure Circle
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    // Update Radius
    self.layer.cornerRadius = frame.size.height / 2.0f;
}

@end