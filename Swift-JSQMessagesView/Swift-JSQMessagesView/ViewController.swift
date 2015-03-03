//
//  ViewController.swift
//  Swift-JSQMessagesView
//
//  Created by Haroon on 03/03/2015.
//  Copyright (c) 2015 Github. All rights reserved.
//

import UIKit


class ViewController: JSQMessagesViewController, UIActionSheetDelegate {
    
    var messages = [Message]() //You have to append here, all the messages, that you are sending.
    var avatars = [String: JSQMessagesAvatarImage]() //Save all the incomming and outgoing avatar images
    
    /*
    *   Here you set up the color for each of the incoming and outgoing bubble.
    *   Grab the color from the provided jsq color factory.
    */
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    
    /*
    *   In this particular case, we are grabing the user profile image from a pre-defined URL.
    *   We grab that URL and save it here.
    */
    var senderImageUrl: String!
    
    var senderActualName: String!
    
    var batchMessages = true
    
    /*
    *   You can send the message from here.
    *   Just provide the required arguments and call this method, you're done then
    */
    func SendMessage(text: String!, sender: String!) {
        let message = Message(text: text, sender: sender, imageUrl: senderImageUrl)
        messages.append(message)
    }
    
    /*
    *   This is the helper function to grab the image from the URL and put it there
    *   into the avatar. It also configures the diameter for the avatar image.
    */
    func setupAvatarImage(name: String, imageUrl: String?, incoming: Bool) {
        if imageUrl == nil ||  countElements(imageUrl!) == 0 {
            setupAvatarColor(name, incoming: incoming)
            return
        }
        
        let diameter = incoming ? UInt(collectionView.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView.collectionViewLayout.outgoingAvatarViewSize.width)
        
        let url = NSURL(string: imageUrl!)
        
        if let data = NSData(contentsOfURL: url!) {
            
            let image = UIImage(data: NSData(contentsOfURL: url!)!)
            let avatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(image, diameter: diameter)
            
            avatars[name] = avatarImage
        }
    }
    
    /*
    *   Incase if the user don't want to set up an avatar image, you can then
    *   call this method. It would create an avatar from the user initials with some nice background color
    */
    func setupAvatarColor(name: String, incoming: Bool) {
        let diameter = incoming ? UInt(collectionView.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView.collectionViewLayout.outgoingAvatarViewSize.width)
        
        let rgbValue = name.hash
        let r = CGFloat(Float((rgbValue & 0xFF0000) >> 16)/255.0)
        let g = CGFloat(Float((rgbValue & 0xFF00) >> 8)/255.0)
        let b = CGFloat(Float(rgbValue & 0xFF)/255.0)
        let color = UIColor(red: r, green: g, blue: b, alpha: 0.5)
        
        let nameLength = countElements(name)
        
        let initials : String? = name.substringToIndex(advance(senderDisplayName.startIndex, min(3, nameLength)))
        
        let userImage = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials, backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(CGFloat(13)), diameter: diameter)
        
        avatars[name] = userImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyScrollsToMostRecentMessage = true
        
        // The name of the sender
        senderDisplayName = (senderDisplayName != nil) ? senderDisplayName : "Anonymous"
        
        // Here, we are hardcoding the URL for the avatar image of the sender.
        let profileImageUrl: NSString? = "https://pbs.twimg.com/profile_images/450268509319081985/Szabe27e.jpeg"
        
        /*
        *   If there is actually a URL for the avatar image, gran it from there. Else,
        *   make a temporary avatar from the user initials
        */
        if let urlString = profileImageUrl {
            setupAvatarImage(senderDisplayName, imageUrl: urlString, incoming: false)
            senderImageUrl = urlString
        } else {
            setupAvatarColor(senderDisplayName, incoming: false)
            senderImageUrl = ""
        }
        
        // Very handy and self-explanatory
        self.showLoadEarlierMessagesHeader = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //Enable the springy bubbles from here.
        collectionView.collectionViewLayout.springinessEnabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - ACTIONS
    
    func receivedMessagePressed(sender: UIBarButtonItem) {
        // Simulate reciving message
        showTypingIndicator = !showTypingIndicator
        scrollToBottomAnimated(true)
    }
    
    
    /*
    *   The real magic happens here. This is the method which is called when you press the send button.
    *   here, you could play a nice little soung along with calling the appropiate methids in order.
    */
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        SendMessage(text, sender: senderDisplayName)
        finishSendingMessageAnimated(true)
    }
    
    
    /*
    *   You can send the media messages from here. Just modify this function call.
    */
    override func didPressAccessoryButton(sender: UIButton!) {
        var UIAction = UIActionSheet(title: "Media Messages", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Send Photo", "Send File", "Send Location")
        UIAction.showFromToolbar(self.inputToolbar)
    }
    
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        println("Action Sheet Gone!")
    }
    
    // Here, you can tell the controller about the data belongs to which bubble.
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    // Differentiate the incomming and outgoing messages, and set their bubble color accordingly
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        
        if message.sender() == senderDisplayName {
            return outgoingBubbleImageView
        }
        
        return incomingBubbleImageView
    }
    
    // Set the avatar image for the incomming and outgoing messages
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        let message = messages[indexPath.item]
        if let avatar = avatars[message.sender()] {
            return avatar
            
        }
        else {
            setupAvatarImage(message.sender(), imageUrl: message.imageUrl(), incoming: true)
            return avatars[message.sender()]
        }
        
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // Here, you can configure the heck out of an individual cell.
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        if message.sender() == senderDisplayName {
            cell.textView.textColor = UIColor.blackColor()
        } else {
            cell.textView.textColor = UIColor.whiteColor()
        }
        
        let attributes : [NSObject:AnyObject] = [NSForegroundColorAttributeName:cell.textView.textColor, NSUnderlineStyleAttributeName: 1]
        cell.textView.linkTextAttributes = attributes
        
        return cell
    }
    
    
    // View  usernames above bubbles
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item];
        
        // Sent by me, skip
        if message.sender() == senderDisplayName {
            return nil;
        }
        
        // Same as previous sender, skip
        if indexPath.item > 0 {
            let previousMessage = messages[indexPath.item - 1];
            if previousMessage.sender() == message.sender() {
                return nil;
            }
        }
        
        return NSAttributedString(string:message.sender())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let message = messages[indexPath.item]
        
        // Sent by me, skip
        if message.sender() == senderDisplayName {
            return CGFloat(0.0);
        }
        
        // Same as previous sender, skip
        if indexPath.item > 0 {
            let previousMessage = messages[indexPath.item - 1];
            if previousMessage.sender() == message.sender() {
                return CGFloat(0.0);
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
}

