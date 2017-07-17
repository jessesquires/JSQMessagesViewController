//
//  JSQMessagesEditCollectionOverlayView.h
//  Pods
//
//  Created by Aleksei Shevchenko on 5/22/16.
//
//

#import <UIKit/UIKit.h>

@class JSQMessagesEditCollectionOverlayView;

FOUNDATION_EXPORT const CGFloat kJSQMessagesEditCollectionOverlayViewIconHeight;



/**
 *  The `JSQMessagesLoadEarlierHeaderViewDelegate` defines methods that allow you to
 *  respond to interactions within the header view.
 */
@protocol JSQMessagesEditCollectionOverlayViewDelegate <NSObject>

@required

/**
 *  Tells the delegate that the loadButton has received a touch event.
 *
 *  @param headerView The header view that contains the sender.
 *  @param sender     The button that received the touch.
 */
- (void)editOverlayView:(JSQMessagesEditCollectionOverlayView *)overlayView activated:(BOOL)activated;

@end


/**
 *  The `JSQMessagesEditButtonDelegate` defines methods that allow you to
 *  customise the edit button styling.
 */
@protocol JSQMessagesEditButtonDelegate <NSObject>

@required

/**
 *  Asks the delegate for the active editing image
 *
 *  @return The string used to identify the reusable overlay view.
 */
- (UIImage *)editingActiveImage;

/**
 *  Asks the delegate for the inactive editing image
 *
 *  @return The string used to identify the reusable overlay view.
 */
- (UIImage *)editingInactiveImage;

/**
 *  Asks the delegate for the active editing color
 *
 *  @return The string used to identify the reusable overlay view.
 */
- (UIColor *)editingActiveColor;

/**
 *  Asks the delegate for the inactive editing color
 *
 *  @return The string used to identify the reusable overlay view.
 */
- (UIColor *)editingInactiveColor;

@end


@interface JSQMessagesEditCollectionOverlayView : UICollectionReusableView

/**
 *  Returns the `UINib` object initialized for the collection reusable view.
 *
 *  @return The initialized `UINib` object or `nil` if there were errors during
 *  initialization or the nib file could not be located.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify the reusable overlay view.
 *
 *  @return The string used to identify the reusable overlay view.
 */
+ (NSString *)editingReuseIdentifier;


/**
 *  The object that acts as the delegate of the editing overlay view.
 */
@property (weak, nonatomic) id<JSQMessagesEditCollectionOverlayViewDelegate, JSQMessagesEditButtonDelegate> delegate;


@property (nonatomic, strong) UIColor *activeColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *inactiveColor UI_APPEARANCE_SELECTOR;

/**
 *  Current state of overlay view
 */
@property (nonatomic, assign) BOOL isActive;

@property (nonatomic, strong) NSIndexPath *indexPath;

#pragma mark - Editing

/**
 *  Configures the receiver with the specified attributes for the given collection view.
 *  Call this method after dequeuing the overlay view.
 *
 *  @param inactiveIcon        UIImage for inactive state. This value must not be `nil`.
 *  @param activeIcon          UIImage for active state. This value must not be `nil`.
 *  @param shouldDisplayOnLeft Specifies whether the overlay displays on the left or right side of the cell when displayed.
 *  @param collectionView      The collection view in which the overlay view will appear. This value must not be `nil`.
 */
- (void)configureDisplayingOnLeft:(BOOL)shouldDisplayOnLeft
                         isActive:(BOOL)isActive
                forCollectionView:(UICollectionView *)collectionView;

@end
