//
//  MessagesListViewConroller.swift
//  JSwiftQMessages
//
//  Created by Dan Leonard on 2/28/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

class MessagesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var composeBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView?
    
    var conversations = [Conversation]()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.conversations = getConversation()
        self.tableView?.reloadData()
//        fetchSMSConversations {
//            self.conversations = $0
//            self.tableView?.reloadData()
//        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addMenuButton()
//        setColors()
//        composeBarButtonItem.tintColor = AppColors.contrastColor
        tableView?.addSubview(refreshControl)
        
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        updateConversations()
    }
    
    func updateConversations() {
//        fetchSMSConversations { conversations in
//            self.conversations = conversations
//            self.tableView?.reloadData()
//            self.refreshControl.endRefreshing()
//            self.tableView?.sendSubviewToBack(self.refreshControl)
//        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let conversation = conversations[indexPath.row]
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
//        cell.avatarView.setup(conversation.patientId)
        cell.nameLabel.text = "Name"
//        cell.nameLabel.text = fullNameFromFirstName(conversation.firstName, lastName: conversation.lastName) ?? formatPhoneNumber(conversation.smsNumber)
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
        if let conversationController = segue.destinationViewController as? ConversationViewController, row = sender as? Int {
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

