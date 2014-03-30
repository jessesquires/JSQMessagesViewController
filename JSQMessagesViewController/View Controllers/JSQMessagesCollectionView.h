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

#import "JSQMessagesCollectionViewFlowLayout.h"

@class JSQMessagesCollectionView;

@protocol JSQMessageData;



@protocol JSQMessagesCollectionViewDataSource <UICollectionViewDataSource>

@required

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView
                      messageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                 sender:(NSString *)sender
                 bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                 sender:(NSString *)sender
                 avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView
                        sender:(NSString *)sender
                        attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView
                        sender:(NSString *)sender
                        attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView
                        sender:(NSString *)sender
                        attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

@end



@protocol JSQMessagesCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
           layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
           heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
           layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
           heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
           layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
           heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface JSQMessagesCollectionView : UICollectionView

@property (weak, nonatomic) id<JSQMessagesCollectionViewDataSource> dataSource;

@property (weak, nonatomic) id<JSQMessagesCollectionViewDelegateFlowLayout> delegate;

@property (strong, nonatomic) JSQMessagesCollectionViewFlowLayout *collectionViewLayout;

@end
