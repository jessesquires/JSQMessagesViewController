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
#define kMarginBetweenTextAndImage 4.0f


@interface JSBubbleView()

- (void)configureTextView;
- (void)configureImageView;

- (void)setup;

- (void)addTextViewObservers;
- (void)addImageViewObservers;
- (void)removeTextViewObservers;
- (void)removeImageViewObservers;

+ (CGSize)textSizeForText:(NSString *)txt;
+ (CGSize)imageSizeForImage:(UIImage *)image;
+ (CGSize)neededSizeForText:(NSString *)text;
+ (CGFloat)neededHeightForText:(NSString *)text;
+ (CGSize)neededSizeForImage:(UIImage *)image;

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
        
        [self configureTextView];
        [self configureImageView];
    }
    return self;
}

- (void)configureTextView
{
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
    
    //        NOTE: TODO: textView frame & text inset
    //        --------------------
    //        future implementation for textView frame
    //        in layoutSubviews : "self.textView.frame = textFrame;" is not needed
    //        when setting the property : "_textView.textContainerInset = UIEdgeInsetsZero;"
    //        unfortunately, this API is available in iOS 7.0+
    //        update after dropping support for iOS 6.0
    //        --------------------
    
    [self addTextViewObservers];
}

- (void)configureImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    [self bringSubviewToFront:imageView];
    _imageView = imageView;
    
    [self addImageViewObservers];
}

- (void)dealloc
{
    [self removeTextViewObservers];
    [self removeImageViewObservers];
    _bubbleImageView = nil;
    _textView = nil;
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

- (void)addImageViewObservers
{
    [_imageView addObserver:self
                 forKeyPath:@"image"
                    options:NSKeyValueObservingOptionNew
                    context:nil];
}

- (void)removeTextViewObservers
{
    [_textView removeObserver:self forKeyPath:@"text"];
    [_textView removeObserver:self forKeyPath:@"font"];
    [_textView removeObserver:self forKeyPath:@"textColor"];
}

- (void)removeImageViewObservers
{
    [_imageView removeObserver:self forKeyPath:@"image"];
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
    else if (object == self.imageView) {
        if([keyPath isEqualToString:@"image"]) {
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
    CGSize bubbleSize;
    if(self.imageView.image) {
        bubbleSize = [JSBubbleView neededSizeForImage:self.imageView.image];
    }
    else {
        bubbleSize = [JSBubbleView neededSizeForText:self.textView.text];
    }
    
    return CGRectMake((self.type == JSBubbleMessageTypeOutgoing ? self.frame.size.width - bubbleSize.width : 0.0f),
                      kMarginTop,
                      bubbleSize.width,
                      bubbleSize.height + kMarginTop);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bubbleImageView.frame = [self bubbleFrame];
    
    if(self.imageView.image) {
        
        CGSize imageSize = [JSBubbleView imageSizeForImage:self.imageView.image];
        
        CGFloat imageX = self.bubbleImageView.frame.origin.x + (self.bubbleImageView.frame.size.width - imageSize.width) / 2.0f;
        
        if(self.type == JSBubbleMessageTypeOutgoing) {
            imageX -= self.bubbleImageView.image.capInsets.left / 8.0f;
        }
        else {
            imageX += self.bubbleImageView.image.capInsets.left / 8.0f;
        }
        
        CGFloat imageY = self.bubbleImageView.frame.origin.y + (self.bubbleImageView.frame.size.height - imageSize.height) / 2.0f;
        
        CGRect imageFrame = CGRectMake(imageX,
                                       imageY,
                                       imageSize.width,
                                       imageSize.height);
        
        self.imageView.frame = imageFrame;
        self.textView.frame = CGRectZero;
    }
    else {
        CGFloat textX = self.bubbleImageView.frame.origin.x;
        if(self.type == JSBubbleMessageTypeIncoming) {
            textX += (self.bubbleImageView.image.capInsets.left / 2.0f);
        }
        
        CGRect textFrame = CGRectMake(textX,
                                      self.bubbleImageView.frame.origin.y,
                                      self.bubbleImageView.frame.size.width - (self.bubbleImageView.image.capInsets.right / 2.0f),
                                      self.bubbleImageView.frame.size.height - kMarginTop);
        
        self.textView.frame = textFrame;
        self.imageView.frame = CGRectZero;
    }
}

#pragma mark - Bubble view

+ (CGSize)textSizeForText:(NSString *)txt
{
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
    return [self textSizeForText:txt maxWidth:maxWidth];
}

+ (CGSize)imageSizeForImage: (UIImage *)image
{
    CGSize imageSize = [image size];
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * 0.70f;
    
    if(imageSize.width > maxWidth)
    {
        CGFloat ratio = maxWidth / imageSize.width;
        CGFloat scaledHeight = imageSize.height * ratio;
        
        return CGSizeMake(maxWidth, scaledHeight);
    }
    
    return CGSizeMake(imageSize.width,
                      imageSize.height);
}

+ (CGSize)textSizeForText:(NSString *)txt maxWidth:(CGFloat)maxWidth
{
    CGFloat maxHeight = MAX([JSMessageTextView numberOfLinesForMessage:txt],
                            [txt js_numberOfLines]) * [JSMessageInputView textViewLineHeight];
    maxHeight += kJSAvatarImageSize;
    
    return [txt sizeWithFont:[[JSBubbleView appearance] font]
           constrainedToSize:CGSizeMake(maxWidth, maxHeight)];
}

+ (CGSize)neededSizeForText:(NSString *)text
{
    CGSize textSize = [JSBubbleView textSizeForText:text];
    
	return CGSizeMake(textSize.width + kBubblePaddingRight,
                      textSize.height + kPaddingTop + kPaddingBottom);
}

+ (CGSize)neededSizeForImage:(UIImage *)image
{
    CGSize imageSize = [self imageSizeForImage:image];

    return CGSizeMake(imageSize.width + kBubblePaddingRight,
                      imageSize.height);
}

+ (CGFloat)neededHeightForText:(NSString *)text
{
    CGSize size = [JSBubbleView neededSizeForText:text];
    return size.height + kMarginTop + kMarginBottom;
}

+ (CGFloat)neededHeightForImage:(UIImage *)image
{
    return [self imageSizeForImage:image].height + kMarginTop + kMarginBottom;
}

@end