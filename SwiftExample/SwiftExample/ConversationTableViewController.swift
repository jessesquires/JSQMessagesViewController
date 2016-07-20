//
//  ConversationTableViewController.swift
//  SwiftExample
//
//  Created by P D Leonard on 6/7/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

class ConversationTableViewController: UITableViewController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            print("Group Conversation")
        case 1:
            print("Regular Conversation")
        default:
            assertionFailure("Option not found")
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let destination = segue.destinationViewController as? ChatViewController else {
            return
        }
        sender?.textLabel!!.text == "Regular Conversation" ? destination.messages = makeNormalConversation() : (destination.messages = makeGroupConversation())
    }
    
    
}
