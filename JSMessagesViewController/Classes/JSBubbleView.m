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

#import "JSBubbleView.h"

#import "JSMessageInputView.h"
#import "JSAvatarImageFactory.h"
#import "NSString+JSMessagesView.h"

#define kMarginTop 8.0f
#define kMarginBottom 4.0f
#define kPaddingTop 4.0f
#define kPaddingBottom 8.0f
#define kBubblePaddingRight 35.0f


@interface JSBubbleView()

- (void)setup;

- (CGSize)textSizeForText:(NSString *)txt;
- (CGSize)bubbleSizeForText:(NSString *)txt;

- (CGSize)bubbleSizeForAttachedImage;
- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners;

@end


@implementation JSBubbleView

#pragma mark - Setup

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
                   bubbleType:(JSBubbleMessageType)bubleType
              bubbleImageView:(UIImageView *)bubbleImageView
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
        
        _type = bubleType;
        
        bubbleImageView.userInteractionEnabled = YES;
        [self addSubview:bubbleImageView];
        _bubbleImageView = bubbleImageView;
        
        UITextView *textView = [[UITextView alloc] init];
        textView.font = [UIFont systemFontOfSize:16.0f];
        textView.textColor = [UIColor blackColor];
        textView.editable = NO;
        textView.userInteractionEnabled = YES;
        textView.showsHorizontalScrollIndicator = NO;
        textView.showsVerticalScrollIndicator = NO;
        textView.scrollEnabled = NO;
        textView.backgroundColor = [UIColor clearColor];
        textView.contentInset = UIEdgeInsetsZero;
        textView.scrollIndicatorInsets = UIEdgeInsetsZero;
        textView.contentOffset = CGPointZero;
        textView.dataDetectorTypes = UIDataDetectorTypeAll;
        [self addSubview:textView];
        [self bringSubviewToFront:textView];
        _textView = textView;
        
        if([_textView respondsToSelector:@selector(textContainerInset)]) {
            _textView.textContainerInset = UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f);
        }
        
        _attachedImageView = nil;
        
//        NOTE: TODO: textView frame & text inset
//        --------------------
//        future implementation for textView frame
//        in layoutSubviews : "self.textView.frame = textFrame;" is not needed
//        when setting the property : "_textView.textContainerInset = UIEdgeInsetsZero;"
//        unfortunately, this API is available in iOS 7.0+
//        update after dropping support for iOS 6.0
//        --------------------
    }
    return self;
}

- (void)dealloc
{
    _bubbleImageView = nil;
    _textView = nil;
    
    [_attachedImageView removeFromSuperview];
    _attachedImageView = nil;
}

#pragma mark - Setters

- (void)setType:(JSBubbleMessageType)type
{
    _type = type;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    self.textView.text = text;
    [self setNeedsLayout];
}

- (void)setMessageImage:(UIImage *)image
{
    [_attachedImageView removeFromSuperview];
    _attachedImageView = nil;
    
    if (image) {
        _attachedImageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_attachedImageView];
        [self setNeedsLayout];
    }
    
}


- (void)setFont:(UIFont *)font
{
    self.textView.font = font;
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    self.textView.textColor = textColor;
    [self setNeedsLayout];
}

#pragma mark - Getters

- (NSString *)text
{
    return self.textView.text;
}

- (UIFont *)font
{
    return self.textView.font;
}

- (UIColor *)textColor
{
    return self.textView.textColor;
}

- (CGRect)bubbleFrame
{
    CGSize bubbleSize = [self bubbleSizeForText:self.textView.text];
    
    return CGRectMake((self.type == JSBubbleMessageTypeOutgoing ? self.frame.size.width - bubbleSize.width : 0.0f),
                      kMarginTop,
                      bubbleSize.width,
                      bubbleSize.height + kMarginTop);
}

- (CGFloat)neededHeightForCell;
{
    return [self bubbleSizeForText:self.textView.text].height + kMarginTop + kMarginBottom;
}

- (BOOL)isImageMessage
{
    return (_attachedImageView != nil);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bubbleImageView.frame = [self bubbleFrame];
    
    CGFloat textX = self.bubbleImageView.frame.origin.x;
    
    if(self.type == JSBubbleMessageTypeIncoming) {
        textX += (self.bubbleImageView.image.capInsets.left / 2.0f);
    }
    
    int imageSmallShift = (self.type == JSBubbleMessageTypeIncoming) ? 3 : -3;
    
    CGRect textFrame = CGRectMake(textX,
                                  self.bubbleImageView.frame.origin.y,
                                  self.bubbleImageView.frame.size.width - (self.bubbleImageView.image.capInsets.right / 2.0f),
                                  self.bubbleImageView.frame.size.height - kMarginTop);
    
    self.textView.frame = textFrame;
    [self.textView setHidden:NO];
    
    // If There is an image attached need to be displayed ..
    if (_attachedImageView) {

        CGRect imageFrame = CGRectMake( self.bubbleImageView.frame.origin.x + imageSmallShift + round( (self.bubbleImageView.frame.size.width /2 ) - ( _attachedImageView.frame.size.width / 2.0 ) ),
                                       17,
                                       _attachedImageView.frame.size.width,
                                       _attachedImageView.frame.size.height);
        
        self.attachedImageView.frame = imageFrame;
        // Set rounded Corners for Image Message View
        [self setMaskTo:_attachedImageView byRoundingCorners:UIRectCornerAllCorners ];
        
        
        [self.textView setHidden:YES];
        [self addSubview:_attachedImageView];
    }
    
}

#pragma mark - Bubble view

- (CGSize)textSizeForText:(NSString *)txt
{
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
    CGFloat maxHeight = MAX([JSMessageTextView numberOfLinesForMessage:txt],
                         [txt js_numberOfLines]) * [JSMessageInputView textViewLineHeight];
    maxHeight += kJSAvatarImageSize;
    
    return [txt sizeWithFont:self.textView.font
           constrainedToSize:CGSizeMake(maxWidth, maxHeight)];
}

- (CGSize)bubbleSizeForText:(NSString *)txt
{
	CGSize textSize = [self textSizeForText:txt];
    CGSize imageSize = [self bubbleSizeForAttachedImage];
    
    // Check If there is an image attached , or It is Just a regular text Message.
    CGSize bubbleSize = (_attachedImageView) ? imageSize : textSize ;
    
	return CGSizeMake(bubbleSize.width + kBubblePaddingRight,
                      bubbleSize.height + kPaddingTop + kPaddingBottom);
}

- (CGSize)bubbleSizeForAttachedImage
{
    CGSize imageSize = CGSizeZero;
    if (_attachedImageView) {
        
        CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
        CGSize actualImageSize = _attachedImageView.image.size;
        if (actualImageSize.width > maxWidth ) {
            imageSize = CGSizeMake(maxWidth, actualImageSize.height * maxWidth / actualImageSize.width);
        }else{
            imageSize = actualImageSize;
        }
        
        [_attachedImageView setFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    }
    
    return imageSize;
}

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(IMAGE_BUBBLE_CORNER_SIZE_IN_PIXELS, IMAGE_BUBBLE_CORNER_SIZE_IN_PIXELS)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

@end