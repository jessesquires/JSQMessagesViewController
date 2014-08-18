//
//  JSQChatViewController.h
//  JSQMessages
//
//  Created by chenzy on 14-8-15.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesViewController.h"
#import "JSQMessages.h"



@interface JSQChatViewController : JSQMessagesViewController

@property (nonatomic, strong) NSString *contactName;
@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) UIImageView *incomingBubbleImageView;

@end
