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
#import "UIImage+JSMessagesView.h"

#define kMarginTop 8.0f
#define kMarginBottom 20.0f
#define kPaddingTop 2.0f
#define kPaddingBottom 8.0f
#define kBubblePaddingRight 35.0f

#define IMAGE_BUBBLE_CORNER_SIZE_IN_PIXELS 8.0f

@interface JSBubbleView()

- (void)setup;

- (void)addTextViewObservers;
- (void)removeTextViewObservers;

+ (CGSize)textSizeForText:(NSString *)txt;
+ (CGSize)neededSizeForText:(NSString *)text;

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners;

@end


@implementation JSBubbleView

@synthesize font = _font;

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
        textView.dataDetectorTypes = UIDataDetectorTypeNone;
        [self addSubview:textView];
        [self bringSubviewToFront:textView];
        _textView = textView;
        
        if([_textView respondsToSelector:@selector(textContainerInset)]) {
            _textView.textContainerInset = UIEdgeInsetsMake(6.0f, 4.0f, 2.0f, 4.0f);
        }
        
        [self addTextViewObservers];
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
    [self removeTextViewObservers];
    _bubbleImageView = nil;
    _textView = nil;
    
    [_attachedImageView removeFromSuperview];
    _attachedImageView = nil;
}

#pragma mark - KVO

- (void)addTextViewObservers
{
    [_textView addObserver:self
                forKeyPath:@"text"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
    
    [_textView addObserver:self
                forKeyPath:@"font"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
    
    [_textView addObserver:self
                forKeyPath:@"textColor"
                   options:NSKeyValueObservingOptionNew
                   context:nil];
}

- (void)removeTextViewObservers
{
    [_textView removeObserver:self forKeyPath:@"text"];
    [_textView removeObserver:self forKeyPath:@"font"];
    [_textView removeObserver:self forKeyPath:@"textColor"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == self.textView) {
        if([keyPath isEqualToString:@"text"]
           || [keyPath isEqualToString:@"font"]
           || [keyPath isEqualToString:@"textColor"]) {
            [self setNeedsLayout];
        }
    }
}

#pragma mark - Setters

- (void)setFont:(UIFont *)font
{
    _font = font;
    _textView.font = font;
}

- (void)setMessageImage:(UIImage *)image
{
    [_attachedImageView removeFromSuperview];
    _attachedImageView = nil;
    
    if (image) {
        _attachedImageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_attachedImageView];
        [self layoutSubviews];
    }
    
}

#pragma mark - UIAppearance Getters

- (UIFont *)font
{
    if (_font == nil) {
        _font = [[[self class] appearance] font];
    }
    
    if (_font != nil) {
        return _font;
    }
    
    return [UIFont systemFontOfSize:16.0f];
}

#pragma mark - Getters

- (CGRect)bubbleFrame
{
    CGSize bubbleSize = [JSBubbleView neededSizeForMessage:_message];
    
    return CGRectMake((self.type == JSBubbleMessageTypeOutgoing ? self.frame.size.width - bubbleSize.width : 0.0f),
                      kMarginTop,
                      bubbleSize.width,
                      bubbleSize.height + kMarginTop - kMarginBottom );
}

- (BOOL)isImageMessage
{
    return (_attachedImageView != nil);
}

-(void) setPlayButtonOverlay
{
    [_attachedImageView setImage:[[_attachedImageView.image js_imageResizeWithSize:_attachedImageView.frame.size] js_imageOverlayAPlayButtonAbove]];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bubbleImageView.frame = [self bubbleFrame];
    int imageSmallShift = (self.type == JSBubbleMessageTypeIncoming) ? 3 : -3;
    int imageHeightForDescribtion = 3.0f;
    
    // If There is an image attached need to be displayed ..
    if (_attachedImageView) {
        CGSize imageSize = [JSBubbleView neededSizeForImage:_attachedImageView.image];
        
        CGRect imageFrame = CGRectMake( self.bubbleImageView.frame.origin.x + imageSmallShift + round( (self.bubbleImageView.frame.size.width /2 ) - ( _attachedImageView.frame.size.width / 2.0 ) ),
                                       17,
                                       imageSize.width,
                                       imageSize.height);
        
        self.attachedImageView.frame = imageFrame;
        // Set rounded Corners for Image Message View
        [self setMaskTo:_attachedImageView byRoundingCorners:UIRectCornerAllCorners ];
        
        imageHeightForDescribtion = _attachedImageView.frame.size.height + 5;
        
        [self addSubview:_attachedImageView];
        
        if (_message && _message.type == JSVideoMessage) {
            [self setPlayButtonOverlay];
        }
    }
    
    
    CGFloat textX = self.bubbleImageView.frame.origin.x;
    
    if(self.type == JSBubbleMessageTypeIncoming) {
        textX += (self.bubbleImageView.image.capInsets.left / 2.0f);
    }else
    {
        textX += (self.bubbleImageView.image.capInsets.left / 4.0f);
    }
    
    CGRect textFrame = CGRectMake(textX,
                                  self.bubbleImageView.frame.origin.y + imageHeightForDescribtion,
                                  self.bubbleImageView.frame.size.width - (self.bubbleImageView.image.capInsets.right / 2.0f),
                                  self.bubbleImageView.frame.size.height - kMarginTop);
    
    self.textView.frame = textFrame;
}

#pragma mark - Bubble view


//- (CGSize)bubbleSizeForText:(NSString *)txt
//{
//	CGSize textSize = [self textSizeForText:txt];
//    CGSize imageSize = [self bubbleSizeForAttachedImage];
//    
//    // Check If there is an image attached , or It is Just a regular text Message.
//    CGSize bubbleSize = CGSizeMake( MAX(imageSize.width, textSize.width), round (imageSize.height + textSize.height));
//    
//	return CGSizeMake(bubbleSize.width + kBubblePaddingRight,
//                      bubbleSize.height + kPaddingTop + kPaddingBottom);
//}


+ (CGSize)textSizeForText:(NSString *)txt
{
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
    CGFloat maxHeight = MAX([JSMessageTextView numberOfLinesForMessage:txt],
                         [txt js_numberOfLines]) * [JSMessageInputView textViewLineHeight];
    maxHeight += kJSAvatarImageSize;
    
    return [txt sizeWithFont:[[JSBubbleView appearance] font]
           constrainedToSize:CGSizeMake(maxWidth, maxHeight)];
}

+ (CGSize)neededSizeForText:(NSString *)text
{
    CGSize textSize = [JSBubbleView textSizeForText:text];
    
	return CGSizeMake(textSize.width,
                      textSize.height);
}

+ (CGSize)neededSizeForMessage:(JSMessage*) msg
{
    CGSize textSize = [JSBubbleView neededSizeForText:msg.textMessage];
    CGSize imageSize = [JSBubbleView neededSizeForImage:msg.thumbnailImage];
    
    // Check If there is an image attached , or It is Just a regular text Message.
    CGSize bubbleSize = CGSizeMake( MAX(imageSize.width, textSize.width)  + kBubblePaddingRight , round (imageSize.height + textSize.height) + kPaddingTop + kPaddingBottom + kMarginBottom );
    
    return bubbleSize;
}

+ (CGSize) neededSizeForImage:(UIImage*) img
{
    CGSize imageSize = CGSizeZero;
    if (img) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:img];
        CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
        CGSize actualImageSize = imageView.image.size;
        if (actualImageSize.width > maxWidth ) {
            imageSize = CGSizeMake(maxWidth, actualImageSize.height * maxWidth / actualImageSize.width);
        }else{
            imageSize = actualImageSize;
        }
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