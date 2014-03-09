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
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQTableViewController.h"

#import "JSQDemoViewController.h"


@implementation JSQTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"JSQMessagesViewController";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = @"Push";
    return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Select Presentation";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *sb = [JSQMessagesViewController messagesStoryboard];
//    JSQMessagesViewController *vc = [sb instantiateInitialViewController];
    
//    JSQDemoViewController *vc = (JSQDemoViewController *)[JSQMessagesViewController messagesViewController];
    
    JSQDemoViewController *vc = [JSQDemoViewController messagesViewController];

    NSLog(@"CLASS = %@", [vc class]);
    
//    JSQDemoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
