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

#import "JSBubbleMessageCell.h"

#import "UIColor+JSMessagesView.h"
#import "UIImage+JSMessagesAvatar.h"
#import "UIImage+JSMessagesBubble.h"

static const CGFloat kJSTimeStampLabelHeight = 14.5f;
static const CGFloat kJSSubtitleLabelHeight = 16.0f;


@interface JSBubbleMessageCell()

@property (strong, nonatomic) JSBubbleView *bubbleView;
@property (strong, nonatomic) UILabel *timestampLabel;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (assign, nonatomic) JSAvatarStyle avatarImageStyle;
@property (strong, nonatomic) UILabel *subtitleLabel;

- (void)setup;
- (void)configureTimestampLabel;

- (void)configureWithType:(JSBubbleMessageType)type
              bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
              avatarStyle:(JSAvatarStyle)avatarStyle
				 subtitle:(BOOL)hasSubtitle
                timestamp:(BOOL)hasTimestamp;

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress;

- (void)handleMenuWillHideNotification:(NSNotification *)notification;
- (void)handleMenuWillShowNotification:(NSNotification *)notification;

@end



@implementation JSBubbleMessageCell

#pragma mark - Setup

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.imageView.image = nil;
    self.imageView.hidden = YES;
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.detailTextLabel.text = nil;
    self.detailTextLabel.hidden = YES;
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(handleLongPress:)];
    [recognizer setMinimumPressDuration:0.4f];
    [self addGestureRecognizer:recognizer];
}

- (void)configureTimestampLabel
{
    _timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                4.0f,
                                                                self.bounds.size.width,
                                                                kJSTimeStampLabelHeight)];
    _timestampLabel.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    _timestampLabel.backgroundColor = [UIColor clearColor];
    _timestampLabel.textAlignment = NSTextAlignmentCenter;
    _timestampLabel.textColor = [UIColor js_messagesTimestampColor_iOS6];
    _timestampLabel.shadowColor = [UIColor whiteColor];
    _timestampLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _timestampLabel.font = [UIFont boldSystemFontOfSize:11.5f];
    
    [self.contentView addSubview:_timestampLabel];
    [self.contentView bringSubviewToFront:_timestampLabel];
}

- (void)configureWithType:(JSBubbleMessageType)type
              bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
              avatarStyle:(JSAvatarStyle)avatarStyle
				 subtitle:(BOOL)hasSubtitle
                timestamp:(BOOL)hasTimestamp
{
    CGFloat bubbleY = 0.0f;
    CGFloat bubbleX = 0.0f;
    
    if(hasTimestamp) {
        [self configureTimestampLabel];
        bubbleY = 14.0f;
    }
    
    CGFloat offsetX = 0.0f;
    
    if(avatarStyle != JSAvatarStyleNone) {
        offsetX = 4.0f;
        bubbleX = kJSAvatarSize;
        CGFloat avatarX = 0.5f;
        
        if(type == JSBubbleMessageTypeOutgoing) {
            avatarX = (self.contentView.frame.size.width - kJSAvatarSize);
            offsetX = kJSAvatarSize - 4.0f;
        }
        
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX,
                                                                             self.contentView.frame.size.height - kJSAvatarSize,
                                                                             kJSAvatarSize,
                                                                             kJSAvatarSize)];
        
        _avatarImageView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
                                                 | UIViewAutoresizingFlexibleLeftMargin
                                                 | UIViewAutoresizingFlexibleRightMargin);
		
        [self.contentView addSubview:_avatarImageView];
    }
    
    CGRect frame = CGRectMake(bubbleX - offsetX,
                              bubbleY,
                              self.contentView.frame.size.width - bubbleX,
                              self.contentView.frame.size.height - _timestampLabel.frame.size.height);
    
    _bubbleView = [[JSBubbleView alloc] initWithFrame:frame
                                           bubbleType:type
                                          bubbleStyle:bubbleStyle];
	
	if(hasSubtitle) {
        CGFloat subtitleXOffset = 15.0f;
        
		_subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(subtitleXOffset,
                                                                   bubbleY + frame.size.height - kJSSubtitleLabelHeight,
                                                                   frame.size.width - bubbleX - subtitleXOffset * 2,
                                                                   kJSSubtitleLabelHeight)];
		_subtitleLabel.font = [UIFont systemFontOfSize:13.0f];
		_subtitleLabel.backgroundColor = [UIColor clearColor];
		_subtitleLabel.textColor = [UIColor grayColor];
		
		if(type == JSBubbleMessageTypeOutgoing) {
			_subtitleLabel.textAlignment = NSTextAlignmentRight;
		}
		
		_subtitleLabel.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
                                           | UIViewAutoresizingFlexibleWidth);

		[self.contentView addSubview:_subtitleLabel];
	}
	
    _bubbleView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleHeight
                                    | UIViewAutoresizingFlexibleBottomMargin);
    
    [self.contentView addSubview:_bubbleView];
    [self.contentView sendSubviewToBack:_bubbleView];
}

