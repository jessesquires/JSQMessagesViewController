//
//  JSQMessagesBubbleImageFactory+Private.h
//  JSQMessages
//
//  Created by Raymond Walsh on 10/6/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

@interface JSQMessagesBubbleImageFactory ()


/**
 *  Creates and returns the template image for this Bubble Image Factory.
 *  This is an override point for creating subclasses of JSQMessagesBubbleImageFactory
 *
 *  @return A UIImage oriented as an outgoing bubble.
 */
+ (UIImage *)baseImage;

/**
 *  Returns the edge insets to identify the stretchable area of the bubble image.
 *  This image is guaranteed to have come from +[baseImage].
 *  This is an override point for creating subclasses of JSQMessagesBubbleImageFactory
 *
 *  @return A UIImage oriented as an outgoing bubble.
 */
+ (UIEdgeInsets)baseImageInsetsForImage:(UIImage *)bubble;
@end