//
//  JSQMessagesCollectionViewCellIncomingAudio.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellIncomingAudio.h"

#import "UIView+JSQMessages.h"

@interface JSQMessagesCollectionViewCellIncomingAudio ()

@property (weak, nonatomic) IBOutlet UIView *playerContainerView;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playerContainerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewHeightConstraint;

@property (strong, nonatomic, readwrite) UITapGestureRecognizer *audioTapGestureRecognizer;
@property (assign, nonatomic) CGSize activityIndicatorViewSize;
@property (assign, nonatomic) CGSize playerViewSize;

- (void)jsq_handleViewTapped:(UITapGestureRecognizer *)tapGesture;

@end

@implementation JSQMessagesCollectionViewCellIncomingAudio

@synthesize messageBubbleImageView = _messageBubbleImageView;

#pragma mark - Overrides

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentLeft;
    self.cellBottomLabel.textAlignment = NSTextAlignmentLeft;
    
    self.longPressGestureRecognizer.enabled = NO;
    
    self.activityIndicatorContainerView.userInteractionEnabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleViewTapped:)];
    [self addGestureRecognizer:tap];
    self.audioTapGestureRecognizer = tap;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.playerView.backgroundColor = backgroundColor;
    self.playerContainerView.backgroundColor = backgroundColor;
    self.activityIndicatorView.backgroundColor = backgroundColor;
    self.activityIndicatorContainerView.backgroundColor = backgroundColor;
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
    [self.messageBubbleContainerView addSubview:messageBubbleImageView];
    [self.messageBubbleContainerView jsq_pinAllEdgesOfSubview:messageBubbleImageView];
    [self setNeedsUpdateConstraints];
    
    _messageBubbleImageView = messageBubbleImageView;
}


#pragma mark - Custom Accessors

- (void)setPlayerView:(UIView *)playerView
{
    if (_playerView) {
        [_playerView removeFromSuperview];
    }
    
    if (!playerView) {
        self.playerViewSize = CGSizeZero;
        _playerView = nil;
        self.playerContainerView.hidden = YES;
        return;
    }
    
    self.playerContainerView.hidden = NO;
    self.playerViewSize = playerView.bounds.size;
    
    [playerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.playerContainerView addSubview:playerView];
    [self.playerContainerView jsq_pinAllEdgesOfSubview:playerView];
    [self setNeedsUpdateConstraints];
    
    _playerView = playerView;
}

- (void)setActivityIndicatorView:(UIView<JSQMessagesActivityIndicator> *)activityIndicatorView
{
    if (_activityIndicatorView) {
        [_activityIndicatorView removeFromSuperview];
    }
    
    if (!activityIndicatorView) {
        self.activityIndicatorViewSize = CGSizeZero;
        _activityIndicatorView = nil;
        self.activityIndicatorContainerView.hidden = YES;
        return;
    }
    
    self.activityIndicatorContainerView.hidden = NO;
    self.activityIndicatorViewSize = activityIndicatorView.bounds.size;
    
    [activityIndicatorView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.activityIndicatorContainerView addSubview:activityIndicatorView];
    [self.activityIndicatorContainerView jsq_pinAllEdgesOfSubview:activityIndicatorView];
    [self setNeedsUpdateConstraints];
    
    _activityIndicatorView = activityIndicatorView;
}

- (void)setActivityIndicatorViewSize:(CGSize)activityIndicatorViewSize
{
    if (CGSizeEqualToSize(activityIndicatorViewSize, self.activityIndicatorViewSize)) {
        return;
    }
    
    [self jsq_updateConstraint:self.activityIndicatorContainerViewWidthConstraint withConstant:activityIndicatorViewSize.width];
    [self jsq_updateConstraint:self.activityIndicatorContainerViewHeightConstraint withConstant:activityIndicatorViewSize.height];
}

- (CGSize)activityIndicatorViewSize
{
    return CGSizeMake(self.activityIndicatorContainerViewWidthConstraint.constant,
                      self.activityIndicatorContainerViewHeightConstraint.constant);
}


#pragma mark - Gesture recognizers

- (void)jsq_handleViewTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.delegate messagesCollectionViewCellDidTapAudio:self];
}

@end
