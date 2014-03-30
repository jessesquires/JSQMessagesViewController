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

FOUNDATION_EXPORT const CGFloat kJSQMessagesCollectionViewCellLabelHeightDefault;


@interface JSQMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, readonly) JSQMessagesCollectionView *collectionView;

@property (assign, nonatomic) BOOL springinessEnabled;

// A higher number is less bouncy, a lower number is more bouncy
@property (assign, nonatomic) NSUInteger springResistanceFactor;

@property (assign, nonatomic) CGFloat messageBubbleMinimumHorizontalPadding;

@property (assign, nonatomic) UIEdgeInsets messageBubbleTextContainerInsets;

@property (assign, nonatomic) CGSize avatarViewSize;

- (CGSize)messageBubbleSizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
