//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//  http://www.hexedbits.com
//
//
//  Originally based on work by Sam Soffes
//  https://github.com/soffes
//
//  SSMessagesViewController
//  https://github.com/soffes/ssmessagesviewcontroller
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

@property (weak, nonatomic) UITextView *textView;

- (void)setup;

- (CGSize)textSizeForText:(NSString *)txt;
- (CGSize)bubbleSizeForText:(NSString *)txt;

@end


@implementation JSBubbleView

#pragma mark - Setup

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)rect
                   bubbleType:(JSBubbleMessageType)bubleType
              bubbleImageView:(UIImageView *)bubbleImageView
{
    self = [super initWithFrame:rect];
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
}

#pragma mark - Setters

- (void)setType:(JSBubbleMessageType)newType
{
    _type = newType;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)newText
{
    self.textView.text = newText;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    self.textView.font = font;
    [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor
{
    self.textView.textColor = textColor;
    [self setNeedsDisplay];
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
    
    self.textView.frame = textFrame;
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
    
	return CGSizeMake(textSize.width + kBubblePaddingRight,
                      textSize.height + kPaddingTop + kPaddingBottom);
}

@end