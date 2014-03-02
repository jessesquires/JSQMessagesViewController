//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

@class JSQMessagesToolbarContentView;

FOUNDATION_EXPORT const CGFloat kJSQMessagesInputToolbarHeightDefault;


@interface JSQMessagesInputToolbar : UIToolbar

@property (weak, nonatomic, readonly) JSQMessagesToolbarContentView *contentView;

@end
