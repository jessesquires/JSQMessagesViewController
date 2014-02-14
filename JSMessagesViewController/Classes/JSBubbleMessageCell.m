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

#import "JSBubbleMessageCell.h"

#import "JSAvatarImageFactory.h"
#import "UIColor+JSMessagesView.h"
#import <MHPrettyDate/MHPrettyDate.h>

static const CGFloat kJSLabelPadding = 5.0f;
static const CGFloat kJSTimeStampLabelHeight = 15.0f;
static const CGFloat kJSSubtitleLabelHeight = 15.0f;

NSString * const SideTimeAnimateNotification = @"SideTimeAnimateNotification";

@interface JSBubbleMessageCell()

- (void)setup;
- (void)configureTimestampLabel;
- (void)configureSideTimestampLabel;
- (void)configureAvatarImageView:(UIImageView *)imageView forMessageType:(JSBubbleMessageType)type;
- (void)configureSubtitleLabelForMessageType:(JSBubbleMessageType)type;

- (void)configureWithType:(JSBubbleMessageType)type
          bubbleImageView:(UIImageView *)bubbleImageView
                timestamp:(BOOL)hasTimestamp
                   avatar:(BOOL)hasAvatar
				 subtitle:(BOOL)hasSubtitle;

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress;

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
                                                                                             action:@selector(handleLongPressGesture:)];
    [recognizer setMinimumPressDuration:0.4f];
    [self addGestureRecognizer:recognizer];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleAnimateSideTimeNotification:) name:SideTimeAnimateNotification object:nil];
}

- (void)configureTimestampLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kJSLabelPadding,
                                                               kJSLabelPadding,
                                                               self.contentView.frame.size.width - (kJSLabelPadding * 2.0f),
                                                               kJSTimeStampLabelHeight)];
    label.autoresizingMask =  UIViewAutoresizingFlexibleWidth;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1.0];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0f];
    
    [self.contentView addSubview:label];
    [self.contentView bringSubviewToFront:label];
    _timestampLabel = label;
}

- (void)configureSideTimestampLabel {
    self.sideLabelStartX = self.contentView.frame.size.width;
    
    CGFloat sideLabelY = (self.contentView.frame.size.height / 2) - (kJSTimeStampLabelHeight / 2) + kJSLabelPadding;
    if(self.timestampLabel) {
        sideLabelY += kJSTimeStampLabelHeight - 2.0;
    }
    
    UILabel *sideLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.sideLabelStartX, sideLabelY, 150.0, kJSTimeStampLabelHeight)];
    sideLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    sideLabel.textAlignment = NSTextAlignmentLeft;
    sideLabel.textColor = [UIColor colorWithRed:0.557 green:0.557 blue:0.576 alpha:1.0];
    sideLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11.0f];
    
    [self.contentView addSubview:sideLabel];
    _sideTimestampLabel = sideLabel;
}

- (void)configureAvatarImageView:(UIImageView *)imageView forMessageType:(JSBubbleMessageType)type
{
    CGFloat avatarX = 0.5f;
    if(type == JSBubbleMessageTypeOutgoing) {
        avatarX = (self.contentView.frame.size.width - kJSAvatarImageSize);
    }
    
    CGFloat avatarY = self.contentView.frame.size.height - kJSAvatarImageSize;
    if(_subtitleLabel) {
        avatarY -= kJSSubtitleLabelHeight;
    }
    
    imageView.frame = CGRectMake(avatarX, avatarY, kJSAvatarImageSize, kJSAvatarImageSize);
    imageView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
                                  | UIViewAutoresizingFlexibleLeftMargin
                                  | UIViewAutoresizingFlexibleRightMargin);
    
    [self.contentView addSubview:imageView];
    _avatarImageView = imageView;
}

- (void)configureSubtitleLabelForMessageType:(JSBubbleMessageType)type
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = (type == JSBubbleMessageTypeOutgoing) ? NSTextAlignmentRight : NSTextAlignmentLeft;
    label.textColor = [UIColor js_messagesTimestampColorClassic];
    label.font = [UIFont systemFontOfSize:12.5f];
    
    [self.contentView addSubview:label];
    _subtitleLabel = label;
}

