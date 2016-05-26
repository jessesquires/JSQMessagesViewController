//
//  ChatViewController.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/11/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    var messages = [JSQMessage]()
    let defaults = NSUserDefaults.standardUserDefaults()
    var conversation: Conversation?
    var incomingBubble: JSQMessagesBubbleImage?
    var outgoingBubble: JSQMessagesBubbleImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // Override point:
        //
        // Here is an exaple of how you can cusomize the bubble appearence for incoming and outgoing messages.
        // Based on the Settigns of the user we will display two differnent type of bubbles.
        //
        
        if defaults.boolForKey(taillessSettingKey) {
            // Bubbles with tails
            incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
            outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
        }
        else {
            // Make taillessBubbles
            incomingBubble = JSQMessagesBubbleImageFactory(bubbleImage: UIImage.jsq_bubbleCompactTaillessImage(), capInsets: UIEdgeInsetsZero).incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
            outgoingBubble = JSQMessagesBubbleImageFactory(bubbleImage: UIImage.jsq_bubbleCompactTaillessImage(), capInsets: UIEdgeInsetsZero).outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
        }
        
        
        self.inputToolbar?.contentView?.leftBarButtonItem = nil
        
        
        // This is how you remove Avatars from the messagesView
        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        
        // This is a beta feature that mostly works but to make things more stable I have diabled it.
        collectionView?.collectionViewLayout.springinessEnabled = false
        
        //Set the SenderId  to the current User
        // For this Demo we will use Woz's ID
        // Anywhere that AvatarIDWoz is used you should replace with you currentUserVariable
        senderId = AvatarIdWoz
        senderDisplayName = conversation?.firstName ?? conversation?.preferredName ?? conversation?.lastName ?? ""
        automaticallyScrollsToMostRecentMessage = true
        
        //Get Messages
        self.messages = makeConversation()
        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
        
        
    }
    
    override func didPressSendButton(button: UIButton?, withMessageText text: String?, senderId: String?, senderDisplayName: String?, date: NSDate?) {
        
        // This is where you would impliment your method for saving the message to your backend.
        //
        // For this Demo I will just add it to the messages list localy
        //
        self.messages.append(JSQMessage(senderId: AvatarIdWoz, displayName: DisplayNameWoz, text: text))
        self.finishSendingMessageAnimated(true)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData? {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource? {
        return messages[indexPath.item].senderId == AvatarIdWoz ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource? {
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        switch message.senderId {
        //Here we are displaying everyones name above their message except for the "Senders"
        case AvatarIdWoz:
            return nil
        default:
            guard let senderDisplayName = message.senderDisplayName else {
                assertionFailure()
                return nil
            }
            return NSAttributedString(string: senderDisplayName)
            
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout?, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return messages[indexPath.item].senderId == AvatarIdWoz ? 0 : kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
}