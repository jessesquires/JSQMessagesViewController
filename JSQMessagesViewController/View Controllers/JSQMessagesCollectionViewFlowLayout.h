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
//
//
//  Initial code for springy collection view layout taken from Ash Furrow
//  ASHSpringyCollectionView
//
//  The MIT License
//  Copyright (c) 2013 Ash Furrow
//  https://github.com/AshFurrow/ASHSpringyCollectionView
//

#import <UIKit/UIKit.h>

@class JSQMessagesCollectionView;
@class JSQMessagesCollectionViewFlowLayout;


@protocol JSQMessagesCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required

@end



@interface JSQMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<JSQMessagesCollectionViewFlowLayoutDelegate> delegate;

@property (assign, nonatomic) BOOL springinessEnabled;

// A higher number is less bouncy, a lower number is more bouncy
@property (nonatomic, assign) NSUInteger springResistanceFactor;

@end
