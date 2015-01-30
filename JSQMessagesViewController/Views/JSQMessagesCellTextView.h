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
#import "TTTAttributedLabel.h"

/**
 *  `JSQMessagesCellTextView` is a subclass of `TTTAttributedLabel` that is used to display text
 *  in a `JSQMessagesCollectionViewCell`.
 */

@interface JSQMessagesCellTextView : TTTAttributedLabel

@property (atomic, readwrite) NSDictionary* linkTextAttributes;
@property (atomic, readwrite) BOOL selectable;
@property (atomic, readwrite) UIEdgeInsets textContainerInset;

@end
