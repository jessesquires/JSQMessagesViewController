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

@property (weak, nonatomic) IBOutlet UILabel *cellTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *bubbleTopLabel;
@property (weak, nonatomic) IBOutlet UIView *messageContainerView;
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;
@property (weak, nonatomic) IBOutlet UILabel *cellBottomLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTopLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleTopLabelHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellBottomLabelHeight;

#pragma mark - Class methods

+ (UINib *)nib;

+ (NSString *)cellReuseIdentifier;

@end
