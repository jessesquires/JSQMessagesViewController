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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>
#import "JSBubbleMessageCell.h"
#import "JSMessageInputView.h"
#import "JSMessageSoundEffect.h"


typedef NS_ENUM(NSUInteger, JSMessagesViewTimestampPolicy) {
    JSMessagesViewTimestampPolicyAll,
    JSMessagesViewTimestampPolicyAlternating,
    JSMessagesViewTimestampPolicyEveryThree,
    JSMessagesViewTimestampPolicyEveryFive,
    JSMessagesViewTimestampPolicyCustom
};


typedef NS_ENUM(NSUInteger, JSMessagesViewAvatarPolicy) {
    JSMessagesViewAvatarPolicyAll,
    JSMessagesViewAvatarPolicyIncomingOnly,
    JSMessagesViewAvatarPolicyOutgoingOnly,
    JSMessagesViewAvatarPolicyNone
};


typedef NS_ENUM(NSUInteger, JSMessagesViewSubtitlePolicy) {
    JSMessagesViewSubtitlePolicyAll,
    JSMessagesViewSubtitlePolicyIncomingOnly,
    JSMessagesViewSubtitlePolicyOutgoingOnly,
    JSMessagesViewSubtitlePolicyNone
};


@protocol JSMessagesViewDelegate <NSObject>

@required
- (void)didSendText:(NSString *)text;

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath;

- (JSMessagesViewTimestampPolicy)timestampPolicy;
- (JSMessagesViewAvatarPolicy)avatarPolicy;
- (JSMessagesViewSubtitlePolicy)subtitlePolicy;

@optional
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling;
- (UIButton *)sendButtonForInputView;

@end



@protocol JSMessagesViewDataSource <NSObject>

@required
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface JSMessagesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) id<JSMessagesViewDelegate> delegate;
@property (weak, nonatomic) id<JSMessagesViewDataSource> dataSource;

@property (strong, nonatomic, readonly) JSMessageInputView *inputView;

#pragma mark - Messages view controller

- (void)finishSend;

- (void)setBackgroundColor:(UIColor *)color;

- (void)scrollToBottomAnimated:(BOOL)animated;

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
			  atScrollPosition:(UITableViewScrollPosition)position
					  animated:(BOOL)animated;

@end