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

@interface JSQMessagesCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) UILabel *cellTopLabel;
@property (weak, nonatomic, readonly) UILabel *messageBubbleTopLabel;
@property (weak, nonatomic, readonly) UITextView *textView;
@property (weak, nonatomic, readonly) UILabel *cellBottomLabel;

@property (weak, nonatomic) UIImageView *bubbleImageView;
@property (weak, nonatomic) UIImageView *avatarImageView;

@property (weak, nonatomic, readonly) UIView *messageBubbleContainerView;
@property (weak, nonatomic, readonly) UIView *avatarContainerView;

@property (weak, nonatomic, readonly) NSLayoutConstraint *cellTopLabelHeight;
@property (weak, nonatomic, readonly) NSLayoutConstraint *bubbleTopLabelHeight;

@property (weak, nonatomic, readonly) NSLayoutConstraint *avatarContainerViewWidth;
@property (weak, nonatomic, readonly) NSLayoutConstraint *avatarContainerViewHeight;
@property (weak, nonatomic, readonly) NSLayoutConstraint *cellBottomLabelHeight;

@property (strong, nonatomic) UIFont *font UI_APPEARANCE_SELECTOR;

#pragma mark - Class methods

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

@end
