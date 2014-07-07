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
 *  The `JSQMessagesCollectionViewAudioCell` is an abstract class that presents the content for a audio message data item
 *  when that item is within the collection view’s visible bounds. The layout and presentation
 *  of cells is managed by the collection view and its corresponding layout object.
 *
 *  @warning Do not use it directly.
 */
@interface JSQMessagesCollectionViewAudioCell : JSQMessagesCollectionViewCell

/**
 *  The player view of the cell that is responsible for displaying audio data infomation.
 *  Default is `nil`.
 */
@property (weak, nonatomic) UIView *playerView;

/**
 *  The activity indicator view of the cell that represents the `thumbnailImage` is loading.
 *  Default is `nil`.
 */
@property (weak, nonatomic) UIView <JSQMessagesActivityIndicator> *activityIndicatorView;

/**
 *  Returns the underlying gesture recognizer for tap gestures in the cell.
 *  This gesture handles the tap event for the cell and notifies the cell's delegate.
 */
@property (strong, nonatomic, readonly) UITapGestureRecognizer *audioTapGestureRecognizer;

@end
