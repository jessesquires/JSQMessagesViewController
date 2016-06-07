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

#import "JSQMessagesTypingView.h"

@interface JSQMessagesTypingView()

@property (strong, nonatomic, readonly) NSArray *colors;
@property (strong, nonatomic, readonly) CAKeyframeAnimation *fillColorAnimation;
@property (strong, nonatomic) CAShapeLayer *dot;

@end

@implementation JSQMessagesTypingView

#pragma mark Init override
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultInitialSetup];
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultInitialSetup];
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultInitialSetup];
        [self setup];
    }
    
    return self;
}

#pragma mark Setup
// Center points of dots on x axis are [2/7, 1/2, 5/7] of total view width.
// Size od dot is aprox ~7.125 times smaller than view width.
- (void)setup
{
    CGFloat dotDimension = self.frame.size.width / 7.125;
    CGFloat firstDotCenterX = 2 * self.frame.size.width / 7;
    CGFloat intervalBetweenDotsOnXAxis = 3.0 * self.frame.size.width / 14.0;
    
    CAReplicatorLayer *container = [[CAReplicatorLayer alloc] init];
    container.position = CGPointMake(self.layer.bounds.size.width / 2.0, self.layer.bounds.size.height / 2.0);
    container.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    container.instanceCount = 3;
    container.instanceTransform = CATransform3DMakeTranslation(intervalBetweenDotsOnXAxis, 0.0, 0.0);
    container.instanceDelay = self.animationDuration / 7.0;
    
    CAShapeLayer *dot = [[CAShapeLayer alloc] init];
    dot.position = CGPointMake(firstDotCenterX, container.bounds.size.height / 2.0);
    dot.bounds = CGRectMake(0, 0, dotDimension, dotDimension);
    dot.path = [UIBezierPath bezierPathWithOvalInRect:dot.bounds].CGPath;
    dot.fillColor = self.dotsColor.CGColor;
    self.dot = dot;
    
    [container addSublayer:dot];
    [self.layer addSublayer:container];
    
    [self updateAnimation];
}

- (void)defaultInitialSetup
{
    _animated = NO;
    _animationDuration = 1.33;
    _dotsColor = [UIColor lightGrayColor];
    _animateToColor = [UIColor grayColor];
}

- (void)updateAnimation
{
    self.animated = _animated;
}

#pragma mark Setters and Getters
- (CAKeyframeAnimation *)fillColorAnimation
{
    CAKeyframeAnimation *_fillColorAnimation = [CAKeyframeAnimation animation];
    _fillColorAnimation.keyPath = @"fillColor";
    _fillColorAnimation.values = self.colors;
    _fillColorAnimation.keyTimes = @[ @0, @(2/7.0), @(1/2.0), @(5/7.0), @1 ];
    _fillColorAnimation.duration = self.animationDuration;
    _fillColorAnimation.repeatCount = LONG_MAX;
    _fillColorAnimation.autoreverses = YES;
    
    return _fillColorAnimation;
}

- (NSArray *)colors
{
    return @[ (id)self.dotsColor.CGColor,
              (id)self.dotsColor.CGColor,
              (id)self.animateToColor.CGColor,
              (id)self.dotsColor.CGColor,
              (id)self.dotsColor.CGColor,
              ];
}

- (void)setAnimated:(BOOL)animated
{
    _animated = animated;
    
    [self.dot removeAnimationForKey:@"darkening"];
    
    if (animated) {
        [self.dot addAnimation:[self fillColorAnimation] forKey:@"darkening"];
    }
}

- (void)setDotsColor:(UIColor *)dotsColor
{
    _dotsColor = dotsColor;
    self.dot.fillColor = dotsColor.CGColor;
    [self updateAnimation];
}

- (void)setAnimateToColor:(UIColor *)animateToColor
{
    _animateToColor = animateToColor;
    [self updateAnimation];
}

@end