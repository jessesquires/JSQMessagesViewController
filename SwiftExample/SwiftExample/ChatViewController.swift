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
    let defaults = UserDefaults.standard
    var conversation: Conversation?
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    fileprivate var displayName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation
        setupBackButton()
        
        /**
         *  Override point:
         *
         *  Example of how to cusomize the bubble appearence for incoming and outgoing messages.
         *  Based on the Settings of the user display two differnent type of bubbles.
         *
         */
        
        if defaults.bool(forKey: Setting.removeBubbleTails.rawValue) {
            // Make taillessBubbles
            incomingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero, layoutDirection: UIApplication.shared.userInterfaceLayoutDirection).incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
            outgoingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero, layoutDirection: UIApplication.shared.userInterfaceLayoutDirection).outgoingMessagesBubbleImage(with: UIColor.lightGray)
        }
        else {
            // Bubbles with tails
            incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
            outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.lightGray)
        }
        
        /**
         *  Example on showing or removing Avatars based on user settings.
         */
        
        if defaults.bool(forKey: Setting.removeAvatar.rawValue) {
            collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
            collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        } else {
            collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height:kJSQMessagesCollectionViewAvatarSizeDefault )
            collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height:kJSQMessagesCollectionViewAvatarSizeDefault )
        }
        
        // Show Button to simulate incoming messages
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.jsq_defaultTypingIndicator(), style: .plain, target: self, action: #selector(receiveMessagePressed))
        
        // This is a beta feature that mostly works but to make things more stable it is diabled.
        collectionView?.collectionViewLayout.springinessEnabled = false
        
        automaticallyScrollsToMostRecentMessage = true

        self.collectionView?.reloadData()
        self.collectionView?.layoutIfNeeded()
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func receiveMessagePressed(_ sender: UIBarButtonItem) {
        /**
         *  DEMO ONLY
         *
         *  The following is simply to simulate received messages for the demo.
         *  Do not actually do this.
         */
        
        /**
         *  Show the typing indicator to be shown
         */
        self.showTypingIndicator = !self.showTypingIndicator
        
        /**
         *  Scroll to actually view the indicator
         */
        self.scrollToBottom(animated: true)
        
        /**
         *  Copy last sent message, this will be the new "received" message
         */
        var copyMessage = self.messages.last?.copy()
        
        if (copyMessage == nil) {
            copyMessage = JSQMessage(senderId: AvatarIdJobs, displayName: getName(User.Jobs), text: "First received!")
        }
            
        var newMessage:JSQMessage!
        var newMediaData:JSQMessageMediaData!
        var newMediaAttachmentCopy:AnyObject?
        
        if (copyMessage! as AnyObject).isMediaMessage() {
            /**
             *  Last message was a media message
             */
            let copyMediaData = (copyMessage! as AnyObject).media
            
            switch copyMediaData {
            case is JSQPhotoMediaItem:
                let photoItemCopy = (copyMediaData as! JSQPhotoMediaItem).copy() as! JSQPhotoMediaItem
                photoItemCopy.appliesMediaViewMaskAsOutgoing = false
                
                newMediaAttachmentCopy = UIImage(cgImage: photoItemCopy.image!.cgImage!)
                
                /**
                 *  Set image to nil to simulate "downloading" the image
                 *  and show the placeholder view5017
                 */
                photoItemCopy.image = nil;
                
                newMediaData = photoItemCopy
            case is JSQLocationMediaItem:
                let locationItemCopy = (copyMediaData as! JSQLocationMediaItem).copy() as! JSQLocationMediaItem
                locationItemCopy.appliesMediaViewMaskAsOutgoing = false
                newMediaAttachmentCopy = locationItemCopy.location!.copy() as AnyObject?
                
                /**
                 *  Set location to nil to simulate "downloading" the location data
                 */
                locationItemCopy.location = nil;
                
                newMediaData = locationItemCopy;
            case is JSQVideoMediaItem:
                let videoItemCopy = (copyMediaData as! JSQVideoMediaItem).copy() as! JSQVideoMediaItem
                videoItemCopy.appliesMediaViewMaskAsOutgoing = false
                newMediaAttachmentCopy = (videoItemCopy.fileURL! as NSURL).copy() as AnyObject?
                
                /**
                 *  Reset video item to simulate "downloading" the video
                 */
                videoItemCopy.fileURL = nil;
                videoItemCopy.isReadyToPlay = false;
                
                newMediaData = videoItemCopy;
            case is JSQAudioMediaItem:
                let audioItemCopy = (copyMediaData as! JSQAudioMediaItem).copy() as! JSQAudioMediaItem
                audioItemCopy.appliesMediaViewMaskAsOutgoing = false
                newMediaAttachmentCopy = (audioItemCopy.audioData! as NSData).copy() as AnyObject?
                
                /**
                 *  Reset audio item to simulate "downloading" the audio
                 */
                audioItemCopy.audioData = nil;
                
                newMediaData = audioItemCopy;
            default:
                assertionFailure("Error: This Media type was not recognised")
            }
            
            newMessage = JSQMessage(senderId: AvatarIdJobs, displayName: getName(User.Jobs), media: newMediaData)
        }
        else {
            /**
             *  Last message was a text message
             */
            
            newMessage = JSQMessage(senderId: AvatarIdJobs, displayName: getName(User.Jobs), text: (copyMessage! as AnyObject).text)
        }
        
        /**
         *  Upon receiving a message, you should:
         *
         *  1. Play sound (optional)
         *  2. Add new JSQMessageData object to your data source
         *  3. Call `finishReceivingMessage`
         */
        
        self.messages.append(newMessage)
        self.finishReceivingMessage(animated: true)
        
        if newMessage.isMediaMessage {
            /**
             *  Simulate "downloading" media
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
                /**
                 *  Media is "finished downloading", re-display visible cells
                 *
                 *  If media cell is not visible, the next time it is dequeued the view controller will display its new attachment data
                 *
                 *  Reload the specific item, or simply call `reloadData`
                 */
                
                switch newMediaData {
                case is JSQPhotoMediaItem:
                    (newMediaData as! JSQPhotoMediaItem).image = newMediaAttachmentCopy as? UIImage
                    self.collectionView!.reloadData()
                case is JSQLocationMediaItem:
                    (newMediaData as! JSQLocationMediaItem).setLocation(newMediaAttachmentCopy as? CLLocation, withCompletionHandler: {
                        self.collectionView!.reloadData()
                    })
                case is JSQVideoMediaItem:
                    (newMediaData as! JSQVideoMediaItem).fileURL = newMediaAttachmentCopy as? URL
                    (newMediaData as! JSQVideoMediaItem).isReadyToPlay = true
                    self.collectionView!.reloadData()
                case is JSQAudioMediaItem:
                    (newMediaData as! JSQAudioMediaItem).audioData = newMediaAttachmentCopy as? Data
                    self.collectionView!.reloadData()
                default:
                    assertionFailure("Error: This Media type was not recognised")
                }
            }
        }
    }
    
    // MARK: JSQMessagesViewController method overrides
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        /**
         *  Sending a message. Your implementation of this method should do *at least* the following:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishSendingMessage`
         */
        
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages.append(message)
        self.finishSendingMessage(animated: true)
    }
    
    override func didPressAccessoryButton(_ sender: UIButton) {
        self.inputToolbar.contentView!.textView!.resignFirstResponder()
        
        let sheet = UIAlertController(title: "Media messages", message: nil, preferredStyle: .actionSheet)
        
        let photoAction = UIAlertAction(title: "Send photo", style: .default) { (action) in
            /**
             *  Create fake photo
             */
            let photoItem = JSQPhotoMediaItem(image: UIImage(named: "goldengate"))
            self.addMedia(photoItem)
        }
        
        let locationAction = UIAlertAction(title: "Send location", style: .default) { (action) in
            /**
             *  Add fake location
             */
            let locationItem = self.buildLocationItem()
            
            self.addMedia(locationItem)
        }
        
        let videoAction = UIAlertAction(title: "Send video", style: .default) { (action) in
            /**
             *  Add fake video
             */
            let videoItem = self.buildVideoItem()
            
            self.addMedia(videoItem)
        }
        
        let audioAction = UIAlertAction(title: "Send audio", style: .default) { (action) in
            /**
             *  Add fake audio
             */
            let audioItem = self.buildAudioItem()
            
            self.addMedia(audioItem)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        sheet.addAction(photoAction)
        sheet.addAction(locationAction)
        sheet.addAction(videoAction)
        sheet.addAction(audioAction)
        sheet.addAction(cancelAction)
        
        self.present(sheet, animated: true, completion: nil)
    }
    
    func buildVideoItem() -> JSQVideoMediaItem {
        let videoURL = URL(fileURLWithPath: "file://")
        
        let videoItem = JSQVideoMediaItem(fileURL: videoURL, isReadyToPlay: true)
        
        return videoItem
    }
    
    func buildAudioItem() -> JSQAudioMediaItem {
        let sample = Bundle.main.path(forResource: "jsq_messages_sample", ofType: "m4a")
        let audioData = try? Data(contentsOf: URL(fileURLWithPath: sample!))
        
        let audioItem = JSQAudioMediaItem(data: audioData)
        
        return audioItem
    }
    
    func buildLocationItem() -> JSQLocationMediaItem {
        let ferryBuildingInSF = CLLocation(latitude: 37.795313, longitude: -122.393757)
        
        let locationItem = JSQLocationMediaItem()
        locationItem.setLocation(ferryBuildingInSF) {
            self.collectionView!.reloadData()
        }
        
        return locationItem
    }
    
    func addMedia(_ media:JSQMediaItem) {
        let message = JSQMessage(senderId: self.senderId(), displayName: self.senderDisplayName(), media: media)
        self.messages.append(message)
        
        //Optional: play sent sound
        
        self.finishSendingMessage(animated: true)
    }
    
    
    //MARK: JSQMessages CollectionView DataSource
    
    override func senderId() -> String {
        return User.Wozniak.rawValue
    }
    
    override func senderDisplayName() -> String {
        return getName(.Wozniak)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        
        return messages[indexPath.item].senderId == self.senderId() ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        let message = messages[indexPath.item]
        return getAvatar(message.senderId)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        /**
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         *  The other label text delegate methods should follow a similar pattern.
         *
         *  Show a timestamp for every 3rd message
         */
        if (indexPath.item % 3 == 0) {
            let message = self.messages[indexPath.item]
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }
        
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        let message = messages[indexPath.item]
        
        // Displaying names above messages
        //Mark: Removing Sender Display Name
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
         */
        if defaults.bool(forKey: Setting.removeSenderDisplayName.rawValue) {
            return nil
        }
        
        if message.senderId == self.senderId() {
            return nil
        }

        return NSAttributedString(string: message.senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForCellTopLabelAt indexPath: IndexPath) -> CGFloat {
        /**
         *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
         */
        
        /**
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         *  The other label height delegate methods should follow similarly
         *
         *  Show a timestamp for every 3rd message
         */
        if indexPath.item % 3 == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        
        return 0.0
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        /**
         *  Example on showing or removing senderDisplayName based on user settings.
         *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
         */
        if defaults.bool(forKey: Setting.removeSenderDisplayName.rawValue) {
            return 0.0
        }
        
        /**
         *  iOS7-style sender name labels
         */
        let currentMessage = self.messages[indexPath.item]
        
        if currentMessage.senderId == self.senderId() {
            return 0.0
        }
        
        if indexPath.item - 1 > 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == currentMessage.senderId {
                return 0.0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
}
