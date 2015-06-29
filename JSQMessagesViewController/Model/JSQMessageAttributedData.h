//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessageMediaData.h"

@protocol JSQMessageAttributedData <JSQMessageData>

/**
 *  @return The body attributed text of the message.
 *
 *  @warning You must not return `nil` from this method.
 */
- (NSAttributedString *)attributedText;

@end
