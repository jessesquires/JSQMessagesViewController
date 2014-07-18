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

#import "JSQMessagesCollectionViewCell.h"

@protocol JSQMessagesActivityIndicator;

/**
 *  The `JSQMessagesCollectionViewVideoCell` is an abstract class that presents the content for a video message data item
 *  when that item is within the collection view’s visible bounds. The layout and presentation
 *  of cells is managed by the collection view and its corresponding layout object.
 *
 *  @warning Do not use it directly.
 */
@interface JSQMessagesCollectionViewVideoCell : JSQMessagesCollectionViewCell

/**
 *  The thumbnail image of the cell that displaying in the `thumbnailImageView`.
 *  The default value is `nil`.
 */
@property (strong, nonatomic) UIImage *thumbnailImage;

/**
 *  Returns the thumbnail image view of the cell that is responsible for displaying thumbnail images.
 */
@property (weak, nonatomic, readonly) UIImageView *thumbnailImageView;

/**
 *  The overlay view on the `mediaImageView`. You can easily assign it a play button.
 *  Default is `nil`.
 */
@property (weak, nonatomic) UIView *overlayView;

/**
 *  The activity indicator view of the cell that represents the `thumbnailImage` is loading.
 *  Default is `nil`.
 */
@property (weak, nonatomic) UIView <JSQMessagesActivityIndicator> *activityIndicatorView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the `overlayView` of the cell.
 *  This gesture handles the tap event for the `overlayView` and notifies the cell's delegate.
 *  Return `nil` if the `overlayView` not set.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *overlayViewTapGestureRecognizer;

@end
