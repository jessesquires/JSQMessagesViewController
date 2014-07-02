//
//  JSQMessagesCollectionViewCellOutgoingVideo.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

/**
 *  A `JSQMessagesCollectionViewCellOutgoingVideo` object is a concrete instance of `JSQMessagesCollectionViewCell`
 *  that represents an outgoing video message item.
 */
@interface JSQMessagesCollectionViewCellOutgoingVideo : JSQMessagesCollectionViewCell

/**
 *  Return the thumbnail for the video.
 */
@property (weak, nonatomic, readonly) UIImageView *mediaImageView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the `mediaImageView` of the cell.
 *  This gesture handles the tap event for the `mediaImageView` and notifies the cell's delegate.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *mediaImageViewTapGestureRecognizer;

@end
