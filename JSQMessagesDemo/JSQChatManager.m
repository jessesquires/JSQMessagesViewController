//
//  JSQChatManager.m
//  JSQMessages
//
//  Created by chenzy on 14-8-14.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQChatManager.h"
#import "JSQMessages.h"
#import <MQTTKit.h>
#import "getMacAddress.h"



@implementation ContactObject

@end



@interface JSQChatManager ()
@property (nonatomic, strong) NSString* serverIP;
@property (nonatomic) NSUInteger port;
@property (nonatomic, strong) MQTTClient* mqttClient;
@end

@implementation JSQChatManager

+ (JSQChatManager*)defaultManager
{
    static JSQChatManager* instance;
    @synchronized(instance){
		if(!instance){
			instance = [[JSQChatManager alloc] init];
		}
	}
	return instance;
}

- (void)mqttInit
{
    NSString *macAddress = getMacAddress();
    
    self.serverIP = @"127.0.0.1";//@"192.168.1.52";//
    self.clientID = macAddress;
    self.mqttClient = [[MQTTClient alloc] initWithClientId:self.clientID];
    
    __weak JSQChatManager *weakSelf = self;
    [self.mqttClient setMessageHandler:^(MQTTMessage *message) {
        [weakSelf onMqttReceive:message.payloadString topic:message.topic];
        NSLog(@"received message %@, topic %@", message.payloadString, message.topic);
    }];
    [self.mqttClient setDisconnectionHandler:^(NSUInteger code) {
        [weakSelf onMqttDisconnect:code];
    }];
    
    
    // connect the MQTT client
    [self.mqttClient connectToHost:self.serverIP
                 completionHandler:^(MQTTConnectionReturnCode code) {
                     if (code == ConnectionAccepted) {
                         // when the client is connected, subscribe to the topic to receive message.
                         [self.mqttClient subscribe:[NSString stringWithFormat:@"Messages/Text/%@/+", macAddress] withCompletionHandler:nil];
                         [self.mqttClient subscribe:[NSString stringWithFormat:@"Messages/Image/%@/+", macAddress] withCompletionHandler:nil];
                         [self.mqttClient subscribe:[NSString stringWithFormat:@"Messages/Audio/%@/+", macAddress] withCompletionHandler:nil];
                         [self.mqttClient subscribe:@"Broadcast/Online/+" withCompletionHandler:nil];
                         [self.mqttClient subscribe:@"Broadcast/Offline/+" withCompletionHandler:nil];
                         
                         [self mqttSend:nil topic:[NSString stringWithFormat:@"Broadcast/Online/%@", self.clientID]];
                         
                         NSLog(@"mqtt connected");
                     }
                 }];
}

- (void)mqttSend:(NSString*)msg topic:(NSString*)topic
{
    [self.mqttClient publishString:msg
                           toTopic:topic
                           withQos:AtMostOnce
                            retain:NO
                 completionHandler:^(int mid) {
                     NSLog(@"message has been delivered");
                 }];
}

- (void)onMqttReceive:(NSString*)msg topic:(NSString*)topic
{
    if (self.contacts == nil) {
        self.contacts = [NSMutableDictionary dictionaryWithCapacity:1];
    }
    
    NSArray * compTopic = [topic componentsSeparatedByString:@"/"];
    NSString* clientID = [compTopic lastObject];
    
    if ([clientID isEqualToString:self.clientID]) {
        return;
    }
    
    ContactObject *chatObj = [self.contacts objectForKey:clientID];
    if (chatObj == nil) {
        chatObj = [[ContactObject alloc] init];
        chatObj.clientID = clientID;
        chatObj.name = clientID;
        chatObj.status = YES;
        
        CGFloat outgoingDiameter = 34;
        UIImage *img = [JSQMessagesAvatarFactory avatarWithUserInitials:[clientID substringToIndex:2]
                                                             backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                                   textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                        font:[UIFont systemFontOfSize:14.0f]
                                                                    diameter:outgoingDiameter];
        chatObj.avatar = img;
        chatObj.messages = [[NSMutableArray alloc] init];
        
        [self.contacts setObject:chatObj forKey:chatObj.clientID];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_OF_CONTACT_STATUS object:nil];
    }
    
    NSRange range = [topic rangeOfString:@"Broadcast/Online"];
	if (range.length > 0) {
        chatObj.status = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_OF_CONTACT_STATUS object:nil];
    }
    
    range = [topic rangeOfString:@"Broadcast/Offline"];
	if (range.length > 0) {
            chatObj.status = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_OF_CONTACT_STATUS object:nil];
    }
    
    range = [topic rangeOfString:@"Messages/Text"];
	if (range.length > 0) {
        JSQMessage *jsqMsg = [[JSQMessage alloc] initWithText:msg sender:clientID date:[NSDate date]];
        [chatObj.messages addObject:jsqMsg];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_OF_RECV_MESSAGE object:clientID];
    }
}

- (void)onMqttDisconnect:(NSUInteger)code
{
    NSLog(@"mqtt disconnect");
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_OF_MQTT_DISCONNECT object:nil];
}

@end
