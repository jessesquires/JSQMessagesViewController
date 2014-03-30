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

@class JSQMessagesCollectionView;

@protocol JSQMessageData;


@protocol JSQMessagesCollectionViewDataSource <UICollectionViewDataSource>

@required
- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView
                      messageForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                 bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                 sender:(NSString *)sender;

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                 avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                 sender:(NSString *)sender;

/*
- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                 bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                 sender:(NSString *)sender;

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                 avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                 sender:(NSString *)sender;

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView
                        attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView
                        attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView
                        attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
              textForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
              textForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
              textForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

*/
@end



@interface JSQMessagesCollectionView : UICollectionView

@property (weak, nonatomic) id<JSQMessagesCollectionViewDataSource> dataSource;

@end
