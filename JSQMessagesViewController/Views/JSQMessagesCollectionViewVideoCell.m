//
//  Created by Vincent Sit
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

#import "JSQMessagesCollectionViewVideoCell.h"

#import "JSQMessagesCollectionViewLayoutAttributes.h"
#import "UIView+JSQMessages.h"

@interface JSQMessagesCollectionViewVideoCell ()

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorContainerView;
@property (weak, nonatomic) IBOutlet UIView *overlayContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overlayContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overlayContainerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewHeightConstraint;

@property (strong, nonatomic, readwrite) UITapGestureRecognizer *overlayViewTapGestureRecognizer;
@property (assign, nonatomic) CGSize overlayViewSize;
@property (assign, nonatomic) CGSize activityIndicatorViewSize;

- (void)jsq_handleOverlayViewTapped:(UITapGestureRecognizer *)tapGesture;
- (void)applyMask;

@end

@implementation JSQMessagesCollectionViewVideoCell

@synthesize messageBubbleImageView = _messageBubbleImageView;

- (void)dealloc
{
    _thumbnailImageView = nil;
    _overlayView = nil;
    _overlayContainerView = nil;
    _activityIndicatorView = nil;
    _activityIndicatorContainerView = nil;
    _overlayViewTapGestureRecognizer = nil;
}

#pragma mark - Overrides

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

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentLeft;
    self.cellBottomLabel.textAlignment = NSTextAlignmentLeft;
    
    self.longPressGestureRecognizer.enabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleOverlayViewTapped:)];
    [self.overlayContainerView addGestureRecognizer:tap];
    self.overlayViewTapGestureRecognizer = tap;
    
    self.activityIndicatorContainerView.userInteractionEnabled = NO;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    
    self.thumbnailImageView.backgroundColor = backgroundColor;
    self.overlayView.backgroundColor = backgroundColor;
    self.overlayContainerView.backgroundColor = backgroundColor;
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
    // It should be optimized , there should be a better way than this to do it.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self applyMask];
    });
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    self.overlayViewSize = customAttributes.incomingVideoOverlayViewSize;
    self.activityIndicatorViewSize = customAttributes.incomingVideoActivityIndicatorViewSize;
}


#pragma mark - Custom Accessors

- (void)setThumbnailImage:(UIImage *)thumbnailImage
{
    if (_thumbnailImage != thumbnailImage) {
        self.thumbnailImageView.image = thumbnailImage;
        
        _thumbnailImage = thumbnailImage;
    }
}

- (void)setOverlayView:(UIView *)overlayView
{
    if (_overlayView) {
        [_overlayView removeGestureRecognizer:self.overlayViewTapGestureRecognizer];
        [_overlayView removeFromSuperview];
    }
    
    if (!overlayView) {
        self.overlayViewSize = CGSizeZero;
        self.overlayViewTapGestureRecognizer = nil;
        _overlayView = nil;
        self.overlayContainerView.hidden = YES;
        return;
    }
    
    self.overlayContainerView.hidden = NO;
    self.overlayViewSize = overlayView.bounds.size;
    
    [overlayView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.overlayContainerView addSubview:overlayView];
    [self.overlayContainerView jsq_pinAllEdgesOfSubview:overlayView];
    [self setNeedsUpdateConstraints];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleOverlayViewTapped:)];
    [overlayView addGestureRecognizer:tap];
    self.overlayViewTapGestureRecognizer = tap;
    
    _overlayView = overlayView;
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

- (void)setOverlayViewSize:(CGSize)overlayViewSize
{
    if (CGSizeEqualToSize(overlayViewSize, self.overlayViewSize)) {
        return;
    }
    
    [self jsq_updateConstraint:self.overlayContainerViewWidthConstraint withConstant:overlayViewSize.width];
    [self jsq_updateConstraint:self.overlayContainerViewHeightConstraint withConstant:overlayViewSize.height];
}

- (CGSize)overlayViewSize
{
    return CGSizeMake(self.overlayContainerViewWidthConstraint.constant,
                      self.overlayContainerViewHeightConstraint.constant);
}

- (CGSize)activityIndicatorViewSize
{
    return CGSizeMake(self.activityIndicatorContainerViewWidthConstraint.constant,
                      self.activityIndicatorContainerViewHeightConstraint.constant);
}

#pragma mark - Helper

- (void)applyMask
{
    CALayer *layer = self.messageBubbleImageView.layer;
    layer.bounds = self.thumbnailImageView.frame;
    self.thumbnailImageView.layer.mask = layer;
}

#pragma mark - Gesture recognizers

- (void)jsq_handleOverlayViewTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.delegate messagesCollectionViewCellDidTapVideo:self];
}


@end
