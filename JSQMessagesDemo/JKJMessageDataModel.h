//
//  JKJMessageDataModel.h
//  JianKangJie3
//
//  Created by liyufeng on 15/6/9.
//  Copyright (c) 2015年 liyufeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSQMessagesBubbleImage.h"
#import "JSQLocationMediaItem.h"

@interface JKJMessageDataModel : NSObject

@property (strong, nonatomic) NSMutableArray *messages;

@property (strong, nonatomic) NSMutableDictionary *avatars;

@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubbleImageData;

@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubbleImageData;

@property (strong, nonatomic) NSMutableDictionary *users;

- (void)addPhotoMediaMessage;

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion;

- (void)addVideoMediaMessage;

@end
