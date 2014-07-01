//
//  JSQMessagesCollectionViewCellIncomingPhoto.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-1.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCellIncoming.h"

@interface JSQMessagesCollectionViewCellIncomingPhoto : JSQMessagesCollectionViewCellIncoming

@property (weak, nonatomic, readonly) UIImageView *mediaImageView;
@property (strong, nonatomic, readonly) UITapGestureRecognizer *mediaImageViewTapGestureRecognizer;

@end
