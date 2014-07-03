//
//  JSQMessagesCollectionViewCellOutgoingVideo.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellOutgoingVideo.h"

#import "JSQMessagesCollectionViewLayoutAttributes.h"
#import "UIView+JSQMessages.h"

@interface JSQMessagesCollectionViewCellOutgoingVideo ()

@property (weak ,nonatomic, readwrite) IBOutlet UIImageView *mediaImageView;
@property (strong, nonatomic, readwrite) UITapGestureRecognizer *overlayViewTapGestureRecognizer;


- (void)jsq_handleOverlayViewTapped:(UITapGestureRecognizer *)tapGesture;
- (void)applyMask;

@end

@implementation JSQMessagesCollectionViewCellOutgoingVideo
@synthesize messageBubbleImageView = _messageBubbleImageView;

- (void)dealloc
{
    _mediaImageView = nil;
    _overlayViewTapGestureRecognizer = nil;
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
    
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentRight;
    self.cellBottomLabel.textAlignment = NSTextAlignmentRight;
    
    self.longPressGestureRecognizer.enabled = NO;
    
    self.mediaImageView.userInteractionEnabled = YES;
    self.mediaImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mediaImageView.clipsToBounds = YES;
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
    [self.messageBubbleContainerView insertSubview:messageBubbleImageView belowSubview:self.mediaImageView];
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
    
    if (![self.overlayView isEqual:customAttributes.outgoingVideoOverlayView]) {
        self.overlayView = customAttributes.outgoingVideoOverlayView;
    }
}

#pragma mark - Custom Accessors

- (void)setOverlayView:(UIView *)overlayView
{
    if (_overlayView) {
        [_overlayView removeGestureRecognizer:self.overlayViewTapGestureRecognizer];
        [_overlayView removeFromSuperview];
    }
    
    if (!overlayView) {
        self.overlayViewTapGestureRecognizer = nil;
        _overlayView = nil;
        return;
    }
    
    [overlayView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.messageBubbleContainerView addSubview:overlayView];
    [self.messageBubbleContainerView jsq_pinAllEdgesOfSubview:overlayView];
    [self setNeedsUpdateConstraints];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleOverlayViewTapped:)];
    [overlayView addGestureRecognizer:tap];
    self.overlayViewTapGestureRecognizer = tap;
    
    _overlayView = overlayView;
}

#pragma mark - Helper

- (void)applyMask
{
    CALayer *layer = self.messageBubbleImageView.layer;
    layer.bounds = self.mediaImageView.frame;
    self.mediaImageView.layer.mask = layer;
}

#pragma mark - Delegate

- (void)jsq_handleOverlayViewTapped:(UITapGestureRecognizer *)tapGesture
{
    [self.delegate messagesCollectionViewCellDidTapMediaVideo:self];
}

@end
