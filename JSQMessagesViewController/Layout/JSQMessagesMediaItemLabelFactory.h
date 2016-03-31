//
//  Created by Jesse Squires
//  http://www.jessesquires.com
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
//
//  Ideas for springy collection view layout taken from Ash Furrow
//  ASHSpringyCollectionView
//  https://github.com/AshFurrow/ASHSpringyCollectionView
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JSQMediaLabelPosition) {
    JSQMediaLabelPositionTop,
    JSQMediaLabelPositionLeft,
    JSQMediaLabelPositionBottom,
    JSQMediaLabelPositionRight
};

@interface JSQMessagesMediaItemLabelFactory : NSObject

/**
 * Creates and returns a new instance of `JSQMessagesMediaItemLabelFactory` that uses
 * default colors, effects, and frame+insets based on the location
 *
 * @return An initialized `JSQMessagesMediaItemLabelFactory` object if created successfully, `nil` otherwise.
 */
- (instancetype)initWithPosition:(JSQMediaLabelPosition)position;

/**
 * Convenience initializer that returns a new `JSQMessagesMediaItemLabelFactory`
 * configured for labels at the bottom of the media view (`JSQMediaLabelPositionBottom`)
 *
 * @return An initialized `JSQMessagesMediaItemLabelFactory` object if created successfully, `nil` otherwise.
 */
- (instancetype)init;

/**
 * Location to place the label subview.
 * Left and Right probably don't make sense unless using a custom label.
 * Defaults to JSQMediaLabelLocationBottom.
 */
@property (nonatomic) JSQMediaLabelPosition labelPosition;

/**
 * The font to use for text labels
 * Defaults to systemFontOfSize:16
 */
@property (assign, nonatomic) UIFont * labelFont;

/**
 *  The foreground color to use for text labels
 * Defaults to `blackColor`
 */
@property (assign, nonatomic) UIColor * labelTextColor;

/**
 *  The maximum width of a text label
 * Defaults to `0` (no maximum enforced, up to the media view width)
 */
@property (assign, nonatomic) CGFloat labelMaxWidth;

/**
 *  The maximum height of a text label
 * Defaults to `0` (no maximum enforced, up to the media view height)
 */
@property (assign, nonatomic) CGFloat labelMaxHeight;

/**
 *  The text label line break mode (if text is too long to fit)
 * Defaults to `NSLineBreakByTruncatingTail`
 */
@property (assign, nonatomic) NSLineBreakMode labelLineBreakMode;

/**
 *  The text label line break mode (if text is too long to fit)
 * Defaults to `NSTextAlignmentLeft` when position is Top or Bottom,
 * or to `NSTextAlignmentCenter` when position is Left or Right
 */
@property (assign, nonatomic) NSTextAlignment labelTextAlignment;

/**
 * Vertically center the text label when position is Top or Bottom
 * Defaults to `YES`
 */
@property (nonatomic) BOOL labelVerticalCenter;

/**
 * The background color to use for text labels
 * Defaults to `clearColor`. Other values may obscure blur/vibrancy effects
 */
@property (assign, nonatomic) UIColor * labelTextBackgroundColor;

/**
 * Insets to use for text labels
 * Defaults to `UIEdgeInsetsMake(4, 8, 8, 6)`.
 */
@property (assign, nonatomic) UIEdgeInsets labelTextInsets;

/**
 * Use blur effects under text labels.
 * Defaults to YES
 */
@property (nonatomic) BOOL useBlurEffect;

/**
 * Desired blur effect, if enabled.
 * Defaults to UIBlurEffectStyleExtraLight
 */
@property (nonatomic) UIBlurEffectStyle blurEffectStyle;

/**
 * Use vibrancy effects overtop of blur effects. Subviews must be `tintColorDidChange` aware to work properly.
 * Defaults to NO
 */
@property (nonatomic) BOOL useVibrancyEffect;

/**
 * Use blur and vibrancy effects settings for custom views.
 * Defaults to NO
 */
@property (nonatomic) BOOL useEffectsOnCustomViews;

/**
 * Add a text label using currently configured properties to the media view
 */
- (void)addLabel:(NSString*)text mediaView:(UIView *)mediaView;

/**
 * Add a custom view (using relevant properties) to the media view
 */
- (void)addCustomView:(UIView *)customView mediaView:(UIView *)mediaView;

@end
