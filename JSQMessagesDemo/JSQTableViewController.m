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

#import "JSQTableViewController.h"
#import "JSQChatManager.h"
#import "JSQChatViewController.h"

@implementation JSQTableViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"JSQMessagesViewController";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNewContactStatus) name:NOTIFICATION_OF_CONTACT_STATUS object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification
- (void)handleNewContactStatus
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger num = [JSQChatManager defaultManager].contacts.count;
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [[[JSQChatManager defaultManager].contacts allKeys] objectAtIndex:indexPath.row];
    
    /*
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Push via storyboard";
                break;
            case 1:
                cell.textLabel.text = @"Push programmatically";
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Modal via storyboard";
                break;
            case 1:
                cell.textLabel.text = @"Modal programmatically";
                break;
        }
    }
     */
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return (section == [tableView numberOfSections] - 1) ? @"Copyright © 2014\nJesse Squires\nMIT License" : nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSQChatViewController *vc = [JSQChatViewController messagesViewController];
    vc.contactName = [[[JSQChatManager defaultManager].contacts allKeys] objectAtIndex:indexPath.row];
    ContactObject * chatObj = [[JSQChatManager defaultManager].contacts objectForKey:vc.contactName];
    vc.messages = chatObj.messages;
    [self.navigationController pushViewController:vc animated:YES];
    
    /*
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"seguePushDemoVC" sender:self];
                break;
            case 1:
            {
                JSQDemoViewController *vc = [JSQDemoViewController messagesViewController];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"segueModalDemoVC" sender:self];
                break;
            case 1:
            {
                JSQDemoViewController *vc = [JSQDemoViewController messagesViewController];
                vc.delegateModal = self;
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nc animated:YES completion:nil];
            }
                break;
        }
    }
     */
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueModalDemoVC"]) {
        UINavigationController *nc = segue.destinationViewController;
        JSQDemoViewController *vc = (JSQDemoViewController *)nc.topViewController;
        vc.delegateModal = self;
    }
}

- (IBAction)unwindSegue:(UIStoryboardSegue *)sender { }

#pragma mark - Demo delegate

- (void)didDismissJSQDemoViewController:(JSQDemoViewController *)vc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
