//
//  Created by Jesse Squires
//  http://www.jessesquires.com
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class JSQMessagesBubbleImageFactory;

NS_ASSUME_NONNULL_BEGIN

/**
 *  An instance of `JSQMessagesMediaViewBubbleImageMasker` is an object that masks
 *  media views for a `JSQMessageMediaData` object. Given a view, it will mask the view
 *  with a bubble image for an outgoing or incoming media view.
 *
 *  @see JSQMessageMediaData.
 *  @see JSQMessagesBubbleImageFactory.
 *  @see JSQMessagesBubbleImage.
 */
@interface JSQMessagesMediaViewBubbleImageMasker : NSObject

/**
 *  Returns the bubble image factory that the masker uses to mask media views.
 */
@property (strong, nonatomic, readonly) JSQMessagesBubbleImageFactory *bubbleImageFactory;

/**
 *  Creates and returns a new instance of `JSQMessagesMediaViewBubbleImageMasker`
 *  that uses a default instance of `JSQMessagesBubbleImageFactory`. The masker uses the `JSQMessagesBubbleImage`
 *  objects returned by the factory to mask media views.
 *
 *  @return An initialized `JSQMessagesMediaViewBubbleImageMasker` object.
 *
 *  @see JSQMessagesBubbleImageFactory.
 *  @see JSQMessagesBubbleImage.
 */
- (instancetype)init;

/**
 *  Creates and returns a new instance of `JSQMessagesMediaViewBubbleImageMasker`
 *  having the specified bubbleImageFactory. The masker uses the `JSQMessagesBubbleImage`
 *  objects returned by the factory to mask media views.
 *
 *  @param bubbleImageFactory An initialized `JSQMessagesBubbleImageFactory` object to use for masking media views. This value must not be `nil`.
 *
 *  @return An initialized `JSQMessagesMediaViewBubbleImageMasker` object.
 *
 *  @see JSQMessagesBubbleImageFactory.
 *  @see JSQMessagesBubbleImage.
 */
- (instancetype)initWithBubbleImageFactory:(JSQMessagesBubbleImageFactory *)bubbleImageFactory NS_DESIGNATED_INITIALIZER;

/**
 *  Applies an outgoing bubble image mask to the specified mediaView.
 *
 *  @param mediaView The media view to mask.
 */
- (void)applyOutgoingBubbleImageMaskToMediaView:(UIView *)mediaView;

/**
 *  Applies an incoming bubble image mask to the specified mediaView.
 *
 *  @param mediaView The media view to mask.
 */
- (void)applyIncomingBubbleImageMaskToMediaView:(UIView *)mediaView;

/**
 *  A convenience method for applying a bubble image mask to the specified mediaView.
 *  This method uses the default instance of `JSQMessagesBubbleImageFactory`.
 *
 *  @param mediaView  The media view to mask.
 *  @param isOutgoing A boolean value specifiying whether or not the mask should be for an outgoing or incoming view.
 *  Specify `YES` for outgoing and `NO` for incoming.
 */
+ (void)applyBubbleImageMaskToMediaView:(UIView *)mediaView isOutgoing:(BOOL)isOutgoing;

@end

NS_ASSUME_NONNULL_END
