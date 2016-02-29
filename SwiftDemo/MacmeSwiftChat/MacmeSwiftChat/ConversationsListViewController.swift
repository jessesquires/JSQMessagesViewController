//
//  ConversationsListViewController.swift
//  MacmeSwiftChat
//
//  Created by Dan Leonard on 2/28/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView?
    
    var conversations = [Conversation]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.conversations = getConversation()
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let conversation = conversations[indexPath.row]
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? ConversationTableViewCell else {
            return UITableViewCell()
        }
        
        //        cell.avatarView.setup(conversation.patientId)
        cell.nameLabel.text = "Chat with The Guys"
     
        cell.recentTextLabel.text = conversation.latestMessage
        
        if !conversation.isRead {
            cell.nameLabel.font = cell.nameLabel.font.bold()
        } else {
            cell.nameLabel.font = cell.nameLabel.font.withTraits([])
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ConversationSegue", sender: indexPath.row)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let conversationController = segue.destinationViewController as? ChatViewController, row = sender as? Int {
            let conversation = conversations[row]
            conversationController.conversation = conversation
        }
    }
    
    func formatPhoneNumber(phoneNumber: String?) -> String {
        guard var phoneNumber = phoneNumber else {
            return ""
        }
        if phoneNumber.characters.count == 10 {
            phoneNumber.insert("(", atIndex: phoneNumber.startIndex)
            phoneNumber.insert(")", atIndex: phoneNumber.startIndex.advancedBy(4))
            phoneNumber.insert("-", atIndex: phoneNumber.startIndex.advancedBy(8))
        }
        return phoneNumber
    }
}

extension UIFont {
    
    //This is used for making unread messages bold
    
    func withTraits(traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(.TraitBold)
    }
    
}


