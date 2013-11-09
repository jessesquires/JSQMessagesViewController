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
#import "JSBubbleView.h"

@interface JSBubbleMessageCell : UITableViewCell

@property (weak, nonatomic, readonly) JSBubbleView *bubbleView;
@property (weak, nonatomic, readonly) UILabel *timestampLabel;
@property (weak, nonatomic, readonly) UIImageView *avatarImageView;
@property (weak, nonatomic, readonly) UILabel *subtitleLabel;

#pragma mark - Initialization

- (instancetype)initWithBubbleType:(JSBubbleMessageType)type
                   bubbleImageView:(UIImageView *)bubbleImageView
                      hasTimestamp:(BOOL)hasTimestamp
                         hasAvatar:(BOOL)hasAvatar
                       hasSubtitle:(BOOL)hasSubtitle
                   reuseIdentifier:(NSString *)reuseIdentifier;

#pragma mark - Setters

- (void)setMessage:(NSString *)msg;

- (void)setTimestamp:(NSDate *)date;

- (void)setAvatarImageView:(UIImageView *)imageView;

- (void)setSubtitle:(NSString *)subtitle;

#pragma mark - Getters

- (JSBubbleMessageType)messageType;

- (CGFloat)height;

@end