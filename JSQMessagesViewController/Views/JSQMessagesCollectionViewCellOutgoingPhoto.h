//
//  JSQMessagesCollectionViewCellOutgoingPhoto.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

@protocol JSQMessagesActivityIndicator;

/**
 *  A `JSQMessagesCollectionViewCellOutgoingPhoto` object is a concrete instance of `JSQMessagesCollectionViewCell`
 *  that represents an outgoing photo message item.
 */
@interface JSQMessagesCollectionViewCellOutgoingPhoto : JSQMessagesCollectionViewCell

/**
 *  The thumbnail image view of the cell that is responsible for displaying thumbnail images.
 *  The default value is `nil`.
 */
@property (weak, nonatomic, readonly) UIImageView *thumbnailImageView;

@property (weak, nonatomic) UIView <JSQMessagesActivityIndicator> *activityIndicatorView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the `thumbnailImageView` of the cell.
 *  This gesture handles the tap event for the `thumbnailImageView` and notifies the cell's delegate.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *thumbnailImageViewTapGestureRecognizer;

@end
