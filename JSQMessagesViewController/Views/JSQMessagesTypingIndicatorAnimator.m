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

#import "JSQMessagesTypingIndicatorAnimator.h"

#import "UIColor+JSQMessages.h"

@interface JSQMessagesTypingIndicatorFooterView (Animatable)
//
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView1;
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView2;
@property (weak, nonatomic) IBOutlet UIView *typingIndicatorView3;

@end


@interface JSQMessagesTypingIndicatorAnimator()
@property (nonatomic, strong) JSQMessagesTypingIndicatorFooterView *typingView;
@property (nonatomic, strong) UIColor *ellipsisColor;
@property (nonatomic, assign) BOOL animating;
@end

@implementation JSQMessagesTypingIndicatorAnimator

- (instancetype) initWithTypingIndicatorView:(JSQMessagesTypingIndicatorFooterView *)view color:(UIColor*) ellipsisColor
{
    if (self = [self init]) {
        _typingView = view;
        _ellipsisColor = ellipsisColor;
        _animating = NO;
        
        // Initialize Colors
        _typingView.typingIndicatorView1.backgroundColor = ellipsisColor;
        _typingView.typingIndicatorView2.backgroundColor = ellipsisColor;
        _typingView.typingIndicatorView3.backgroundColor = ellipsisColor;
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
static const CGFloat kTypingIndicatorSingleDot_Darker_AnimationDuration = 1.5f;
// How long does it take to transition from one dark circle to another?
static const CGFloat kTypingIndicatorSingleDot_TransitionTime = 0.4f;
// Darkening co-efficient
static const CGFloat kTypingIndicatorAnimatedDot_Darkening_Coefficient = 3.0f;

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
