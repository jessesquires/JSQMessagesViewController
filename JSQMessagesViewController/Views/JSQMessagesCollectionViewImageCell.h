//
//  JSQMessagesCollectionViewImageCell.h
//  JSQMessages
//
//  Created by Adam Cumiskey on 5/16/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

@interface JSQMessagesCollectionViewImageCell : JSQMessagesCollectionViewCell

/**
 *  Returns the image view of the cell. This image view contains the message image attachement.
 */
@property (weak, nonatomic, readonly) UIImageView *imageView;

@end
