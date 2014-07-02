//
//  JSQMessagesCollectionViewCellOutgoingPhoto.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellOutgoing.h"

@interface JSQMessagesCollectionViewCellOutgoingPhoto : JSQMessagesCollectionViewCellOutgoing

/**
 *  Return the thumbnail for the photo.
 */
@property (weak, nonatomic, readonly) UIImageView *mediaImageView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the `mediaImageView` of the cell.
 *  This gesture handles the tap event for the `mediaImageView` and notifies the cell's delegate.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *mediaImageViewTapGestureRecognizer;

@end
