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

@interface JSBubbleMessageCell()

@property (strong, nonatomic) JSBubbleView *bubbleView;
@property (strong, nonatomic) UILabel *timestampLabel;

- (void)setup;
- (void)configureTimestampLabel;
- (void)configureWithStyle:(JSBubbleMessageStyle)style timestamp:(BOOL)hasTimestamp;

@end



@implementation JSBubbleMessageCell

#pragma mark - Initialization
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
}

- (void)configureTimestampLabel
{
    self.timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                    4.0f,
                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                    14.5f)];
    self.timestampLabel.autoresizingMask =  UIViewAutoresizingNone;
    self.timestampLabel.backgroundColor = [UIColor clearColor];
    self.timestampLabel.textAlignment = NSTextAlignmentCenter;
    self.timestampLabel.textColor = [UIColor messagesTimestampColor];
    self.timestampLabel.shadowColor = [UIColor whiteColor];
    self.timestampLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.timestampLabel.font = [UIFont boldSystemFontOfSize:11.5f];
    
    [self.contentView addSubview:self.timestampLabel];
    [self.contentView bringSubviewToFront:self.timestampLabel];
}

- (void)configureWithStyle:(JSBubbleMessageStyle)style timestamp:(BOOL)hasTimestamp
{
    CGFloat bubbleY = 0.0f;
    
    if(hasTimestamp) {
        [self configureTimestampLabel];
        bubbleY = 14.0f;
    }
    
    CGRect frame = CGRectMake(0.0f,
                              bubbleY,
                              self.contentView.frame.size.width,
                              self.contentView.frame.size.height - self.timestampLabel.frame.size.height);
    
    self.bubbleView = [[JSBubbleView alloc] initWithFrame:frame
                                              bubbleStyle:style];
    
    self.bubbleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:self.bubbleView];
    [self.contentView sendSubviewToBack:self.bubbleView];
}

- (id)initWithBubbleStyle:(JSBubbleMessageStyle)style hasTimestamp:(BOOL)hasTimestamp reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setup];
        [self configureWithStyle:style timestamp:hasTimestamp];
    }
    return self;
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

@end