- (void)configureWithType:(JSBubbleMessageType)type
          bubbleImageView:(UIImageView *)bubbleImageView
                timestamp:(BOOL)hasTimestamp
                   avatar:(BOOL)hasAvatar
				 subtitle:(BOOL)hasSubtitle
{
    CGFloat bubbleY = 0.0f;
    CGFloat bubbleX = 0.0f;
    
    CGFloat offsetX = 0.0f;
    
    if(hasTimestamp) {
        [self configureTimestampLabel];
        bubbleY = 14.0f;
    }
    
    [self configureSideTimestampLabel];
    
    if(hasSubtitle) {
		[self configureSubtitleLabelForMessageType:type];
	}
    
    if(hasAvatar) {
        offsetX = 4.0f;
        bubbleX = kJSAvatarImageSize;
        if(type == JSBubbleMessageTypeOutgoing) {
            offsetX = kJSAvatarImageSize - 4.0f;
        }
        
        [self configureAvatarImageView:[[UIImageView alloc] init] forMessageType:type];
    }
    
    CGRect frame = CGRectMake(bubbleX - offsetX,
                              bubbleY,
                              self.contentView.frame.size.width - bubbleX,
                              self.contentView.frame.size.height - _timestampLabel.frame.size.height - _subtitleLabel.frame.size.height);
    
    JSBubbleView *bubbleView = [[JSBubbleView alloc] initWithFrame:frame
                                                        bubbleType:type
                                                   bubbleImageView:bubbleImageView];
    bubbleView.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                   | UIViewAutoresizingFlexibleHeight
                                   | UIViewAutoresizingFlexibleBottomMargin);
    
    [self.contentView addSubview:bubbleView];
    [self.contentView sendSubviewToBack:bubbleView];
    
    self.bubbleViewStartX = frame.origin.x;
    
    _bubbleView = bubbleView;
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithBubbleType:(JSBubbleMessageType)type
                   bubbleImageView:(UIImageView *)bubbleImageView
                      hasTimestamp:(BOOL)hasTimestamp
                         hasAvatar:(BOOL)hasAvatar
                       hasSubtitle:(BOOL)hasSubtitle
                   reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self configureWithType:type
                bubbleImageView:bubbleImageView
                      timestamp:hasTimestamp
                         avatar:hasAvatar
                       subtitle:hasSubtitle];
    }
    return self;
}

- (void)dealloc
{
    _bubbleView = nil;
    _timestampLabel = nil;
    _sideTimestampLabel = nil;
    _avatarImageView = nil;
    _subtitleLabel = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TableViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.bubbleView.textView.text = nil;
    self.timestampLabel.text = nil;
    self.sideTimestampLabel.text = nil;
    self.avatarImageView = nil;
    self.subtitleLabel.text = nil;
}

- (void)setBackgroundColor:(UIColor *)color
{
    [super setBackgroundColor:color];
    [self.contentView setBackgroundColor:color];
    [self.bubbleView setBackgroundColor:color];
}

#pragma mark - Setters

- (void)setMessage:(NSString *)msg attributedMsg:(NSAttributedString *)attributedMsg
{
    self.bubbleView.textView.text = msg;
    
    if(attributedMsg) {
        self.bubbleView.textView.attributedText = attributedMsg;
    }
}

- (void)setTimestamp:(NSDate *)date
{
    
    // timestamp label
    NSString *dateString;
    
    if([MHPrettyDate isToday:date]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        [dateFormatter setDoesRelativeDateFormatting:YES];
        
        dateString = [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:date], [MHPrettyDate prettyDateFromDate:date withFormat:MHPrettyDateFormatTodayTimeOnly]];
    } else if([MHPrettyDate isWithinWeek:date]) {
        dateString = [MHPrettyDate prettyDateFromDate:date withFormat:MHPrettyDateFormatWithTime withDateStyle:NSDateFormatterMediumStyle];
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"E, MMM d h:mm a"];
        
        dateString = [dateFormatter stringFromDate:date];
    }
    
    self.timestampLabel.text = dateString;
}

