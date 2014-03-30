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

@interface JSQMessagesCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>

@property (assign, nonatomic) CGSize messageBubbleSize;

@property (assign, nonatomic) CGFloat cellTopLabelHeight;

@property (assign, nonatomic) CGFloat messageBubbleTopLabelHeight;

@property (assign, nonatomic) CGFloat cellBottomLabelHeight;

@end
