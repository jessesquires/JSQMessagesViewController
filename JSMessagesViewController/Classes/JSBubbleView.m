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

#define kMarginLeftRight 10.0f


@interface JSBubbleView()

- (void)setup;

- (void)addTextViewObservers;
- (void)removeTextViewObservers;

+ (CGSize)textSizeForText:(NSString *)txt type:(JSBubbleMessageType)type;
+ (CGSize)neededSizeForText:(NSString *)text type:(JSBubbleMessageType)type;
+ (CGFloat)neededHeightForText:(NSString *)text type:(JSBubbleMessageType)type;

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
            _textView.textContainerInset = UIEdgeInsetsMake(8.0f, 4.0f, 2.0f, 4.0f);
        }
        
        [self addTextViewObservers];
        
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
    //    _textView.font = font;
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
    
    if(self.type == JSBubbleMessageTypeNotification) {
        bubbleSize = [JSBubbleView neededSizeForAttributedText:self.textView.attributedText];
    } else {
        bubbleSize = [JSBubbleView neededSizeForText:self.textView.text type:self.type];
    }
    
    NSLog(@"Bubble Size: (%f, %f), %@", bubbleSize.width, bubbleSize.height, (self.type == JSBubbleMessageTypeNotification ? @"Notification" : @"Message"));
    
    if(self.type == JSBubbleMessageTypeNotification) {
        
        return CGRectIntegral((CGRect){kMarginLeftRight, kMarginTop, bubbleSize.width - (kMarginLeftRight*2), bubbleSize.height + (kMarginTop / 1.5)});
    }
    
    return CGRectIntegral(CGRectMake((self.type == JSBubbleMessageTypeOutgoing ? self.frame.size.width - bubbleSize.width - kMarginLeftRight : kMarginLeftRight),
                                     kMarginTop,
                                     bubbleSize.width,
                                     bubbleSize.height + (kMarginTop/1.5) ));
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
    
    CGRect textFrame = CGRectMake(textX,
                                  self.bubbleImageView.frame.origin.y,
                                  self.bubbleImageView.frame.size.width - (self.bubbleImageView.image.capInsets.right / 2.0f),
                                  self.bubbleImageView.frame.size.height - kMarginTop);
    
    self.textView.frame = CGRectIntegral(textFrame);
}

#pragma mark - Bubble view

+ (CGSize)textSizeForText:(NSString *)txt type:(JSBubbleMessageType)type
{
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width * .70f;
    
    CGFloat maxHeight = MAX([JSMessageTextView numberOfLinesForMessage:txt],
                         [txt js_numberOfLines]) * [JSMessageInputView textViewLineHeight];
    maxHeight += kJSAvatarImageSize;
    
    CGSize stringSize = [txt sizeWithFont:[[JSBubbleView appearance] font]
                        constrainedToSize:CGSizeMake(maxWidth, maxHeight)];
    
    return CGSizeMake(roundf(stringSize.width), roundf(stringSize.height));
}

+(CGSize)textSizeForAttributedText:(NSAttributedString *)attributedText {
    CGFloat maxWidth = [UIScreen mainScreen].applicationFrame.size.width - (kBubblePaddingRight * 2);
    
    CGRect boundingRect = [attributedText boundingRectWithSize:(CGSize){maxWidth, CGFLOAT_MAX} options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    return CGSizeMake(320.0, boundingRect.size.height);
}

+ (CGSize)neededSizeForText:(NSString *)text type:(JSBubbleMessageType)type
{
    CGSize textSize = [JSBubbleView textSizeForText:text type:type];
    
	return CGSizeMake(textSize.width + kBubblePaddingRight,
                      textSize.height + kPaddingTop + kPaddingBottom);
}

+ (CGSize)neededSizeForAttributedText:(NSAttributedString *)attributedText {
    CGSize attributedTextSize = [JSBubbleView textSizeForAttributedText:attributedText];
    
    return CGSizeMake(attributedTextSize.width, attributedTextSize.height + kPaddingTop + kPaddingBottom);
}

+ (CGFloat)neededHeightForText:(NSString *)text type:(JSBubbleMessageType)type
{
    CGSize size = [JSBubbleView neededSizeForText:text type:type];
    return size.height + kMarginTop + kMarginBottom;
}

+ (CGFloat)neededHeightForAttributedText:(NSAttributedString *)attributedText {
    CGSize size = [JSBubbleView neededSizeForAttributedText:attributedText];
    
    return size.height + kMarginTop + kMarginBottom;
}

@end