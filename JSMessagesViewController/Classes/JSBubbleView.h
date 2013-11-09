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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>
#import "JSBubbleImageViewFactory.h"

@interface JSBubbleView : UIView

@property (assign, nonatomic, readonly) JSBubbleMessageType type;
@property (weak, nonatomic, readonly) UIImageView *bubbleImageView;

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)rect
                   bubbleType:(JSBubbleMessageType)bubleType
              bubbleImageView:(UIImageView *)bubbleImageView;

#pragma mark - Setters

- (void)setText:(NSString *)newText;

- (void)setFont:(UIFont *)font;

- (void)setTextColor:(UIColor *)textColor;

#pragma mark - Getters

- (NSString *)text;

- (UIFont *)font;

- (UIColor *)textColor;

- (CGRect)bubbleFrame;

- (CGFloat)neededHeightForCell;

@end