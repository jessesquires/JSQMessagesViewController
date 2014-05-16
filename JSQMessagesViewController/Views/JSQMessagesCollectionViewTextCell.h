//
//  JSQMessagesCollectionViewTextCell.h
//  JSQMessages
//
//  Created by Adam Cumiskey on 5/16/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewCell.h"

@interface JSQMessagesCollectionViewTextCell : JSQMessagesCollectionViewCell

/**
 *  Returns the text view of the cell. This text view contains the message body text.
 */
@property (weak, nonatomic, readonly) UITextView *textView;


@end
