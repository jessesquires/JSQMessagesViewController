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

@class JSQMessagesCollectionView;
@class JSQMessagesTypingIndicatorFooterView;
@class JSQMessagesLoadEarlierHeaderView;

@protocol JSQMessageData;


/**
 *  An object that adopts the `JSQMessagesCollectionViewDataSource` protocol is responsible for providing the data and views
 *  required by a `JSQMessagesCollectionView`. The data source object represents your app’s messaging data model 
 *  and vends information to the collection view as needed.
 */
@protocol JSQMessagesCollectionViewDataSource <UICollectionViewDataSource>

@required

/**
 *  Asks the data source for the message sender, that is, the user who is sending messages.
 *
 *  @return An initialized string describing the sender. You must not return `nil` from this method.
 */
- (NSString *)sender;

/**
 *  Asks the data source for the message data that corresponds to the specified item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured object that conforms to the `JSQMessageData` protocol. You must not return `nil` from this method.
 */
- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView
                      messageDataForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the bubble image view that corresponds to the specified 
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured imageView object. You may return `nil` from this method if you do not 
 *  want the specified item to display a message bubble image.
 *
 *  @discussion It is recommended that you utilize `JSQMessagesBubbleImageFactory` to return valid imageViews. 
 *  However, you may provide your own.
 *  If providing your own bubble image view, please ensure the following:
 *      1. The imageView object must contain valid values for its `image` and `highlightedImage` properties.
 *      2. The images provided in the imageView must be stretchable images.
 *  Note that providing your own bubble image views will require additional configuration of the collectionView layout object.
 *
 *  @see `JSQMessagesBubbleImageFactory`.
 *  @see `JSQMessagesCollectionViewFlowLayout`.
 */
- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the avatar image view that corresponds to the specified
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured imageView object. You may return `nil` from this method if you do not want 
 *  the specified item to display an avatar.
 *
 *  @discussion It is recommended that you utilize `JSQMessagesAvatarFactory` to return a styled avatar image. 
 *  However, you may provide your own.
 *  Note that the size of the imageView is ignored. To specify avatar image view sizes, 
 *  set the appropriate properties on the collectionView's layout object.
 *
 *  @see `JSQMessagesAvatarFactory`.
 *  @see `JSQMessagesCollectionViewFlowLayout`.
 */
- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  Asks the data source for the text to display in the `cellTopLabel` for the specified
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the item at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the text to display in the `messageBubbleTopLabel` for the specified
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the item at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes. 
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the text to display in the `cellBottomLabel` for the the specified
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the item at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

@end


/**
 *  The `JSQMessagesCollectionViewDelegateFlowLayout` protocol defines methods that allow you to 
 *  manage additional layout information for the collection view and respond to additional actions on its items.
 *  The methods of this protocol are all optional.
 */
@protocol JSQMessagesCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional

/**
 *  Asks the delegate for the height of the `cellTopLabel` for the item at the specified indexPath.
 *
 *  @param collectionView       The collection view object displaying the flow layout.
 *  @param collectionViewLayout The layout object requesting the information.
 *  @param indexPath            The index path of the item.
 *
 *  @return The height of the `cellTopLabel` for the item at indexPath.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
           layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
           heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate for the height of the `messageBubbleTopLabel` for the item at the specified indexPath.
 *
 *  @param collectionView       The collection view object displaying the flow layout.
 *  @param collectionViewLayout The layout object requesting the information.
 *  @param indexPath            The index path of the item.
 *
 *  @return The height of the `messageBubbleTopLabel` for the item at indexPath.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
           layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
           heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate for the height of the `cellBottomLabel` for the item at the specified indexPath.
 *
 *  @param collectionView       The collection view object displaying the flow layout.
 *  @param collectionViewLayout The layout object requesting the information.
 *  @param indexPath            The index path of the item.
 *
 *  @return The height of the `cellBottomLabel` for the item at indexPath.
 *
 *  @see `JSQMessagesCollectionViewCell`.
 */
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
           layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout
           heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the avatar image view at the specified indexPath did receive a tap event.
 *
 *  @param collectionView  The collection view object that is notifying the delegate of the tap event.
 *  @param avatarImageView The avatar image view that was tapped.
 *  @param indexPath       The index path of the item for which the avatar was tapped.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
 didTapAvatarImageView:(UIImageView *)avatarImageView
           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the message bubble at the specified indexPath did receive a tap event.
 *
 *  @param collectionView The collection view object that is notifying the delegate of the tap event.
 *  @param indexPath      The index path of the item for which the message bubble was tapped.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the cell at the specified indexPath did receive a tap event at the specified touchLocation.
 *
 *  @param collectionView The collection view object that is notifying the delegate of the tap event.
 *  @param indexPath      The index path of the item for which the message bubble was tapped.
 *  @param touchLocation  The location of the touch event in the cell's coordinate system.
 *
 *  @warning This method is *only* called if position is *not* within the bounds of the cell's
 *  avatar image view or message bubble image view. In other words, this method is *not* called when the cell's
 *  avatar or message bubble are tapped. There are separate delegate methods for these two cases.
 *
 *  @see `collectionView:didTapAvatarImageView:atIndexPath:`
 *  @see `collectionView:didTapMessageBubbleAtIndexPath:atIndexPath:`
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
 didTapCellAtIndexPath:(NSIndexPath *)indexPath
         touchLocation:(CGPoint)touchLocation;

/**
 *  Notifies the delegate that the collection view's header did receive a tap event.
 *
 *  @param collectionView The collection view object that is notifying the delegate of the tap event.
 *  @param headerView     The header view in the collection view.
 *  @param sender         The button that was tapped.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
        header:(JSQMessagesLoadEarlierHeaderView *)headerView
        didTapLoadEarlierMessagesButton:(UIButton *)sender;

@end


/**
 *  The `JSQMessagesCollectionView` class manages an ordered collection of message data items and presents
 *  them using a specialized layout for messages.
 */
@interface JSQMessagesCollectionView : UICollectionView

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
