//
//  JSMessage.h
//  JSMessagesDemo
//
//  Created by Ahmed Ghalab on 12/6/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The Data with which timestamps are displayed in the messages table view.
 */
typedef NS_ENUM(NSUInteger, JSMessagesType) {
    /**
     *  Displays a Text Only message bubble, Coping Support Included.
     */
    JSTextMessage,
    /**
     *  Displays a Image above Description with text bubble, Action Included.
     */
    JSImageMessage,
    /**
     *  Displays a Image thumbnail for video with Play Button above Description with text bubble, Action Included.
     */
    JSVideoMessage
};


/**
 *  An instance of JSMessage is a means for holding the message content Data either being Text or Media Message type.
 */
@interface JSMessage : NSObject

/**
 *  Returns the type of Message used.
 */
@property (nonatomic) JSMessagesType type;

/**
 *  Returns the text of Message to be displayed used as a message or a description.
 */
@property (strong, nonatomic) NSString* textMessage;
/**
 *  Returns image that would be used as Thumbnail.
 */
@property (strong, nonatomic) UIImage *thumbnailImage;


/**
 *  Returns URL view that would be displayed.
 */
@property (strong, nonatomic) NSURL* mediaURL;



/**
 *  Initialize the message object with Text Message.
 *
 *  @param text Text message to be displayed in the bubble message.
 */
- (instancetype)initWithTextMessage:(NSString*)text;


/**
 *  Initialize the message object with Image Message Type.
 *
 *  @param thumbnailImage image to be displayed inside Image bubble
 *  @param description greyed Text shown under the image descriptive to the image content
 *  @param mediaURL URL for image to be shown if message tapped
 */
- (instancetype)initWithImageMessage:(UIImage *) thumbnailImage
                  descrption:(NSString*) description
                 linkedToURL:(NSURL*) mediaURL;


/**
 *  Initialize the message object with Video Message Type.
 *
 *  @param thumbnailImage image to be displayed inside Image bubble, Play Button Overlay will be added on it.
 *  @param description greyed Text shown under the image descriptive to the video content
 *  @param mediaURL URL for Video to be shown if message tapped
 */
- (instancetype)initWithVideoMessage:(UIImage *) thumbnailImage
                  descrption:(NSString*) description
                 linkedToURL:(NSURL*) mediaURL;

@end
