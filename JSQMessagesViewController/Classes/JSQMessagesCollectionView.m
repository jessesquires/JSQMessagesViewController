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

#import "JSQMessagesCollectionView.h"

#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"

@implementation JSQMessagesCollectionView

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self registerNib:[JSQMessagesCollectionViewCellIncoming nib] forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellIncoming cellReuseIdentifier]];
    [self registerNib:[JSQMessagesCollectionViewCellOutgoing nib] forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]];
    
    JSQMessagesCollectionViewFlowLayout *collectionViewLayout = (JSQMessagesCollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = 4.0f;
    CGFloat spacing = 4.0f;
    collectionViewLayout.itemSize = CGSizeMake(self.frame.size.width - (inset * 2.0f), 0.0f);
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    collectionViewLayout.minimumInteritemSpacing = spacing;
    collectionViewLayout.minimumLineSpacing = spacing;
}

@end
