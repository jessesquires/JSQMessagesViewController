//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

#import "JSQMessagesCollectionView.h"

#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"

#import "JSQMessagesTypingIndicatorFooterView.h"
#import "JSQMessagesLoadEarlierHeaderView.h"


@interface JSQMessagesCollectionView () <JSQMessagesLoadEarlierHeaderViewDelegate>

- (void)jsq_configureCollectionView;

@end


@implementation JSQMessagesCollectionView

#pragma mark - Initialization

- (void)jsq_configureCollectionView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    self.alwaysBounceVertical = YES;
    self.bounces = YES;
    
    [self registerNib:[JSQMessagesCollectionViewCellIncoming nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellIncoming cellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesCollectionViewCellOutgoing nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesTypingIndicatorFooterView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
          withReuseIdentifier:[JSQMessagesTypingIndicatorFooterView footerReuseIdentifier]];
    
    [self registerNib:[JSQMessagesLoadEarlierHeaderView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
          withReuseIdentifier:[JSQMessagesLoadEarlierHeaderView headerReuseIdentifier]];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self jsq_configureCollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self jsq_configureCollectionView];
}

#pragma mark - Typing indicator

- (JSQMessagesTypingIndicatorFooterView *)dequeueTypingIndicatorFooterViewIncoming:(BOOL)isIncoming
                                                                withIndicatorColor:(UIColor *)indicatorColor
                                                                       bubbleColor:(UIColor *)bubbleColor
                                                                      forIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesTypingIndicatorFooterView *footerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                 withReuseIdentifier:[JSQMessagesTypingIndicatorFooterView footerReuseIdentifier]
                                                                                        forIndexPath:indexPath];
    
    [footerView configureForIncoming:isIncoming
                      indicatorColor:indicatorColor
                         bubbleColor:bubbleColor
                      collectionView:self];
    
    return footerView;
}

#pragma mark - Load earlier messages header

- (JSQMessagesLoadEarlierHeaderView *)dequeueLoadEarlierMessagesViewHeaderForIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesLoadEarlierHeaderView *headerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                             withReuseIdentifier:[JSQMessagesLoadEarlierHeaderView headerReuseIdentifier]
                                                                                    forIndexPath:indexPath];
    headerView.delegate = self;
    return headerView;
}

#pragma mark - Load earlier messages header delegate

- (void)headerView:(JSQMessagesLoadEarlierHeaderView *)headerView didPressLoadButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(collectionView:header:didTapLoadEarlierMessagesButton:)]) {
        [self.delegate collectionView:self header:headerView didTapLoadEarlierMessagesButton:sender];
    }
}

#pragma mark - Messages collection view cell delegate

- (void)messagesCollectionViewCellDidTapAvatar:(JSQMessagesCollectionViewCell *)cell
{
    [self.delegate collectionView:self
            didTapAvatarImageView:cell.avatarImageView
                      atIndexPath:[self indexPathForCell:cell]];
}

- (void)messagesCollectionViewCellDidTapMessageBubble:(JSQMessagesCollectionViewCell *)cell
{
    [self.delegate collectionView:self didTapMessageBubbleAtIndexPath:[self indexPathForCell:cell]];
}

- (void)messagesCollectionViewCellDidTapCell:(JSQMessagesCollectionViewCell *)cell atPosition:(CGPoint)position
{
    [self.delegate collectionView:self
            didTapCellAtIndexPath:[self indexPathForCell:cell]
                    touchLocation:position];
}

@end
