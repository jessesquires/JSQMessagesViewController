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

@class JSQMessagesComposerTextView;

/**
 *  A constant value representing the default spacing to use for the left and right edges 
 *  of the toolbar content view.
 */
FOUNDATION_EXPORT const CGFloat kJSQMessagesToolbarContentViewHorizontalSpacingDefault;

/**
 *  A `JSQMessagesToolbarContentView` represents the content displayed in a `JSQMessagesInputToolbar`.
 *  These subviews consist of a left button, a text view, and a right button. One button is used as
 *  the send button, and the other as the accessory button. The text view is used for composing messages.
 */
@interface JSQMessagesToolbarContentView : UIView

/**
 *  Returns the text view in which the user composes a message.
 */
@property (weak, nonatomic, readonly) JSQMessagesComposerTextView *textView;

/**
 *  A custom button item displayed on the left of the toolbar content view.
 *
 *  @discussion The frame of this button is ignored. When you set this property, the button
 *  is fitted within a pre-defined default content view, whose height is determined by the
 *  height of the toolbar. You may specify a new width using `leftBarButtonItemWidth`.
 *  Set this value to `nil` to remove the button.
 */
@property (weak, nonatomic) UIButton *leftBarButtonItem;

/**
 *  Specifies the width of the leftBarButtonItem.
 */
@property (assign, nonatomic) CGFloat leftBarButtonItemWidth;

/**
 *  A custom button item displayed on the right of the toolbar content view.
 *
 *  @discussion The frame of this button is ignored. When you set this property, the button
 *  is fitted within a pre-defined default content view, whose height is determined by the
 *  height of the toolbar. You may specify a new width using `rightBarButtonItemWidth`.
 *  Set this value to `nil` to remove the button.
 */
@property (weak, nonatomic) UIButton *rightBarButtonItem;

/**
 *  Specifies the width of the rightBarButtonItem.
 */
@property (assign, nonatomic) CGFloat rightBarButtonItemWidth;

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for a `JSQMessagesToolbarContentView`.
 *
 *  @return The initialized `UINib` object or `nil` if there were errors during
 *  initialization or the nib file could not be located.
 */
+ (UINib *)nib;

@end
