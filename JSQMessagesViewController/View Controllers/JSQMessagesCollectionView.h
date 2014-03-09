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

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView
           messageForItemAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface JSQMessagesCollectionView : UICollectionView

@property (weak, nonatomic) id<JSQMessagesCollectionViewDataSource> dataSource;

@end
