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

@property (readonly, nonatomic) JSQMessagesCollectionView *collectionView;

@property (assign, nonatomic) BOOL springinessEnabled;

// A higher number is less bouncy, a lower number is more bouncy
@property (assign, nonatomic) NSUInteger springResistanceFactor;

@property (readonly, nonatomic) CGFloat itemWidth;

@property (strong, nonatomic) UIFont *messageBubbleFont;

// more of a suggestion or recommendation to the layout
@property (assign, nonatomic) CGFloat messageBubbleLeftRightMargin;

// where right == avatar side, left = margin side
@property (assign, nonatomic) UIEdgeInsets messageBubbleTextViewFrameInsets;

@property (assign, nonatomic) UIEdgeInsets messageBubbleTextViewTextContainerInsets;

@property (assign, nonatomic) CGSize incomingAvatarViewSize;

@property (assign, nonatomic) CGSize outgoingAvatarViewSize;

- (CGSize)messageBubbleSizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
