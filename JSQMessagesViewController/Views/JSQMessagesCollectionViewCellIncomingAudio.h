//
//  JSQMessagesCollectionViewCellIncomingAudio.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

/**
 *  A `JSQMessagesCollectionViewCellIncomingAudio` object is a concrete instance of `JSQMessagesCollectionViewCell`
 *  that represents an incoming audio message item.
 */
@interface JSQMessagesCollectionViewCellIncomingAudio : JSQMessagesCollectionViewCell

@property (weak, nonatomic, readonly) NSData *audioData;

@end