- (void)setSideTimestamp:(NSDate *)date {
    // side label
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"h:mm a"];
    
    self.sideTimestampLabel.text = [dateFormatter stringFromDate:date];
}

- (void)setAvatarImageView:(UIImageView *)imageView
{
    [_avatarImageView removeFromSuperview];
    _avatarImageView = nil;
    
    [self configureAvatarImageView:imageView forMessageType:[self messageType]];
}

- (void)setSubtitle:(NSString *)subtitle
{
	self.subtitleLabel.text = subtitle;
}

#pragma mark - Getters

- (JSBubbleMessageType)messageType
{
    return self.bubbleView.type;
}

#pragma mark - Class methods

+ (CGFloat)neededHeightForBubbleMessageCellWithText:(NSString *)text
                                     attributedText:(NSAttributedString *)attributedText
                                          timestamp:(BOOL)hasTimestamp
                                             avatar:(BOOL)hasAvatar
                                           subtitle:(BOOL)hasSubtitle
                                               type:(JSBubbleMessageType)type
{
    CGFloat timestampHeight = hasTimestamp ? kJSTimeStampLabelHeight : 0.0f;
    CGFloat avatarHeight = hasAvatar ? kJSAvatarImageSize : 0.0f;
	CGFloat subtitleHeight = hasSubtitle ? kJSSubtitleLabelHeight : 0.0f;
    
    CGFloat subviewHeights = timestampHeight + subtitleHeight + kJSLabelPadding;
    
    CGFloat bubbleHeight = attributedText == nil ? [JSBubbleView neededHeightForText:text type:type] : [JSBubbleView neededHeightForAttributedText:attributedText];
    
    return subviewHeights + MAX(avatarHeight, bubbleHeight);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.subtitleLabel) {
        self.subtitleLabel.frame = CGRectMake(kJSLabelPadding,
                                              self.contentView.frame.size.height - kJSSubtitleLabelHeight,
                                              self.contentView.frame.size.width - (kJSLabelPadding * 2.0f),
                                              kJSSubtitleLabelHeight);
    }
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
    return (action == @selector(copy:));
}

- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:self.bubbleView.textView.text];
    [self resignFirstResponder];
}

#pragma mark - Gestures

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    if(longPress.state != UIGestureRecognizerStateBegan || ![self becomeFirstResponder])
        return;
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    CGRect targetRect = [self convertRect:[self.bubbleView bubbleFrame]
                                 fromView:self.bubbleView];
    
    [menu setTargetRect:CGRectInset(targetRect, 0.0f, 4.0f) inView:self];
    
    self.bubbleView.bubbleImageView.highlighted = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
    [menu setMenuVisible:YES animated:YES];
}

#pragma mark - Notifications

- (void)handleMenuWillHideNotification:(NSNotification *)notification
{
    self.bubbleView.bubbleImageView.highlighted = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
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
}

-(void)handleAnimateSideTimeNotification:(NSNotification *)notification {
    CGFloat xMoved = [notification.object floatValue];
    
    [self.layer removeAllAnimations];
    [UIView animateWithDuration:0.1f animations:^{
        CGRect sideTimestampFrame = self.sideTimestampLabel.frame;
        sideTimestampFrame.origin.x -= xMoved;
        
        self.sideTimestampLabel.frame = sideTimestampFrame;
        
        if(self.bubbleView.type == JSBubbleMessageTypeOutgoing) {
            CGRect bubbleViewFrame = self.bubbleView.frame;
            
            bubbleViewFrame.origin.x -= xMoved;
            self.bubbleView.frame = bubbleViewFrame;
        }/* else if(self.bubbleView.type == JSBubbleMessageTypeNotification) {
          CGRect bubbleViewFrame = self.bubbleView.frame;
          
          bubbleViewFrame.size.width -= xMoved;
          self.bubbleView.frame = bubbleViewFrame;
          
          
          CGRect bubbleImageViewFrame = self.bubbleView.bubbleImageView.frame;
          bubbleImageViewFrame.size.width -= xMoved;
          self.bubbleView.bubbleImageView.frame = bubbleImageViewFrame;
          [self.bubbleView.bubbleImageView setNeedsDisplay];
          }*/
    }];
}

@end