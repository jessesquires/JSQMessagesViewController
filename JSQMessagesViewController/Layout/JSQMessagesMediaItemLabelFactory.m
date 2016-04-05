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

#import "JSQMessagesMediaItemLabelFactory.h"

@implementation JSQMessagesMediaItemLabelFactory

- (instancetype)init {
    return [self initWithPosition:JSQMediaLabelPositionBottom];
}

- (instancetype)initWithPosition:(JSQMediaLabelPosition)position {
    self = [super init];
    if (self) {
        self.labelPosition = position;
        
        if (position == JSQMediaLabelPositionLeft) {
            self.labelTextInsets = UIEdgeInsetsMake(6, 8, 6, 6);
            self.labelTextAlignment = NSTextAlignmentCenter;
            self.labelVerticalCenter = YES;
        } else if (position == JSQMediaLabelPositionRight) {
            self.labelTextInsets = UIEdgeInsetsMake(6, 6, 6, 10);
            self.labelTextAlignment = NSTextAlignmentCenter;
            self.labelVerticalCenter = YES;
        } else { // JSQMediaLabelPositionTop, JSQMediaLabelPositionBottom
            self.labelTextInsets = UIEdgeInsetsMake(4, 8, 8, 6);
            self.labelTextAlignment = NSTextAlignmentLeft;
        }

        self.labelFont = [UIFont systemFontOfSize:16];
        self.labelTextColor = [UIColor blackColor];
        self.labelTextBackgroundColor = [UIColor clearColor];
        
        self.labelMaxWidth = 0;
        self.labelMaxHeight = 0;
        self.labelLineBreakMode = NSLineBreakByTruncatingTail;
        
        self.blurEffectStyle = UIBlurEffectStyleExtraLight;
        self.useBlurEffect = YES;
        self.useVibrancyEffect = NO;
        self.useEffectsOnCustomViews = NO;
    }
    return self;
}

- (void)addCustomView:(UIView *)customView mediaView:(UIView *)mediaView
{
    [self createLabel:customView
          onMediaView:mediaView
              addBlur:self.useEffectsOnCustomViews ? self.useBlurEffect : NO];
}

- (void)addLabel:(NSString*)text mediaView:(UIView *)mediaView
{

    UITextView * labelView = [[UITextView alloc] init];
    
    labelView.text = text;
    labelView.scrollEnabled = NO;
    labelView.font = self.labelFont;
    
    labelView.textColor = self.labelTextColor;
    labelView.backgroundColor = self.labelTextBackgroundColor;
    labelView.textAlignment = self.labelTextAlignment;
    labelView.textContainer.lineBreakMode = self.labelLineBreakMode;
    
    // constrain the width/height of the initial bounding rect according to maximum width/height
    CGSize constraintSize = mediaView.frame.size;
    if (self.labelMaxWidth)
        constraintSize.width = fmin(constraintSize.width, self.labelMaxWidth);
    if (self.labelMaxHeight)
        constraintSize.height = fmin(constraintSize.height, self.labelMaxHeight);
    
    // subtract text insets and the fragment padding that will affect line breaks
    constraintSize.width -= (self.labelTextInsets.left + self.labelTextInsets.right + (2 * labelView.textContainer.lineFragmentPadding));
    constraintSize.height -= (self.labelTextInsets.top + self.labelTextInsets.bottom);

    // calculate the actual text frame as determined by the constraintSize
    CGRect boundingRect = [text boundingRectWithSize:constraintSize
                                                  options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes: @{NSFontAttributeName : self.labelFont}
                                                  context: NULL];

    // build the final label frame, pinning the width or height according to the label orientation
    CGRect labelFrame = CGRectZero;
    if (self.labelPosition == JSQMediaLabelPositionLeft ||
        self.labelPosition == JSQMediaLabelPositionRight)
    {
        labelFrame.size.height = mediaView.frame.size.height;
        labelFrame.size.width = ceil(boundingRect.size.width +
                                     self.labelTextInsets.left + self.labelTextInsets.right +
                                     (2 *labelView.textContainer.lineFragmentPadding));
    } else {
        labelFrame.size.height = ceil(boundingRect.size.height +
                                      self.labelTextInsets.top + self.labelTextInsets.bottom);
        labelFrame.size.width = mediaView.frame.size.width;
    }
    
    // constrain the width/height of the final label rect
    if (self.labelMaxWidth && self.labelMaxWidth < labelFrame.size.width)
        labelFrame.size.width = fmin(labelFrame.size.width, self.labelMaxWidth);
    if (self.labelMaxHeight && self.labelMaxHeight < labelFrame.size.height)
        labelFrame.size.height = fmin(labelFrame.size.height, self.labelMaxHeight);
    
    // optional vertical centering of the label text
    if (self.labelVerticalCenter && boundingRect.size.height < labelFrame.size.height) {
        UIEdgeInsets textInsets = self.labelTextInsets;
        CGFloat slack = labelFrame.size.height - boundingRect.size.height - textInsets.top - textInsets.bottom;
        if (slack > 0)
            textInsets.top += round(slack / 2);
        labelView.textContainerInset = textInsets;
    } else {
        labelView.textContainerInset = self.labelTextInsets;
    }

    labelView.frame = labelFrame;

    [self createLabel:labelView onMediaView:mediaView addBlur:self.useBlurEffect];
}

#pragma mark -- Private

- (void)createLabel:(UIView *)labelView onMediaView:(UIView *)mediaView addBlur:(BOOL)addBlur
{
    // calculate a frame to put the label at the top or bottom of the view
    CGRect labelFrame = mediaView.bounds;
    if (self.labelPosition == JSQMediaLabelPositionTop) {
        labelFrame.size.height = labelView.frame.size.height;
    } else if (self.labelPosition == JSQMediaLabelPositionLeft) {
        labelFrame.size.width = labelView.frame.size.width;
    } else if (self.labelPosition == JSQMediaLabelPositionRight) {
        labelFrame.origin.x = labelFrame.size.width - labelView.frame.size.width;
        labelFrame.size.width = labelView.frame.size.width;
    } else { // JSQMediaLabelPositionBottom
        labelFrame.origin.y = labelFrame.size.height - labelView.frame.size.height;
        labelFrame.size.height = labelView.frame.size.height;
    }
    
    if (self.labelMaxWidth)
        labelFrame.size.width = fmin(labelFrame.size.width, self.labelMaxWidth);
    if (self.labelMaxHeight)
        labelFrame.size.height = fmin(labelFrame.size.height, self.labelMaxHeight);

    // add blur / vibrancy effects
    if (addBlur) {
        UIBlurEffect * blur = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
        UIVisualEffectView * blurView = [[UIVisualEffectView alloc]initWithEffect:blur];
        blurView.frame = labelFrame;
        labelView.frame = blurView.bounds;

        if (self.useVibrancyEffect) {
            UIVibrancyEffect * vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
            UIVisualEffectView * vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancy];
            vibrancyView.frame = blurView.bounds;
            [blurView.contentView addSubview:vibrancyView];
            [vibrancyView.contentView addSubview:labelView];
        } else {
            [blurView.contentView addSubview:labelView];
        }
        [mediaView addSubview:blurView];
    } else {
        labelView.frame = labelFrame;
        [mediaView addSubview:labelView];
    }
}

@end
