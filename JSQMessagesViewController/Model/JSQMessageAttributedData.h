//
//  JSQMessageAttributedData.h
//  JSQMessages
//
//  Created by Flavio Negrão Torres on 29/06/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "JSQMessageMediaData.h"

@protocol JSQMessageAttributedData <JSQMessageData>

/**
 *  @return The body text of the message.
 *
 *  @warning You must not return `nil` from this method.
 */
- (NSAttributedString *)attributedText;

@end
