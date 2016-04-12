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

#import <UIKit/UIKit.h>
@class JSQCustomMediaView;
@class JSQMessage;

typedef void (^JSQCustomMediaViewTextPropertiesChangedBlock)(JSQCustomMediaView *view);

/**
 *  The JSQCustomMediaViewDelegate protocol defines methods that allow the custom view to
 *  pass messages back to its custom media item.
 */
@protocol JSQCustomMediaViewDelegate <NSObject>

@required

/**
 *  Informs the delegate that the custom view reqests a new size for it's collection view cell.
 *
 *  @param mediaView A pointer to this object.
 *  @param newSize The new size that the view is requesting for it's content.
 */
- (void)customMediaView:(JSQCustomMediaView *)mediaView contentSizeChanged:(CGSize)newSize;

@end

/**
 *  The JSQCustomMediaView class is a subclass of UIView and it (or a subclass of it) must be used to create a `JSQCustomMediaItem`.
 * 
 *  @discussion It is highly reccomended to use autolayout to position the subviews inside of the custom media view!
 *
 *  @see JSQHTMLMessageView for an example subclass.
 */
@interface JSQCustomMediaView : UIView

/**
 *  The default values to use for the layout margins. If a subclass needs different layout margins, this is
 *  the place to override and set those.
 */
+ (UIEdgeInsets)defaultLayoutMargins;

/**
 *  Set to true if a message bubble be included around the custom view. Default is true.
 */
@property (nonatomic) BOOL includeMessageBubble;

/**
 *  Holds the perferred font that text in the message bubble should use. Custom views should use this property
 *  to obtain the font for text in their views.
 */
@property (nonatomic, strong) UIFont *preferredFont;

/**
 *  Holds the preferred color that text inthe message bubble should use. Custom views should use this property to
 *  obtain the color for text in their views.
 */
@property (nonatomic, strong) UIColor *preferredTextColor;

/**
 *  A hash value used to reference stored cell information. If a stable hash value can be caluclated for your view,
 *  subclass and provide it. The default value is a random number.
 */
@property (nonatomic, readonly) NSUInteger hash;

/**
 *  The size that the view desires for it's content.
 */
@property (nonatomic, readonly) CGSize desiredContentSize;

/**
 *  Custom views can reqeust that their cell size is reevaluated, this delegate relays that request.
 */
@property (nonatomic, assign) id<JSQCustomMediaViewDelegate> delegate;

/**
 *  This block is called whenever the text properties (preferredFont or preferredTextColor) change. If not sublcassing
 *  this is critical in order to get the correct values of these properties as they are not usually available immediatly
 *  immediatly after initalization.
 */
@property (nonatomic, copy) JSQCustomMediaViewTextPropertiesChangedBlock textPropertiesChangedBlock;

/**
 *  This is a shortcut for generating a JSQMessage object. Optionally you can create the `JSQCustomMediaItem` and `JSQMessage`
 *  objects yourself but that is almost never needed.
 * 
 *  @param senderId The id of the sender
 *  @param displayName The display name of the sender
 */
- (JSQMessage *)generateMessageWithSenderId:(NSString *)senderId displayName:(NSString *)displayName;

/**
 *  This is a shortcut for generating a JSQMessage object. Optionally you can create the `JSQCustomMediaItem` and `JSQMessage`
 *  objects yourself but that is almost never needed.
 *
 *  @param senderId The id of the sender
 *  @param displayName The display name of the sender
 *  @param date The date of the message
 */
- (JSQMessage *)generateMessageWithSenderId:(NSString *)senderId displayName:(NSString *)displayName date:(NSDate *)date;

@end
