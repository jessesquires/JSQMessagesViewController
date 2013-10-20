//
//  JSBubbleMessageCell.m
//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//  http://www.hexedbits.com
//
//
//  Largely based on work by Sam Soffes
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
#import "UIImage+JSMessagesView.h"

#define TIMESTAMP_LABEL_HEIGHT 14.5f

#define SUBTITLE_LABEL_HEIGHT 16.0f
#define SUBTITLE_LABEL_SIDE_OFFSET 15.0f

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
    [recognizer setMinimumPressDuration:0.4];
    [self addGestureRecognizer:recognizer];
}

- (void)configureTimestampLabel
{
    self.timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                    4.0f,
                                                                    self.bounds.size.width,
                                                                    TIMESTAMP_LABEL_HEIGHT)];
    self.timestampLabel.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    self.timestampLabel.backgroundColor = [UIColor clearColor];
    self.timestampLabel.textAlignment = NSTextAlignmentCenter;
    self.timestampLabel.textColor = [UIColor messagesTimestampColor];
    self.timestampLabel.shadowColor = [UIColor whiteColor];
    self.timestampLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.timestampLabel.font = [UIFont boldSystemFontOfSize:11.5f];
    
    [self.contentView addSubview:self.timestampLabel];
    [self.contentView bringSubviewToFront:self.timestampLabel];
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
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX,
                                                                             self.contentView.frame.size.height - kJSAvatarSize,
                                                                             kJSAvatarSize,
                                                                             kJSAvatarSize)];
        
        self.avatarImageView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
                                                 | UIViewAutoresizingFlexibleLeftMargin
                                                 | UIViewAutoresizingFlexibleRightMargin);
		
        [self.contentView addSubview:self.avatarImageView];
    }
    
    CGRect frame = CGRectMake(bubbleX - offsetX,
                              bubbleY,
                              self.contentView.frame.size.width - bubbleX,
                              self.contentView.frame.size.height - self.timestampLabel.frame.size.height);
    
    self.bubbleView = [[JSBubbleView alloc] initWithFrame:frame
                                               bubbleType:type
                                              bubbleStyle:bubbleStyle];
	
	if(hasSubtitle) {
		self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SUBTITLE_LABEL_SIDE_OFFSET,
																	   bubbleY + frame.size.height - SUBTITLE_LABEL_HEIGHT,
																	   frame.size.width - bubbleX - SUBTITLE_LABEL_SIDE_OFFSET * 2,
																	   SUBTITLE_LABEL_HEIGHT)];
		self.subtitleLabel.font = [UIFont systemFontOfSize:13.0f];
		self.subtitleLabel.backgroundColor = [UIColor clearColor];
		self.subtitleLabel.textColor = [UIColor grayColor];
		
		if(type == JSBubbleMessageTypeOutgoing) {
			self.subtitleLabel.textAlignment = NSTextAlignmentRight;
		}
		
		self.subtitleLabel.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
											   | UIViewAutoresizingFlexibleWidth);

		[self.contentView addSubview:self.subtitleLabel];
	}
	
    self.bubbleView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
										| UIViewAutoresizingFlexibleHeight
										| UIViewAutoresizingFlexibleBottomMargin);
    
    [self.contentView addSubview:self.bubbleView];
    [self.contentView sendSubviewToBack:self.bubbleView];
}

- (void)setSubtitle:(NSString *)sub {
	self.subtitleLabel.text = sub;
}

#pragma mark - Initialization
- (id)initWithBubbleType:(JSBubbleMessageType)type
             bubbleStyle:(JSBubbleMessageStyle)bubbleStyle
             avatarStyle:(JSAvatarStyle)avatarStyle
            hasTimestamp:(BOOL)hasTimestamp
			 hasSubtitle:(BOOL)hasSubtitle
         reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setup];
        self.avatarImageStyle = avatarStyle;
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
    self.bubbleView = nil;
    self.timestampLabel = nil;
    self.avatarImageView = nil;
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
            styledImg = [image circleImageWithSize:kJSAvatarSize];
            break;
            
        case JSAvatarStyleSquare:
            styledImg = [image squareImageWithSize:kJSAvatarSize];
            break;
            
        case JSAvatarStyleNone:
        default:
            break;
    }
    
    self.avatarImageView.image = styledImg;
}

+ (CGFloat)neededHeightForText:(NSString *)bubbleViewText timestamp:(BOOL)hasTimestamp subtitle:(BOOL)hasSubtitle avatar:(BOOL)hasAvatar
{
    CGFloat timestampHeight = (hasTimestamp) ? TIMESTAMP_LABEL_HEIGHT : 0.0f;
    CGFloat avatarHeight = (hasAvatar) ? kJSAvatarSize : 0.0f;
	CGFloat subtitleHeight = hasSubtitle ? SUBTITLE_LABEL_HEIGHT : 0.0f;
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

#pragma mark - Notification
- (void)handleMenuWillHideNotification:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
    self.bubbleView.selectedToShowCopyMenu = NO;
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
    
    self.bubbleView.selectedToShowCopyMenu = YES;
}

@end