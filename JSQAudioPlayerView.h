//
//  JSQAudioPlayerView.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-6.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

@class JSQMessage;

@interface JSQAudioPlayerView : UIView

@property (strong, nonatomic) JSQMessage *message;
@property (assign, nonatomic) BOOL incomingMessage;

- (void)startAnimation;
- (void)stopAnimation;

@end
