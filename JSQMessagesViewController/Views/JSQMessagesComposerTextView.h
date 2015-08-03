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
 * A delegate used to forward custom notifications from `JSQMessagesComposerTextView`.
 */
@protocol JSQMessagesComposerTextViewDelegate <NSObject>
@optional
- (void)textView:(JSQMessagesComposerTextView *)textView didPasteWithSender:(id)sender;
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
 * A delegate that conforms to `JSQMessagesComposerTextViewDelegate`. The default value is `nil`.
 */
@property (strong, nonatomic) id<JSQMessagesComposerTextViewDelegate> composerDelegate;

/**
 *  Determines whether or not the text view contains text after trimming white space 
 *  from the front and back of its string.
 *
 *  @return `YES` if the text view contains text, `NO` otherwise.
 */
- (BOOL)hasText;

@end
