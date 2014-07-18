//
//  JSQMessagesRecorderButton.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-16.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesRecorderButton.h"

@implementation JSQMessagesRecorderButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CGFloat cornerRadius = 6.0f;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = cornerRadius;
}
    
@end
