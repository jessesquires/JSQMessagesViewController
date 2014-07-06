//
//  JSQMessagesCollectionViewCellIncomingVideo.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

@protocol JSQMessagesActivityIndicator;

/**
 *  A `JSQMessagesCollectionViewCellIncomingVideo` object is a concrete instance of `JSQMessagesCollectionViewCell`
 *  that represents an incoming video message item.
 */
@interface JSQMessagesCollectionViewCellIncomingVideo : JSQMessagesCollectionViewCell

@property (weak, nonatomic, readonly) UIImageView *thumbnailImageView;

/**
 *  The overlay view on the `mediaImageView`. You can easily assign it a play button.
 *  Default is `nil`.
 */
@property (weak, nonatomic) UIView *overlayView;

@property (weak, nonatomic) UIView <JSQMessagesActivityIndicator> *activityIndicatorView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the `overlayView` of the cell.
 *  This gesture handles the tap event for the `overlayView` and notifies the cell's delegate.
 *  Return `nil` if the `overlayView` not set.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *overlayViewTapGestureRecognizer;

@end
