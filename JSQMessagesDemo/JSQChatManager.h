//
//  JSQChatManager.h
//  JSQMessages
//
//  Created by chenzy on 14-8-14.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTIFICATION_OF_RECV_MESSAGE @"RECV_A_NEW_MESSAGE"
#define NOTIFICATION_OF_CONTACT_STATUS @"CONTACT_STATUS"
#define NOTIFICATION_OF_MQTT_DISCONNECT @"MQTT_DISCONNECT"

@interface ContactObject : NSObject

@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *avatar;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic) BOOL status;

@end



@interface JSQChatManager : NSObject

@property (nonatomic, strong) NSString* clientID;
@property (nonatomic, strong) NSMutableDictionary* contacts;

+ (JSQChatManager*)defaultManager;

- (void)mqttInit;
- (void)mqttSend:(NSString*)msg topic:(NSString*)topic;

@end
