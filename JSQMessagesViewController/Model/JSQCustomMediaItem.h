//
//  Created by Ryan Grimm
//  ryan@ryangrimm.com
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

#import "JSQMediaItem.h"
#import "JSQCustomMediaView.h"
@class JSQCustomMediaItem;

/**
 *  The JSQCustomMediaItemDelegate protocol defines methods that allow the custom media item and it's associated view to
 *  pass messages back to the messages view controller.
 */
@protocol JSQCustomMediaItemDelegate <NSObject>

@required

/**
 *  Informs the delegate that the custom view reqests a new size for it's collection view cell.
 *
 *  @param mediaItem A pointer to this object. Can be useful to find the specific cell that is displayin the media item.
 *  @param newSize The new size that the view is requesting for it's message bubble.
 */
- (void)customMediaItem:(JSQCustomMediaItem *)mediaItem customViewSizeChanged:(CGSize)newSize;

@end

/**
 *  The `JSQCustomMediaItem` class is a concrete `JSQMediaItem` subclass that implements
 *  the `JSQMessageMediaData` protocol
 *  and allows the user to provide a custom view for the message body. An initialized
 *  `JSQCustomMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQCustomMediaItem` to provide additional functionality or behavior
 *  but doing so is genearlly not needed.
 */
@interface JSQCustomMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying>

/**
 *  The view to be displayed.
 */
@property (nonatomic, strong) JSQCustomMediaView *customView;

/**
 *  The height of the view when the custom view is nil or when custom view's height is 0
 *  (defaults to 100 if unchanged).
 */
@property (nonatomic) CGFloat preferredDefaultHeight;

/**
 * The prefered text color that media view's should use.
 */
@property (nonatomic, strong) UIColor *preferredTextColor;

/**
 *  Custom media items can request that their collection view cell size is reevaluated,
 *  this delegate relays that request.
 */
@property (nonatomic, assign) id<JSQCustomMediaItemDelegate> delegate;

/**
 *  Initializes and returns a custom media item having the given view.
 *
 *  @param view   The view to be managed and displayed
 *
 *  @return An initialized `JSQCustomMediaView` if successful, `nil` otherwise.
 *
 *  @discussion If the view isn't ready to be displayed you may initalize a `JSQCustomMediaView`
 *  with a `nil` view. Once the view is ready to be displayed set the `customView` property.
 */
- (instancetype)initWithView:(JSQCustomMediaView *)view;


- (id)init NS_UNAVAILABLE;

@end
