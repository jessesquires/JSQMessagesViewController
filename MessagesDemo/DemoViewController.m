//
//  DemoViewController.m
//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "DemoViewController.h"

@interface DemoViewController ()
{
    NSMutableArray* selectedRows;
}
@end



@implementation DemoViewController

#pragma mark - Initialization
- (UIButton *)sendButton
{
    // Override to use a custom send button
    // The button's frame is set automatically for you
    return [UIButton defaultSendButton];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    self.navigationItem.rightBarButtonItem = [self editButtonItem];
    self.title = @"Messages";
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     @"Testing some messages here.",
                     @"This work is based on Sam Soffes' SSMessagesViewController.",
                     @"This is a complete re-write and refactoring.",
                     @"It's easy to implement. Sound effects and images included. Animations are smooth and messages can be of arbitrary size!",
                     nil];
    
    self.timestamps = [[NSMutableArray alloc] initWithObjects:
                       [NSDate distantPast],
                       [NSDate distantPast],
                       [NSDate distantPast],
                       [NSDate date],
                       nil];
    
    self.showtimestamps = [[NSMutableArray alloc] initWithObjects:
                       [NSNumber numberWithBool:YES],
                       [NSNumber numberWithBool:NO],
                       [NSNumber numberWithBool:NO],
                       [NSNumber numberWithBool:YES],
                       nil];
    
    selectedRows = [[NSMutableArray alloc] init];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if(editing) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteMessages)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark - Messages view delegate
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    [self.messages addObject:text];
    [self.timestamps addObject:[NSDate date]];
    [self.showtimestamps addObject:[NSNumber numberWithBool:YES]];
    
    if((self.messages.count - 1) % 2)
        [JSMessageSoundEffect playMessageSentSound];
    else
        [JSMessageSoundEffect playMessageReceivedSound];
    
    [self finishSend];
}

- (IBAction)deleteMessages
{
    if (self.tableView.editing)
    {
        // you need to sort the selected rows to delete from highest to lowest index
        // otherwise it may lead to delete attempt on an invalid index
        [selectedRows sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger r1 = [obj1 row];
            NSInteger r2 = [obj2 row];
            if (r1 > r2) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            if (r1 < r2) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        for(NSIndexPath* indexPath in selectedRows) {
            [self.messages removeObjectAtIndex:indexPath.row];
            [self.timestamps removeObjectAtIndex:indexPath.row];
            [self.showtimestamps removeObjectAtIndex:indexPath.row];
        }
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationRight];
        [selectedRows removeAllObjects];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView.editing) {
        [selectedRows addObject:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView.editing) {
        [selectedRows removeObject:indexPath];
    }
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row % 2) ? JSBubbleMessageStyleIncomingDefault : JSBubbleMessageStyleOutgoingDefault;
}

- (JSMessagesViewTimestampPolicy)timestampPolicyForMessagesView
{
    NSLog(@"timestampPolicyForMessagesView");
    return JSMessagesViewTimestampPolicyCustom;
}

- (BOOL)shouldHaveTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.showtimestamps objectAtIndex:indexPath.row] boolValue];
}


- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // custom implementation here, if using `JSMessagesViewTimestampPolicyCustom`
    //return [self shouldHaveTimestampForRowAtIndexPath:indexPath];
    NSLog(@"hasTimestampForRowAtIndexPath: %u", [[self.showtimestamps objectAtIndex:indexPath.row] boolValue]);
    return [[self.showtimestamps objectAtIndex:indexPath.row] boolValue];
}

#pragma mark - Messages view data source
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.timestamps objectAtIndex:indexPath.row];
}

@end