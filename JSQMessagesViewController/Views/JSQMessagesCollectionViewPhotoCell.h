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

#import "JSQMessagesCollectionViewCell.h"

@protocol JSQMessagesActivityIndicator;

/**
 *  The `JSQMessagesCollectionViewPhotoCell` is an abstract class that presents the content for a photo message data item
 *  when that item is within the collection view’s visible bounds. The layout and presentation
 *  of cells is managed by the collection view and its corresponding layout object.
 *
 *  @warning Do not use it directly.
 */
@interface JSQMessagesCollectionViewPhotoCell : JSQMessagesCollectionViewCell

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
 *  The activity indicator view of the cell that represents the `thumbnailImage` is loading.
 */
@property (weak, nonatomic) UIView <JSQMessagesActivityIndicator> *activityIndicatorView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the `thumbnailImageView` of the cell.
 *  This gesture handles the tap event for the `thumbnailImageView` and notifies the cell's delegate.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *thumbnailImageViewTapGestureRecognizer;

@end
