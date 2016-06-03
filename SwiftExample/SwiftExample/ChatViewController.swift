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
        
        bubbleConfigureation()
        
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
    
    func bubbleConfigureation() {
        //
        // Override point:
        //
        // Here is where we cusomize the bubble
        // appearence for incoming and outgoing bubbles
        // based on the `Settings` that the user defines
        //
        
        if defaults.boolForKey(taillessSettingKey) {
            // Bubbles with tails
            incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
            outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
        }
        else {
            // Make taillessBubbles
            incomingBubble = JSQMessagesBubbleImageFactory(bubbleImage: UIImage.jsq_bubbleCompactTaillessImage(), capInsets: UIEdgeInsetsZero).incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
            outgoingBubble = JSQMessagesBubbleImageFactory(bubbleImage: UIImage.jsq_bubbleCompactTaillessImage(), capInsets: UIEdgeInsetsZero).outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
        }
    }
    
    
    // MARK: JSQMessagesViewController method overrides
    override func didPressSendButton(button: UIButton?, withMessageText text: String?, senderId: String?, senderDisplayName: String?, date: NSDate?) {
        /**
         *  Sending a message. Your implementation of this method should do *at least* the following:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishSendingMessage`
         */
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(message)
        self.finishSendingMessageAnimated(true)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        self.inputToolbar.contentView.textView.resignFirstResponder()
        
        let sheet = UIAlertController(title: "Media messages", message: nil, preferredStyle: .ActionSheet)
        
        let photoButton = UIAlertAction(title: "Send photo", style: .Default) { (action) in
            /**
             *  Create fake photo
             */
            let photoItem = JSQPhotoMediaItem(image: UIImage(named: "goldengate"))
            self.addMedia(photoItem)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        sheet.addAction(photoButton)
        sheet.addAction(cancelButton)
        
        self.presentViewController(sheet, animated: true, completion: nil)
    }
    
    func addMedia(media:JSQMediaItem) {
        let message = JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, media: media)
        self.messages.append(message)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        self.finishSendingMessageAnimated(true)
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
        // Override point:
        //
        // Here we check for what our setting is for displaying the senderDisplayName
        // if we dont want to display it we just return a height of 0.
        // Then we check to see if (The current user)
        // sent the message if so we return 0, because we know our own name,
        // other wise we return the defualt height.
        //
        
        if defaults.boolForKey(senderDisplayNameKey) {
            return 0
        }
        
        return messages[indexPath.item].senderId == AvatarIdWoz ? 0 : kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
}