#pragma mark - Initialization

- (instancetype)initWithBubbleType:(JSBubbleMessageType)type
                       bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
                       avatarStyle:(JSAvatarStyle)avatarStyle
                      hasTimestamp:(BOOL)hasTimestamp
                       hasSubtitle:(BOOL)hasSubtitle
                   reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setup];
        
        _avatarImageStyle = avatarStyle;
        
        [self configureWithType:type
                    bubbleStyle:bubbleStyle
                    avatarStyle:avatarStyle
					   subtitle:hasSubtitle
                      timestamp:hasTimestamp];
    }
    return self;
}

- (void)dealloc
{
    _bubbleView = nil;
    _timestampLabel = nil;
    _avatarImageView = nil;
    _subtitleLabel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)color
{
    [super setBackgroundColor:color];
    [self.contentView setBackgroundColor:color];
    [self.bubbleView setBackgroundColor:color];
}

#pragma mark - Message Cell

- (void)setMessage:(NSString *)msg
{
    self.bubbleView.text = msg;
}

- (void)setTimestamp:(NSDate *)date
{
    self.timestampLabel.text = [NSDateFormatter localizedStringFromDate:date
                                                              dateStyle:NSDateFormatterMediumStyle
                                                              timeStyle:NSDateFormatterShortStyle];
}

- (void)setAvatarImage:(UIImage *)image
{
    UIImage *styledImg = nil;
    switch (self.avatarImageStyle) {
        case JSAvatarStyleCircle:
            styledImg = [image js_circleImageWithSize:kJSAvatarSize];
            break;
            
        case JSAvatarStyleSquare:
            styledImg = [image js_squareImageWithSize:kJSAvatarSize];
            break;
            
        case JSAvatarStyleNone:
        default:
            break;
    }
    
    self.avatarImageView.image = styledImg;
}

- (void)setSubtitle:(NSString *)subtitle
{
	self.subtitleLabel.text = subtitle;
}

+ (CGFloat)neededHeightForText:(NSString *)bubbleViewText
                     timestamp:(BOOL)hasTimestamp
                      subtitle:(BOOL)hasSubtitle
                        avatar:(BOOL)hasAvatar
{
    CGFloat timestampHeight = (hasTimestamp) ? kJSTimeStampLabelHeight : 0.0f;
    CGFloat avatarHeight = (hasAvatar) ? kJSAvatarSize : 0.0f;
	CGFloat subtitleHeight = hasSubtitle ? kJSSubtitleLabelHeight : 0.0f;
    return MAX(avatarHeight, [JSBubbleView cellHeightForText:bubbleViewText]) + timestampHeight + subtitleHeight;
}

#pragma mark - Copying

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return [super becomeFirstResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(action == @selector(copy:))
        return YES;
    
    return [super canPerformAction:action withSender:sender];
}

- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:self.bubbleView.text];
    [self resignFirstResponder];
}

#pragma mark - Touch events

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if(![self isFirstResponder])
        return;
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuVisible:NO animated:YES];
    [menu update];
    [self resignFirstResponder];
}

#pragma mark - Gestures

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress
{
    if(longPress.state != UIGestureRecognizerStateBegan
       || ![self becomeFirstResponder])
        return;
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    CGRect targetRect = [self convertRect:[self.bubbleView bubbleFrame]
                                 fromView:self.bubbleView];
    [menu setTargetRect:CGRectInset(targetRect, 0.0f, 4.0f) inView:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - Notifications

- (void)handleMenuWillHideNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
    self.bubbleView.isSelectedToShowCopyMenu = NO;
}

- (void)handleMenuWillShowNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillHideNotification:)
                                                 name:UIMenuControllerWillHideMenuNotification
                                               object:nil];
    
    self.bubbleView.isSelectedToShowCopyMenu = YES;
}

@end