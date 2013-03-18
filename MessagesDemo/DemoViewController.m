//
//  DemoViewController.m
//  Messages
//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@end



@implementation DemoViewController

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Messages";
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     @"Testing some messages here.",
                     @"This work is based on Sam Soffes' SSMessagesViewController.",
                     @"This is a complete re-write and refactoring.",
                     @"It's easy to implement. Sound effects and images included. Animations are smooth and messages can be of arbitrary size!",
                     nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark - Messages view controller
- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row % 2) ? JSBubbleMessageStyleIncoming : JSBubbleMessageStyleOutgoing;
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}

- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    [self.messages addObject:text];
    
    if((self.messages.count - 1) % 2)
        [JSMessageSoundEffect playMessageSentSound];
    else
        [JSMessageSoundEffect playMessageReceivedSound];
    
    [self finishSend];
}

@end