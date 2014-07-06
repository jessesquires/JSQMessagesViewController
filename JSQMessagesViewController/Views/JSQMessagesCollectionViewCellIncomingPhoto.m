//
//  JSQMessagesCollectionViewCellIncomingPhoto.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellIncomingPhoto.h"

#import "UIView+JSQMessages.h"

@interface JSQMessagesCollectionViewCellIncomingPhoto ()

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewHeightConstraint;

@property (assign, nonatomic) CGSize activityIndicatorViewSize;

@property (strong, nonatomic, readwrite) UITapGestureRecognizer *thumbnailImageViewTapGestureRecognizer;


- (void)jsq_handleThumbnailImageViewTapped:(UITapGestureRecognizer *)tapGesture;
- (void)applyMask;

@end

@implementation JSQMessagesCollectionViewCellIncomingPhoto

@synthesize messageBubbleImageView = _messageBubbleImageView;

- (void)dealloc
{
    _thumbnailImageView = nil;
    _activityIndicatorView = nil;
    _activityIndicatorContainerView = nil;
    _thumbnailImageViewTapGestureRecognizer = nil;
}


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
    
    self.thumbnailImageView.userInteractionEnabled = YES;
    self.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.thumbnailImageView.clipsToBounds = YES;
    
    self.activityIndicatorContainerView.userInteractionEnabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleThumbnailImageViewTapped:)];
    [self.thumbnailImageView addGestureRecognizer:tap];
    self.thumbnailImageViewTapGestureRecognizer = tap;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.thumbnailImageView.backgroundColor = backgroundColor;
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
    [self.messageBubbleContainerView insertSubview:messageBubbleImageView belowSubview:self.thumbnailImageView];
    [self.messageBubbleContainerView jsq_pinAllEdgesOfSubview:messageBubbleImageView];
    [self setNeedsUpdateConstraints];
    
    _messageBubbleImageView = messageBubbleImageView;
    
    // Delay 0.1 seconds to wait for the completion of their frame set.
    // It should be optimized ,there should be a better way to do it.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self applyMask];
    });
}


#pragma mark - Custom Accessors

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


#pragma mark - Helper

- (void)applyMask
{
    if (!self.thumbnailImageView.layer.mask) {
        CALayer *layer = self.messageBubbleImageView.layer;
        layer.bounds = self.thumbnailImageView.frame;
        self.thumbnailImageView.layer.mask = layer;
    }
}


#pragma mark - Gesture recognizers

- (void)jsq_handleThumbnailImageViewTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.delegate messagesCollectionViewCellDidTapPhoto:self];
}


@end
