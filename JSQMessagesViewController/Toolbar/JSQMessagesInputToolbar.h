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

@class JSQMessagesInputToolbar;
@class JSQMessagesToolbarContentView;

FOUNDATION_EXPORT const CGFloat kJSQMessagesInputToolbarHeightDefault;


@protocol JSQMessagesInputToolbarDelegate <UIToolbarDelegate>

@required
- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar
                 didSendText:(NSString *)text
                  fromSender:(NSString *)sender
                      onDate:(NSDate *)date;

// did press left bar button

// did press right bar button

@end



@interface JSQMessagesInputToolbar : UIToolbar

@property (weak, nonatomic) id<JSQMessagesInputToolbarDelegate> delegate;

@property (weak, nonatomic, readonly) JSQMessagesToolbarContentView *contentView;

- (void)toggleSendButtonEnabled;

// TODO: KVO listen for contentView leftBarButton and right. then set target: action: selector:

@end
