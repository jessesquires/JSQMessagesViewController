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

@class JSQMessagesCollectionViewFlowLayout;


@protocol JSQMessagesCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@end



@interface JSQMessagesCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<JSQMessagesCollectionViewFlowLayoutDelegate> delegate;

@end
