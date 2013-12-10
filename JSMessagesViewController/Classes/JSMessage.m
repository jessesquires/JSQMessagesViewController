//
//  JSMessage.m
//  JSMessagesDemo
//
//  Created by Ahmed Ghalab on 12/6/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "JSMessage.h"

@implementation JSMessage

- (id)init
{
    self = [super init];
    if (self) {
        // Set Default Values ..
        self.mediaURL = nil;
        self.textMessage = nil;
        self.thumbnailImage = nil;
    }
    return self;
}

#pragma mark - Intialization Methods
- (instancetype)initWithTextMessage:(NSString*)text
{
    self = [super init];
    if(self) {
        self.type = JSTextMessage;
        self.textMessage = text;
    }
    return self;

}

- (instancetype)initWithImageMessage:(UIImage *) thumbnailImage
                  descrption:(NSString*) description
                 linkedToURL:(NSURL*) mediaURL
{
    self = [super init];
    if(self) {
        self.type = JSImageMessage;
        
        self.thumbnailImage = thumbnailImage;
        self.mediaURL = mediaURL;
        
        self.textMessage = description;
    }
    return self;
}


- (instancetype)initWithVideoMessage:(UIImage *) thumbnailImage
                  descrption:(NSString*) description
                 linkedToURL:(NSURL*) mediaURL
{
    self = [super init];
    if(self) {
        self.type = JSVideoMessage;
        
        self.thumbnailImage = thumbnailImage;
        self.mediaURL = mediaURL;
        
        self.textMessage = description;
    }
    return self;
}

@end
