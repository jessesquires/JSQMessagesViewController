//
//  ConversationViewController.swift
//  JSwiftQMessages
//
//  Created by Dan Leonard on 2/28/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//
import UIKit
import JSQMessagesViewController

class ConversationViewController: JSQMessagesViewController {
    var messages = [JSQMessage]()
    
    var conversation: Conversation?
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputToolbar?.contentView?.leftBarButtonItem = nil
        
        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.springinessEnabled = false
        senderId = "1"
        senderDisplayName = conversation?.firstName ?? conversation?.preferredName ?? conversation?.lastName ?? ""
        automaticallyScrollsToMostRecentMessage = true
        
        if let phoneNumber = conversation?.smsNumber {
//            fetchSMSMessagesForNumber(phoneNumber, completion: { (messages) in
//                self.messages = messages.reverse()
//                self.collectionView?.reloadData()
//                self.scrollToBottomAnimated(false)
//            })
        }
    }
    
    override func didPressSendButton(button: UIButton?, withMessageText text: String?, senderId: String?, senderDisplayName: String?, date: NSDate?) {
        guard let 📞＃ = conversation?.smsNumber, 📝 = text else {
            return
        }
        
//        let newMessage = Message(text: text, senderId: senderId, senderDisplayName: senderDisplayName, isOutBound: 1)
//        
//        sendSMS(toPhoneNumber: 📞＃, withMessage: 📝, success: {
//            self.messages.append(newMessage)
//            self.finishSendingMessage()
//            }, failure: nil)
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData? {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource? {
        return messages[indexPath.item].senderId == "1" ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource? {
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView?, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        switch message.senderId {
        case "1":
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
        return messages[indexPath.item].senderId == "1" ? 0 : kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
}