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
@property (assign, nonatomic) NSUInteger cellTopLabelHeight;
@property (assign, nonatomic) NSUInteger messageBubbleTopLabelHeight;
@property (assign, nonatomic) NSUInteger cellBottomLabelHeight;

@end
