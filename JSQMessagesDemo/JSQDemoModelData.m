//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

#import "JSQDemoModelData.h"

/**
 *  This is for demo/testing purposes only.
 *  This object sets up some fake model data.
 *  Do not actually do anything like this.
 */

@implementation JSQDemoModelData

- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         *  Load some fake messages for demo.
         *
         *  You should have a mutable array or orderedSet, or something.
         */
        self.messages = [[NSMutableArray alloc] initWithObjects:
                         [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS."
                                                 senderId:kJSQDemoAvatarIdSquires
                                        senderDisplayName:kJSQDemoAvatarDisplayNameSquires
                                                     date:[NSDate distantPast]],
                         
                         [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy."
                                                 senderId:kJSQDemoAvatarIdWoz
                                        senderDisplayName:kJSQDemoAvatarDisplayNameWoz
                                                     date:[NSDate distantPast]],
                         
                         [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com."
                                                 senderId:kJSQDemoAvatarIdSquires
                                        senderDisplayName:kJSQDemoAvatarDisplayNameSquires
                                                     date:[NSDate distantPast]],
                         
                         [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better."
                                                 senderId:kJSQDemoAvatarIdJobs
                                        senderDisplayName:kJSQDemoAvatarDisplayNameJobs
                                                     date:[NSDate date]],
                         
                         [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source."
                                                 senderId:kJSQDemoAvatarIdCook
                                        senderDisplayName:kJSQDemoAvatarDisplayNameCook
                                                     date:[NSDate date]],
                         
                         [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation."
                                                 senderId:kJSQDemoAvatarIdSquires
                                        senderDisplayName:kJSQDemoAvatarDisplayNameSquires
                                                     date:[NSDate date]],
                         nil];
        
        
        /**
         *  Create avatar images once.
         *
         *  Be sure to create your avatars one time and reuse them for good performance.
         *
         *  If you are not using avatars, ignore this.
         */
        
        UIImage *jsqImage = [JSQMessagesAvatarFactory avatarWithUserInitials:@"JSQ"
                                                             backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                                   textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                        font:[UIFont systemFontOfSize:14.0f]
                                                                    diameter:kJSQDemoAvatarSize];
        
        UIImage *cookImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_cook"]
                                                              diameter:kJSQDemoAvatarSize];
        
        UIImage *jobsImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]
                                                              diameter:kJSQDemoAvatarSize];
        
        UIImage *wozImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_woz"]
                                                             diameter:kJSQDemoAvatarSize];
        self.avatars = @{ kJSQDemoAvatarIdSquires : jsqImage,
                          kJSQDemoAvatarIdCook : cookImage,
                          kJSQDemoAvatarIdJobs : jobsImage,
                          kJSQDemoAvatarIdWoz : wozImage };
        
        
        self.users = @{ kJSQDemoAvatarIdJobs : kJSQDemoAvatarDisplayNameJobs,
                        kJSQDemoAvatarIdCook : kJSQDemoAvatarDisplayNameCook,
                        kJSQDemoAvatarIdWoz : kJSQDemoAvatarDisplayNameWoz,
                        kJSQDemoAvatarIdSquires : kJSQDemoAvatarDisplayNameSquires };
        
        
        /**
         *  Create message bubble images objects.
         *
         *  Be sure to create your bubble images one time and reuse them for good performance.
         *
         */
        self.outgoingBubbleImageData = [JSQMessagesBubbleImageFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        
        self.incomingBubbleImageData = [JSQMessagesBubbleImageFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
        
        /**
         *  Change to add more messages for testing
         */
        NSUInteger messagesToAdd = 0;
        NSArray *copyOfMessages = [self.messages copy];
        for (NSUInteger i = 0; i < messagesToAdd; i++) {
            [self.messages addObjectsFromArray:copyOfMessages];
        }
        
        /**
         *  Change to YES to add a super long message for testing
         *  You should see "END" twice
         */
        BOOL addREALLYLongMessage = NO;
        if (addREALLYLongMessage) {
            JSQMessage *reallyLongMessage = [JSQMessage messageWithText:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END" senderId:kJSQDemoAvatarIdSquires senderDisplayName:kJSQDemoAvatarDisplayNameSquires];
            
            [self.messages addObject:reallyLongMessage];
        }
    }
    return self;
}

@end
