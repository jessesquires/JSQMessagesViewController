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

#import <UIKit/UIKit.h>

@class JSQMessagesComposerTextView;

/**
 *  A delegate object used to notify the receiver of paste events from a `JSQMessagesComposerTextView`.
 */
@protocol JSQMessagesComposerTextViewPasteDelegate <NSObject>

/**
 *  Asks the delegate whether or not the `textView` can perform an action using the supplied sender.
 *
 *  @discussion Use this delegate method to enable actions not provided by a default `UITextView`. 
 *  For example, enable the `Paste` menu for images or other non-string values.
 *  Return `YES` to enable an action or `NO` to defer to the superclass implementation
 */
- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView canPerformAction:(SEL)action withSender:(id)sender;

/**
 *  Asks the delegate whether or not the `textView` should perform the paste: action
 *
 *  @discussion Use this delegate method to implement custom pasting behavior.
 *  Return `NO` if you paste the data yourself or wish to block the superclass implementation.
 */
- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender;

@end

/**
 *  An instance of `JSQMessagesComposerTextView` is a subclass of `UITextView` that is styled and used 
 *  for composing messages in a `JSQMessagesViewController`. It is a subview of a `JSQMessagesToolbarContentView`.
 */
@interface JSQMessagesComposerTextView : UITextView

/**
 *  The text to be displayed when the text view is empty. The default value is `nil`.
 */
@property (copy, nonatomic) NSString *placeHolder;

/**
 *  The color of the place holder text. The default value is `[UIColor lightGrayColor]`.
 */
@property (strong, nonatomic) UIColor *placeHolderTextColor;

/**
 *  The object that acts as the paste delegate of the text view.
 */
@property (weak, nonatomic) id<JSQMessagesComposerTextViewPasteDelegate> pasteDelegate;

/**
 *  Determines whether or not the text view contains text after trimming white space 
 *  from the front and back of its string.
 *
 *  @return `YES` if the text view contains text, `NO` otherwise.
 */
- (BOOL)hasText;

@end
