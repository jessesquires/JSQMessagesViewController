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
        _message = nil;

        
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
    [self.bubbleImageView setHidden:NO];
    [self.textView setHidden:YES];
    
    // If There is an image attached need to be displayed ..
    if (_attachedImageView) {
        
        [self.bubbleImageView setHidden:YES];
        self.bubbleImageView.frame = CGRectMake(self.bubbleImageView.frame.origin.x , self.bubbleImageView.frame.origin.y , self.bubbleImageView.frame.size.width , self.bubbleImageView.frame.size.height - kMarginTop + kMarginBottom);
        
        CGSize imageSize = [JSBubbleView neededSizeForImage:_attachedImageView.image];
        
        if (_message && _message.type == JSVideoMessage) {
            [self setPlayButtonOverlay];
        }
    
        int imageShift = (self.type == JSBubbleMessageTypeIncoming) ? 0 : (self.bubbleImageView.frame.size.width - imageSize.width);
        CGRect imageFrame = CGRectMake( self.bubbleImageView.frame.origin.x + imageShift,
                                       10,
                                       imageSize.width ,
                                       imageSize.height);
        self.attachedImageView.frame = imageFrame;
        
        
        
        if (imageSize.width > 0.01 && imageSize.height > 0.01) {
            UIImage* image = [JSBubbleImageViewFactory bubbleMediaMaskImageForType:self.type size:imageFrame.size];
            if (_attachedImageView.image) {
                _attachedImageView.image = [_attachedImageView.image js_imageMaskWithImage:image];
            }
            
        }
        
    }
    else
    {
        [self.textView setHidden:NO];
        
        CGFloat textX = self.bubbleImageView.frame.origin.x;
        
        if(self.type == JSBubbleMessageTypeIncoming) {
            textX += (self.bubbleImageView.image.capInsets.left / 2.0f);
        }else
        {
            textX += (self.bubbleImageView.image.capInsets.left / 4.0f);
        }
        
        CGRect textFrame = CGRectMake(textX,
                                      self.bubbleImageView.frame.origin.y + 2,
                                      self.bubbleImageView.frame.size.width - (self.bubbleImageView.image.capInsets.right / 2.0f),
                                      self.bubbleImageView.frame.size.height - kMarginTop);
        
        self.textView.frame = textFrame;
    }
}

#pragma mark - Bubble view

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
    
    int increaseInMessageHeight =  kPaddingTop + kPaddingBottom + kMarginBottom ;
    if (msg.type == JSTextMessage) {
        imageSize = CGSizeZero;
    }else{
        textSize = CGSizeZero;
        increaseInMessageHeight = kPaddingBottom + kPaddingTop;
    }
    
    // Check If there is an image attached , or It is Just a regular text Message.
    CGSize bubbleSize = CGSizeMake( MAX(imageSize.width, textSize.width)  + kBubblePaddingRight , round (imageSize.height + textSize.height) + increaseInMessageHeight );
    
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
            imageSize = CGSizeMake(maxWidth, round (actualImageSize.height * maxWidth / actualImageSize.width));
        }else{
            imageSize = actualImageSize;
        }
    }
    
    return imageSize;
}

@end