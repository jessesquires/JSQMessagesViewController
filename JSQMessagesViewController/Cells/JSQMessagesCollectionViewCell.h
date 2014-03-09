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

#import "JSQMessagesCollectionViewCellLabel.h"


FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellLabelHeightDefault;
FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellAvatarSizeDefault;
FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellMessageBubblePaddingDefault;
FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellMessageBubbleTopLabelHorizontalPaddingDefault;


@interface JSQMessagesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) JSQMessagesCollectionViewCellLabel *cellTopLabel;
@property (weak, nonatomic, readonly) JSQMessagesCollectionViewCellLabel *messageBubbleTopLabel;
@property (weak, nonatomic, readonly) JSQMessagesCollectionViewCellLabel *cellBottomLabel;

@property (weak, nonatomic, readonly) UITextView *textView;

@property (weak, nonatomic) UIImageView *messageBubbleImageView;
@property (weak, nonatomic) UIImageView *avatarImageView;

// if you change these properties below, you must compute your own cell height
@property (assign, nonatomic) CGFloat cellTopLabelHeight;
@property (assign, nonatomic) CGFloat messageBubbleTopLabelHeight;
@property (assign, nonatomic) CGFloat cellBottomLabelHeight;
@property (assign, nonatomic) CGFloat messageBubblePadding;

@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;

#pragma mark - Class methods

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

@end
