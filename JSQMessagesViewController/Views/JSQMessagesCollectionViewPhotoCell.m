//
//  Created by Vincent Sit
//  http://xuexuefeng.com
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

#import "JSQMessagesCollectionViewPhotoCell.h"

#import "UIView+JSQMessages.h"

@interface JSQMessagesCollectionViewPhotoCell ()

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activityIndicatorContainerViewHeightConstraint;

@property (assign, nonatomic) CGSize activityIndicatorViewSize;

@property (strong, nonatomic, readwrite) UITapGestureRecognizer *thumbnailImageViewTapGestureRecognizer;

- (void)jsq_handleThumbnailImageViewTapped:(UITapGestureRecognizer *)tapGesture;
- (void)applyMask;

@end

@implementation JSQMessagesCollectionViewPhotoCell

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
    if (!messageBubbleImageView) {
        [_messageBubbleImageView removeFromSuperview];
        _messageBubbleImageView = nil;
        return;
    }
    
    if (_messageBubbleImageView) {
        _messageBubbleImageView.image = messageBubbleImageView.image;
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self applyMask];
    });
}


#pragma mark - Custom Accessors

- (void)setThumbnailImage:(UIImage *)thumbnailImage
{
    if (_thumbnailImage != thumbnailImage) {
        self.thumbnailImageView.image = thumbnailImage;
        
        _thumbnailImage = thumbnailImage;
    }
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


#pragma mark - Helper

- (void)applyMask
{
    CALayer *layer = self.messageBubbleImageView.layer;
    layer.bounds = self.thumbnailImageView.frame;
    self.thumbnailImageView.layer.mask = layer;
}


#pragma mark - Gesture recognizers

- (void)jsq_handleThumbnailImageViewTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.delegate messagesCollectionViewCellDidTapPhoto:self];
}

@end
