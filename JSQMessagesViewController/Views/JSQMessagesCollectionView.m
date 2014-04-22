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

#import "JSQMessagesTypingIndicatorFooterView.h"


@implementation JSQMessagesCollectionView

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    [self registerNib:[JSQMessagesCollectionViewCellIncoming nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellIncoming cellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesCollectionViewCellOutgoing nib]
          forCellWithReuseIdentifier:[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]];
    
    [self registerNib:[JSQMessagesTypingIndicatorFooterView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
          withReuseIdentifier:[JSQMessagesTypingIndicatorFooterView footerReuseIdentifier]];
}

#pragma mark - Typing indicator

- (JSQMessagesTypingIndicatorFooterView *)dequeueTypingIndicatorFooterViewIncoming:(BOOL)isIncoming
                                                                withIndicatorColor:(UIColor *)indicatorColor
                                                                       bubbleColor:(UIColor *)bubbleColor
                                                                      forIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesTypingIndicatorFooterView *footerView = [super dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                 withReuseIdentifier:[JSQMessagesTypingIndicatorFooterView footerReuseIdentifier]
                                                                                        forIndexPath:indexPath];
    
    [footerView configureForIncoming:isIncoming
                      indicatorColor:indicatorColor
                         bubbleColor:bubbleColor
                      collectionView:self];
    
    return footerView;
}

@end
