//
//  JSQMessagesMedia.m
//  JSQMessages
//
//  Created by Pierluigi Cifani on 17/6/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMessagesMediaHandler.h"
#import "JSQMessagesCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface JSQMessagesMediaHandler ()

@property (nonatomic, weak) JSQMessagesCollectionViewCell *cell;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;

@end

@implementation JSQMessagesMediaHandler

+ (instancetype)mediaHandlerWithCell:(id)cell
{
    JSQMessagesMediaHandler *instance = [self new];
    instance.cell = cell;
    return instance;
}

-(void)setCell:(JSQMessagesCollectionViewCell *)cell
{
    _cell = cell;
    
    cell.mediaImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.mediaImageView.clipsToBounds = YES;
}

- (void) setMediaFromImage:(UIImage *)image;
{
    self.cell.mediaImageView.image = image;
    [self maskImageViewWithBubble];
}

- (void) setMediaFromURL:(NSURL *)imageURL;
{
    [self addActitityIndicator];
    
    __weak __typeof(self) weakSelf = self;
    
    [self.cell.mediaImageView setImageWithURL:imageURL
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                        
                                        __typeof(self) strongSelf = weakSelf;
                                        [strongSelf maskImageViewWithBubble];
                                        [strongSelf removeActitityIndicator];
                                    }];
}

- (void) cellWillBeReused;
{
    self.cell.mediaImageView.image = nil;
    [self.cell.mediaImageView cancelCurrentImageLoad];
    [self removeActitityIndicator];
}

#pragma mark Private

- (void) maskImageViewWithBubble
{
    /**
     *  For the next snippet of code to work, the mediaImageView's frame
     *  must be the same as the messageBubbleImageView's frame
     */
    [self.cell.mediaImageView removeConstraints:self.cell.mediaImageView.constraints];
    [self.cell layoutIfNeeded];
    [self.cell.mediaImageView setFrame:self.cell.messageBubbleImageView.frame];
    
    /**
     *  Snippet from https://github.com/SocialObjects-Software/SOMessaging
     */
    CALayer *layer = self.cell.messageBubbleImageView.layer;
    layer.frame = (CGRect){{0,0},self.cell.messageBubbleImageView.layer.frame.size};
    self.cell.mediaImageView.layer.mask = layer;
    [self.cell.mediaImageView setNeedsDisplay];
}

- (void) addActitityIndicator
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.cell.messageBubbleImageView addSubview:activityIndicator];
    
    /**
     *  Center in superview
     */
    UIView *superview = self.cell.messageBubbleImageView;
    NSDictionary *variables = NSDictionaryOfVariableBindings(activityIndicator, superview);
    NSArray *constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:[superview]-(<=1)-[activityIndicator]"
                                            options: NSLayoutFormatAlignAllCenterX
                                            metrics:nil
                                              views:variables];
    [self.cell.contentView addConstraints:constraints];
    
    constraints =
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:[superview]-(<=1)-[activityIndicator]"
                                            options: NSLayoutFormatAlignAllCenterY
                                            metrics:nil
                                              views:variables];
    [self.cell.contentView addConstraints:constraints];
    
    [activityIndicator startAnimating];
    
    self.activityIndicator = activityIndicator;
}

- (void) removeActitityIndicator
{
    [self.activityIndicator removeFromSuperview];
    self.activityIndicator = nil;
}

@end
