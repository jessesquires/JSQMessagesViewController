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
@protocol JSQMessagesActivityIndicator;

typedef void (^JSQMessagesCollectionViewDataSourceCompletionBlock)(UIImage *thumbnail);

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

/**
 *  Asks the data source for the size of the `playerView` for the incoming/outgoing audio
 *  message data item at indexPath in the collectionView.
 *
 *	@param collectionView The object representing the collection view requesting this information.
 *	@param indexPath      The index path that specifies the location of the item.
 *
 *  @discussion If you do not implement this method, the collection view uses the values of 
 *  `incomingAudioPlayerViewSize` or `outgoingAudioPlayerViewSize` in `JSQMessagesCollectionViewFlowLayout`
 *  to set the size of playerView instead. In other words, This method is higher priority than the
 *  `incomingAudioPlayerViewSize` and `outgoingAudioPlayerViewSize`.
 *
 *	@return The width and height of the `playerView`. You may return `CGSizeZero` from this method if you do not want
 *  the specified item to display an `playerView`.
 */
- (CGSize)collectionView:(JSQMessagesCollectionView *)collectionView sizeForAudioPlayerViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the audio player view display in the `playerView` for the incoming/outgoing audio
 *  message data item at indexPath in the collectionView.
 *
 *	@param collectionView The object representing the collection view requesting this information.
 *	@param indexPath      The index path that specifies the location of the item.
 *
 *	@return A configured view object. You may return `nil` from this method if you do not want
 *  the specified item to display an overlay view.
 */
- (UIView *)collectionView:(JSQMessagesCollectionView *)collectionView viewForAudioPlayerViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the video overlay view display in the `overlayView` for the incoming/outgoing video
 *  message data item at indexPath in the collectionView.
 *
 *	@param collectionView The object representing the collection view requesting this information.
 *	@param indexPath      The index path that specifies the location of the item.
 *
 *	@return A configured view object. You may return `nil` from this method if you do not want
 *  the specified item to display an overlay view.
 */
- (UIView *)collectionView:(JSQMessagesCollectionView *)collectionView viewForVideoOverlayViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the activity indicator view display in the `activityIndicatorView` for the incoming/outgoing photo
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured view object that conforms to the `JSQMessagesActivityIndicator` protocol. 
 *  You may return `nil` from this method if you do not want the specified item to display an activity indicator view.
 */
- (UIView <JSQMessagesActivityIndicator> *)collectionView:(JSQMessagesCollectionView *)collectionView
             viewForPhotoActivityIndicatorViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the activity indicator view display in the `activityIndicatorView` for the incoming/outgoing video
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured view object that conforms to the `JSQMessagesActivityIndicator` protocol.
 *  You may return `nil` from this method if you do not want the specified item to display an activity indicator view.
 */
- (UIView <JSQMessagesActivityIndicator> *)collectionView:(JSQMessagesCollectionView *)collectionView
             viewForVideoActivityIndicatorViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the activity indicator view display in the `activityIndicatorView` for the incoming/outgoing audio
 *  message data item at indexPath in the collectionView.
 *
 *  @param collectionView The object representing the collection view requesting this information.
 *  @param indexPath      The index path that specifies the location of the item.
 *
 *  @return A configured view object that conforms to the `JSQMessagesActivityIndicator` protocol.
 *  You may return `nil` from this method if you do not want the specified item to display an activity indicator view.
 */
- (UIView <JSQMessagesActivityIndicator> *)collectionView:(JSQMessagesCollectionView *)collectionView
             viewForAudioActivityIndicatorViewAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the image to display in the `thumbnailImageView` for the the incoming/outgoing
 *  photo message or incoming/outging video message.
 *
 *  @param collectionView  The object representing the collection view requesting this information.
 *  @param sourceURL       The url for the image
 *  @param indexPath       The index path that specifies the location of the item.
 *  @param completionBlock The completion block that the receiver must call when it has a source image ready.
 *
 *  @discussion For good performance, thumbnail image and `thumbnailImageView` should always be the same size.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView wantsThumbnailForURL:(NSURL *)sourceURL
thumbnailImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
       completionBlock:(JSQMessagesCollectionViewDataSourceCompletionBlock)completionBlock;

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
 *  @param collectionView  The collection view object that is notifying you of the tap event.
 *  @param avatarImageView The avatar image view that was tapped.
 *  @param indexPath       The index path of the item for which the avatar was tapped.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
 didTapAvatarImageView:(UIImageView *)avatarImageView
           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the thumbnail image view of a photo message cell at the specified 
 *  indexPath did receive a tap event.
 *
 *  @param collectionView The collection view object that is notifying you of the tap event.
 *  @param imageView      The thumbnail image view that was tapped.
 *  @param indexPath      The index path of the item for which the thumbnail image view was tapped.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
           didTapPhoto:(UIImageView *)imageView
           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the overlay view of a video message cell at the specified
 *  indexPath did receive a tap event.
 *
 *  @param collectionView  The collection view object that is notifying you of the tap event.
 *  @param videoURL        The video url that was tapped.
 *  @param indexPath       The index path of the item for which the overlay view was tapped.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
     didTapVideoForURL:(NSURL *)videoURL
           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the overlay view of a audio message cell at the specified
 *  indexPath did receive a tap event.
 *
 *  @param collectionView  The collection view object that is notifying you of the tap event.
 *  @param audioData       The audio data that was tapped.
 *  @param indexPath       The index path of the item for which the overlay view was tapped.
 *
 *  @note This method is higher priority than the `collectionView:didTapMediaAudioForURL:atIndexPath:`,
 *  If the message has a URL and data, will call this method,
 *  and the `collectionView:didTapMediaAudioForURL:atIndexPath:` will not be called.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
           didTapAudio:(NSData *)audioData
           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the overlay view of a audio message cell at the specified
 *  indexPath did receive a tap event.
 *
 *  @param collectionView  The collection view object that is notifying you of the tap event.
 *  @param audioURL        The audio url that was tapped.
 *  @param indexPath       The index path of the item for which the overlay view was tapped.
 */
- (void)collectionView:(JSQMessagesCollectionView *)collectionView
     didTapAudioForURL:(NSURL *)audioURL
           atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the collection view's header did receive a tap event.
 *
 *  @param collectionView The collection view object that is notifying you of the tap event.
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
