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
 

#define photoEdgeInsets (UIEdgeInsets){2,4,2,4}
#define photoSize (CGSize){40,40}
@interface JSBubbleMessageCell()

@property (strong, nonatomic) JSBubbleView *bubbleView;
@property (strong, nonatomic) UIImageView *photoView;
@property (strong, nonatomic) UILabel *timestampLabel;

- (void)setup;
- (void)configureTimestampLabel;
- (void)configureWithStyle:(JSBubbleMessageStyle)style timestamp:(BOOL)hasTimestamp photo:(BOOL) hasPhoto;

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
                                                                    self.bounds.size.width,
                                                                    14.5f)];
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

- (void)configureWithStyle:(JSBubbleMessageStyle)style timestamp:(BOOL)hasTimestamp photo:(BOOL) hasPhoto
{
    CGFloat bubbleY = 0.0f;
    
    if(hasTimestamp) {
        [self configureTimestampLabel];
        bubbleY = 14.0f;
    }
    CGFloat rightOffsetX=0.0f;
    CGFloat leftOffsetX=0.0f;
     
    
    
    if(hasPhoto){
        
        if(style==JSBubbleMessageStyleIncomingDefault||style==JSBubbleMessageStyleIncomingSquare){
            rightOffsetX=photoEdgeInsets.left+photoSize.width+photoEdgeInsets.right;
            self.photoView=[[UIImageView alloc] initWithFrame:(CGRect){photoEdgeInsets.left,self.contentView.frame.size.height-photoEdgeInsets.bottom-photoSize.height,photoSize}];
        }else{
            leftOffsetX=photoEdgeInsets.left+photoSize.width+photoEdgeInsets.right;
            self.photoView=[[UIImageView alloc] initWithFrame:(CGRect){self.contentView.frame.size.width-photoEdgeInsets.right-photoSize.width,self.contentView.frame.size.height-photoEdgeInsets.bottom-photoSize.height,photoSize}];
        }
        [self.contentView addSubview:self.photoView];
        self.photoView.autoresizingMask=UIViewAutoresizingFlexibleTopMargin;
//        UIImage *testImage=[UIImage imageNamed:@"send"];
//        self.photoView.image=testImage;
    }
    CGRect frame = CGRectMake(rightOffsetX,
                              bubbleY,
                              self.contentView.frame.size.width-rightOffsetX-leftOffsetX,
                              self.contentView.frame.size.height - self.timestampLabel.frame.size.height);
    
    self.bubbleView = [[JSBubbleView alloc] initWithFrame:frame
                                              bubbleStyle:style];
    
    self.bubbleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:self.bubbleView];
    [self.contentView sendSubviewToBack:self.bubbleView];
}

- (id)initWithBubbleStyle:(JSBubbleMessageStyle)style hasTimestamp:(BOOL)hasTimestamp hasPhoto:(BOOL) hasPhoto reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setup];
        [self configureWithStyle:style timestamp:hasTimestamp photo:hasPhoto];
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
- (void) setPhoto:(NSString *)photoUrl
{
    UIImage *image=[UIImage imageNamed:photoUrl];
    self.photoView.image=image;
}

- (void)setTimestamp:(NSDate *)date
{
    self.timestampLabel.text = [NSDateFormatter localizedStringFromDate:date
                                                              dateStyle:NSDateFormatterMediumStyle
                                                              timeStyle:NSDateFormatterShortStyle];
}

@end