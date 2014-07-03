//
//  JSQMessagesThumbnailFactory.h
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-3.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreMedia/CMTime.h>

@interface JSQMessagesThumbnailFactory : NSObject

+ (UIImage *)thumbnaiFromURL:(NSURL *)videoURL;

+ (UIImage *)thumbnaiFromURL:(NSURL *)videoURL atTime:(CMTime)time;

@end
