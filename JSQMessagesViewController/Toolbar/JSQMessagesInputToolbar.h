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
      didPressRightBarButton:(UIButton *)sender;

- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar
       didPressLeftBarButton:(UIButton *)sender;

@end



@interface JSQMessagesInputToolbar : UIToolbar

@property (weak, nonatomic) id<JSQMessagesInputToolbarDelegate> delegate;

@property (weak, nonatomic, readonly) JSQMessagesToolbarContentView *contentView;

@property (assign, nonatomic) BOOL sendButtonOnRight;

- (BOOL)hasText;

- (void)toggleSendButtonEnabled;

@end
