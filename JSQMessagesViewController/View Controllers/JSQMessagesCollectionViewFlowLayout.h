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
@class JSQMessagesCollectionViewFlowLayout;


@protocol JSQMessagesCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required
- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                         layout:(JSQMessagesCollectionViewFlowLayout *)layout bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender;

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                         layout:(JSQMessagesCollectionViewFlowLayout *)layout avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender;

@optional

- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
                      layout:(JSQMessagesCollectionViewFlowLayout *)layout cellTopLabelTextForItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
                      layout:(JSQMessagesCollectionViewFlowLayout *)layout messageBubbleTopLabelTextForItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
                      layout:(JSQMessagesCollectionViewFlowLayout *)layout cellBottomLabelTextForItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                layout:(JSQMessagesCollectionViewFlowLayout *)layout configureItemAtIndexPath:(NSIndexPath *)indexPath
                sender:(NSString *)sender;

@end



@interface JSQMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<JSQMessagesCollectionViewFlowLayoutDelegate> delegate;

@end
