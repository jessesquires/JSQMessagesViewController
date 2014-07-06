//
//  JSQMessagesActivityIndicatorView.m
//  JSQMessages
//
//  Created by Vincent Xue on 14-7-5.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesActivityIndicatorView.h"

@interface JSQMessagesActivityIndicatorView ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation JSQMessagesActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_activityIndicatorView];
        
        NSDictionary *variables = NSDictionaryOfVariableBindings(_activityIndicatorView, self);
        NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]-(<=1)-[_activityIndicatorView]"
                                                options: NSLayoutFormatAlignAllCenterX
                                                metrics:nil
                                                  views:variables];
        [self addConstraints:verticalConstraints];
        
        NSArray *horizontalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:[self]-(<=1)-[_activityIndicatorView]"
                                                options: NSLayoutFormatAlignAllCenterY
                                                metrics:nil
                                                  views:variables];
        [self addConstraints:horizontalConstraints];
    }
    return self;
}

- (void)startAnimation
{
    [self.activityIndicatorView startAnimating];
}

- (void)stopAnimation
{
    [self.activityIndicatorView stopAnimating];
}

- (BOOL)isAnimating
{
    return [self.activityIndicatorView isAnimating];
}

@end
