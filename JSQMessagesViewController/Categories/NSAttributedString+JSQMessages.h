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

#import <Foundation/Foundation.h>

@interface NSAttributedString (JSQMessages)

/**
 * @discussion This method searchs for NSAttachmentAttributeName attributes within the string instead of searching for NSAttachmentCharacter characters.
 * @return An array of NSTextAttachment objects
 */
- (NSArray*)allAttachments;

- (NSString*)stringWithoutAttachments;

@end
