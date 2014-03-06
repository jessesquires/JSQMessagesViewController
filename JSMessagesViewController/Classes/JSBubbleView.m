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

#define kForegroundImageViewOffset 12.0f


@interface JSBubbleView()

- (void)setup;

- (void)addTextViewObservers;
- (void)removeTextViewObservers;

+ (CGSize)textSizeForText:(NSString *)txt type:(JSBubbleMessageType)type;
+ (CGSize)neededSizeForText:(NSString *)text type:(JSBubbleMessageType)type;
+ (CGFloat)neededHeightForText:(NSString *)text type:(JSBubbleMessageType)type;

@property (nonatomic, strong) UIImageView *avatarImageView;

@end


@implementation JSBubbleView

@synthesize font = _font;
@synthesize cachedBubbleFrameRect;

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
        
        UILabel *textView = [[UILabel alloc]init];
        textView.font = [UIFont systemFontOfSize:16.0f];
        textView.textColor = [UIColor blackColor];
        textView.userInteractionEnabled = YES;
        textView.backgroundColor = [UIColor clearColor];
        textView.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
        textView.numberOfLines = 0;
        [self addSubview:textView];
        [self bringSubviewToFront:textView];
        _textView = textView;
        
        UIImageView *foregroundImageView = [[UIImageView alloc]init];
        [self addSubview:foregroundImageView];
        [self bringSubviewToFront:foregroundImageView];
        _foregroundImageView = foregroundImageView;
        
        [self addTextViewObservers];
        
        //        NOTE: TODO: textView frame & text inset
        //        --------------------
        //        future implementation for textView frame
        //        in layoutSubviews : "self.textView.frame = textFrame;" is not needed
        //        when setting the property : "_textView.textContainerInset = UIEdgeInsetsZero;"
        //        unfortunately, this API is available in iOS 7.0+
        //        update after dropping support for iOS 6.0
        //        --------------------
        
        self.startWidth = NAN;
        self.subtractFromWidth = 0.0;
        self.cachedBubbleFrameRect = CGRectNull;
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

- (CGFloat)heightForSingleLine {
    NSAttributedString *singleLineString = [[NSAttributedString alloc] initWithString:@"."];
    CGSize bubbleSize = [JSBubbleView neededSizeForAttributedText:singleLineString];
    return bubbleSize.height;
}


- (CGRect)bubbleFrame
{
    if(CGRectIsNull(self.cachedBubbleFrameRect)) {
        
        CGSize bubbleSize;
        
        if(self.type == JSBubbleMessageTypeNotification) {
            bubbleSize = [JSBubbleView neededSizeForAttributedText:self.textView.attributedText];
            
            self.cachedBubbleFrameRect = CGRectIntegral((CGRect){kMarginLeftRight, kMarginTop, bubbleSize.width - (kMarginLeftRight*2), bubbleSize.height + (kMarginTop / 1.5)});
        } else {
            bubbleSize = [JSBubbleView neededSizeForText:self.textView.text type:self.type];
            self.cachedBubbleFrameRect = CGRectIntegral(CGRectMake((self.type == JSBubbleMessageTypeOutgoing ? self.frame.size.width - bubbleSize.width - kMarginLeftRight : kMarginLeftRight),
                                                                   kMarginTop,
                                                                   bubbleSize.width,
                                                                   bubbleSize.height + (kMarginTop/1.5) ));
        }
    }
    return self.cachedBubbleFrameRect;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bubbleImageViewFrame = [self bubbleFrame];
    bubbleImageViewFrame.size.width -= self.subtractFromWidth;
    
    self.bubbleImageView.frame = bubbleImageViewFrame;
    
    if(self.type == JSBubbleMessageTypeNotification) {
        // for arrows
        [self.foregroundImageView setFrame:(CGRect){self.bubbleImageView.frame.size.width - kForegroundImageViewOffset, 22.0, 4.0, 7.0}];
    }
    
    if(isnan(self.startWidth)) {
        self.startWidth = self.bubbleImageView.frame.size.width;
    }
    [self layoutTextViewFrame];
}

-(void)layoutTextViewFrame {
    
    CGFloat textX = self.bubbleImageView.frame.origin.x + (self.hasAvatar ? self.bubbleImageView.frame.size.height: 0);
    
    
    if(self.type == JSBubbleMessageTypeIncoming) {
        textX += (self.bubbleImageView.image.capInsets.left / 2.0f);
    }
    
    CGRect textFrame = CGRectMake(textX,
                                  self.bubbleImageView.frame.origin.y,
                                  self.bubbleImageView.frame.size.width - (self.bubbleImageView.image.capInsets.right / 2.0f) - kForegroundImageViewOffset - (self.hasAvatar ? self.bubbleImageView.frame.size.height: 0),
                                  self.bubbleImageView.frame.size.height - kMarginTop);
    
    // to make up for changing this to UILabel, we add/subtract based on this former line of code that only applied to UITextView:
    //_textView.textContainerInset = UIEdgeInsetsMake(8.0f, 4.0f, 2.0f, 4.0f);
    // for the insets...  some values had to change to make it work with UILabel.
    
    textFrame.origin.y += 4.0f;
    textFrame.origin.x += 8.0f;
    textFrame.size.width -= 8.0f;
    textFrame.size.height -= 2.0f;
    
    [self.textView setFrame:textFrame];
    
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
    CGFloat maxWidth = 269.0;  // this seems to be the magic number...  not sure exactly why, but it works for sizing.
    
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

#pragma mark - Instance methods
-(void)assignSubtractFromWidth:(CGFloat)value {
    if(isnan(self.startWidth)) { return; }
    
    self.subtractFromWidth = value;
    
    CGRect imageViewFrame = self.bubbleImageView.frame;
    imageViewFrame.size.width = self.startWidth - self.subtractFromWidth;
    
    self.bubbleImageView.frame = imageViewFrame;
    
    CGRect foregroundImageViewFrame = self.foregroundImageView.frame;
    foregroundImageViewFrame.size.width = self.startWidth - self.subtractFromWidth - kForegroundImageViewOffset;
    self.foregroundImageView.frame = foregroundImageViewFrame;
    
    [self layoutTextViewFrame];
    
}

- (void)configureAvatarView:(UIImageView *)imageview {
    
    [self.avatarImageView removeFromSuperview];
    
    CGFloat size = [self heightForSingleLine];
    
    self.avatarImageView = imageview;
    self.avatarImageView.hidden = !self.hasAvatar;
    self.avatarImageView.frame = CGRectMake(1, 1, size-2, size-2);
    self.avatarImageView.layer.cornerRadius = self.bubbleImageView.frame.size.height/2;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.backgroundColor = [UIColor redColor];
    
    [self.bubbleImageView addSubview:self.avatarImageView];
    
}

@end