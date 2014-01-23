//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import "JSMessagesProtocol.h"


/**
 *  A `JSMessage` object represents a single user message. It contains the message text, its sender, and the date that the message was sent.
 */
@interface JSMessage : NSObject <NSCoding, NSCopying, JSMessagesProtocol>

@end
