//
//  JKJMessageDataModel.m
//  JianKangJie3
//
//  Created by liyufeng on 15/6/9.
//  Copyright (c) 2015年 liyufeng. All rights reserved.
//

#import "JKJMessageDataModel.h"
#import "JSQMessages.h"

@implementation JKJMessageDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messages = [NSMutableArray new];
        
        self.avatars = [NSMutableDictionary dictionary];
        
        
        self.users = [NSMutableDictionary dictionary];
        
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    }
    
    return self;
}

@end
