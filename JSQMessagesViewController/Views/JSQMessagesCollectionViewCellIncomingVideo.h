//
//  JSQMessagesCollectionViewCellIncomingVideo.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellIncoming.h"

@interface JSQMessagesCollectionViewCellIncomingVideo : JSQMessagesCollectionViewCellIncoming


/**
 *  The overlay view on the `mediaImageView`. You can easily add a play button to here.
 *  Default is `nil`.
 */
@property (strong, nonatomic) IBOutlet UIView *overlayView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the `overlayView` of the cell.
 *  This gesture handles the tap event for the `overlayView` and notifies the cell's delegate.
 *  Default is `nil`.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *overlayViewTapGestureRecognizer;

/**
 *  Return the thumbnail for the video.
 */
@property (weak, nonatomic, readonly) UIImageView *mediaImageView;

@end
