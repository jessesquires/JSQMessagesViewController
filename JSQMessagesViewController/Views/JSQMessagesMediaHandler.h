//
//  JSQMessagesMedia.h
//  JSQMessages
//
//  Created by Pierluigi Cifani on 17/6/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSQMessagesCollectionViewCell;

@interface JSQMessagesMediaHandler : NSObject

+ (instancetype)mediaHandlerWithCell:(JSQMessagesCollectionViewCell *)cell;

- (void) setMediaFromImage:(UIImage *)image;
- (void) setMediaFromURL:(NSURL *)imageURL;

@end
