//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessagesCollectionViewDelegateFlowLayout.h"
#import "JSQMessagesCollectionViewDataSource.h"
#import "JSQMessagesCollectionViewCell.h"

@class JSQMessagesTypingIndicatorFooterView;
@class JSQMessagesLoadEarlierHeaderView;


/**
 *  The `JSQMessagesCollectionView` class manages an ordered collection of message data items and presents
 *  them using a specialized layout for messages.
 */
@interface JSQMessagesCollectionView : UICollectionView <JSQMessagesCollectionViewCellDelegate>

/**
 *  The object that provides the data for the collection view.
 *  The data source must adopt the `JSQMessagesCollectionViewDataSource` protocol.
 */
@property (weak, nonatomic) id<JSQMessagesCollectionViewDataSource> dataSource;

/**
 *  The object that acts as the delegate of the collection view. 
 *  The delegate must adpot the `JSQMessagesCollectionViewDelegateFlowLayout` protocol.
 */
@property (weak, nonatomic) id<JSQMessagesCollectionViewDelegateFlowLayout> delegate;

/**
 *  The layout used to organize the collection view’s items.
 */
@property (strong, nonatomic) JSQMessagesCollectionViewFlowLayout *collectionViewLayout;

/**
 *  Returns a `JSQMessagesTypingIndicatorFooterView` object configured with the specified parameters.
 *
 *  @param isIncoming     Specifies whether the typing indicator should be displayed
 *                        for an incoming message or outgoing message.
 *  @param indicatorColor The color of the typing indicator ellipsis. This value must not be `nil`.
 *  @param bubbleColor    The color of the message bubble. This value must not be `nil`.
 *  @param indexPath      The index path specifying the location of the 
 *                        supplementary view in the collection view. This value must not be `nil`.
 *
 *  @return A valid `JSQMessagesTypingIndicatorFooterView` object.
 */
- (JSQMessagesTypingIndicatorFooterView *)dequeueTypingIndicatorFooterViewIncoming:(BOOL)isIncoming
                                                                withIndicatorColor:(UIColor *)indicatorColor
                                                                       bubbleColor:(UIColor *)bubbleColor
                                                                      forIndexPath:(NSIndexPath *)indexPath;
/**
 *  Returns a `JSQMessagesLoadEarlierHeaderView` object for the specified index path.
 *
 *  @param indexPath The index path specifying the location of the
 *                   supplementary view in the collection view. This value must not be `nil`.
 *
 *  @return A valid `JSQMessagesLoadEarlierHeaderView` object.
 */
- (JSQMessagesLoadEarlierHeaderView *)dequeueLoadEarlierMessagesViewHeaderForIndexPath:(NSIndexPath *)indexPath;

@end
