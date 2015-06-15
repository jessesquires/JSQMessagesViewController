//
//  JKJMessageViewController.h
//  JianKangJie3
//
//  Created by liyufeng on 15/6/9.
//  Copyright (c) 2015年 liyufeng. All rights reserved.
//

#import "JSQMessagesViewController.h"

@interface JKJMessageViewController : JSQMessagesViewController

@property (nonatomic, strong)NSString *userId;//对方的用户id;
@property (nonatomic, strong)NSString *userName;//对方用户的名称
@property (nonatomic, strong)NSString *userImageUrlString;//图片url

@end
