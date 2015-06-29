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

#import "JSQAttributedMessage.h"

@implementation JSQAttributedMessage


#pragma mark - Initialization

+ (instancetype)messageWithSenderId:(NSString *)senderId
                        displayName:(NSString *)displayName
                      attributedText:(NSAttributedString *) attributedText {
    
    return [[self alloc] initWithSenderId:senderId
                              senderDisplayName:displayName
                                           date:[NSDate date]
                            attributedText:attributedText];
    
}


- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                   attributedText:(NSAttributedString *) attributedText  {
    
    NSParameterAssert(senderId != nil);
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(date != nil);
    
    self = [super initWithSenderId:senderId senderDisplayName:senderDisplayName date:date text:attributedText.string];
    if (self) {
        _attributedText = [attributedText copy];
    }
    return self;
}


@end
