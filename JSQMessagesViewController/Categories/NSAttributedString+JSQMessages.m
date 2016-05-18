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

#import "NSAttributedString+JSQMessages.h"

#import "JSQMessagesViewController.h"

@implementation NSAttributedString (JSQMessages)

/*
 * category implementation thanks to
 * http://toxicsoftware.com/cocoa_fetching_all_attachments_from_an_nsattributedstring.html
 */
- (NSArray *)allAttachments
{
    NSMutableArray *theAttachments = [NSMutableArray array];
    NSRange theStringRange = NSMakeRange(0, [self length]);
    if (theStringRange.length > 0)
    {
        unsigned long index = 0;
        do
        {
            NSRange theEffectiveRange;
            NSDictionary *theAttributes = [self attributesAtIndex:index longestEffectiveRange:&theEffectiveRange inRange:theStringRange];
            NSTextAttachment *theAttachment = [theAttributes objectForKey:NSAttachmentAttributeName];
            if (theAttachment != NULL)
                [theAttachments addObject:theAttachment];
            index = theEffectiveRange.location + theEffectiveRange.length;
        }
        while (index < theStringRange.length);
    }
    return(theAttachments);
}

- (NSString*)stringWithoutAttachments
{
    NSMutableAttributedString * plainString = [self mutableCopy];
    NSRange theStringRange = NSMakeRange(0, [plainString length]);
    
    while (theStringRange.length > 0) {
        unsigned long index = 0;
        NSRange theEffectiveRange;
        
        NSDictionary *theAttributes = [self attributesAtIndex:index longestEffectiveRange:&theEffectiveRange inRange:theStringRange];
        NSTextAttachment *theAttachment = [theAttributes objectForKey:NSAttachmentAttributeName];
        if (theAttachment == NULL)
            break;
        
        [plainString deleteCharactersInRange:theEffectiveRange];
    
        theStringRange = NSMakeRange(0, [plainString length]);
    }
    
    return [plainString string];
}

@end
