//
//  DemoMessagesViewController.swift
//  JSQMessages
//
//  Created by Raphaël Bellec on 11/08/2015.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

import Foundation
import UIKit



protocol JSQDemoViewControllerDelegate {
    func didDismissJSQDemoViewController( vc : DemoMessagesViewController )
}


class DemoMessagesViewController : JSQMessagesViewController, UIActionSheetDelegate {
    
    var  delegateModal  : JSQDemoViewControllerDelegate?
    var  demoData       : DemoModelData!
    
    
    // ----------------------------------------------------------------------
    // MARK: - View lifecycle
    // ----------------------------------------------------------------------
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        self.title = "JSQMessages"
        
        
        // Load up our fake data for the demo
        self.demoData           = DemoModelData()
        
        // You MUST set your senderId and display name
        self.senderId           = demoData.kJSQDemoAvatarIdSquires
        self.senderDisplayName  = demoData.kJSQDemoAvatarDisplayNameSquires
        
        
        // You can set custom avatar sizes
        if ( !NSUserDefaults.incomingAvatarSetting() ) {
            self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        }
        
        if ( !NSUserDefaults.outgoingAvatarSetting() ) {
            self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        }
        
        self.showLoadEarlierMessagesHeader     = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.jsq_defaultTypingIndicatorImage(),
                                                                 style: UIBarButtonItemStyle.Bordered,
                                                                target: self,
                                                                action: Selector("receiveMessagePressed:") )
        
        /**
        *  Register custom menu actions for cells.
        */
        JSQMessagesCollectionViewCell.registerMenuAction( Selector("customAction:") )
        UIMenuController.sharedMenuController().menuItems = [  UIMenuItem( title: "Custom Action", action: Selector( "customAction:" ) ) ]
        
        
        /**
        *  Customize your toolbar buttons
        *
        *  self.inputToolbar.contentView.leftBarButtonItem = custom button or nil to remove
        *  self.inputToolbar.contentView.rightBarButtonItem = custom button or nil to remove
        */
        
        /**
        *  Set a maximum height for the input toolbar
        *
        *  self.inputToolbar.maximumHeight = 150;
        */
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Delegate not use here. TODO: see swift 2.0 ways as soon as available.
        if let delegate = self.delegateModal {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: Selector("closePressed:"))
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /**
        *  Enable/disable springy bubbles, default is NO.
        *  You must set this from `viewDidAppear:`
        *  Note: this feature is mostly stable, but still experimental
        */
        self.collectionView.collectionViewLayout.springinessEnabled = NSUserDefaults.springinessSetting()
    }
    
    // ----------------------------------------------------------------------
    // MARK: - Testing
    // ----------------------------------------------------------------------

    func pushMainViewController() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let nc = sb.instantiateInitialViewController() as! UINavigationController
        self.navigationController?.pushViewController(nc.topViewController, animated: true)
    }

    // ----------------------------------------------------------------------
    // MARK: - Actions
    // ----------------------------------------------------------------------
    
    func receiveMessagePressed(sender: UIBarButtonItem) {
        
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
        self.scrollToBottomAnimated(true)
        
        /**
        *  Copy last sent message, this will be the new "received" message
        */
//        let msgArray                   = self.demoData.messages
        let lastMessage  : JSQMessage? = self.demoData.messages.last
        var copyMessage  : JSQMessage

        if let lastMessageOk  =  lastMessage {
            copyMessage = lastMessageOk.copy() as! JSQMessage
        } else {
            copyMessage = JSQMessage(senderId: demoData?.kJSQDemoAvatarIdJobs,
                                  displayName: demoData?.kJSQDemoAvatarDisplayNameJobs,
                                         text: "First received!")
        }
        
        /**
        *  Allow typing indicator to show
        */
        let delayInSeconds = 1.5
        
        dispatch_after( dispatch_time( DISPATCH_TIME_NOW, Int64( delayInSeconds * Double(NSEC_PER_SEC) )  )   ,
                        dispatch_get_main_queue() )
            {
                
                // Remove the current user from Array of possible recipients of the message.
                var otherUserIds            = self.demoData.users.keys.array.filter( {$0 != self.senderId;} )
                let randomUserIndex         = Int(arc4random_uniform(UInt32(otherUserIds.count)))
                let randomUserId            = otherUserIds[ randomUserIndex ]
                let userDisplayedName       = self.demoData.users[randomUserId]
                
                
                var newMessage              : JSQMessage?
                var newMediaData            : JSQMessageMediaData?
                var newMediaAttachmentCopy  : AnyObject?
                
                // TODO: use a switch case to match class here.
                if ( copyMessage.isMediaMessage ) {
                    /**
                    *  Last message was a media message
                    */
                    let copyMediaData : JSQMessageMediaData = copyMessage.media;
                    
                    if (       copyMediaData is JSQPhotoMediaItem ) {
                        // TODO: clean these casts !
                        let photoItemCopy : JSQPhotoMediaItem           = (copyMediaData as! JSQPhotoMediaItem).copy()    as! JSQPhotoMediaItem
                        photoItemCopy.appliesMediaViewMaskAsOutgoing    = false
                        newMediaAttachmentCopy                          = UIImage( CGImage: photoItemCopy.image.CGImage )
                        
                        /**
                        *  Set image to nil to simulate "downloading" the image
                        *  and show the placeholder view
                        */
                        photoItemCopy.image = nil
                        
                        newMediaData = photoItemCopy
                    }
                    else if ( copyMediaData is JSQLocationMediaItem ) {
                        let locationItemCopy : JSQLocationMediaItem     = (copyMediaData as! JSQLocationMediaItem).copy() as! JSQLocationMediaItem
                        locationItemCopy.appliesMediaViewMaskAsOutgoing = false
                        newMediaAttachmentCopy                          = locationItemCopy.location.copy()
                        
                        /**
                        *  Set location to nil to simulate "downloading" the location data
                        */
                        locationItemCopy.location                       = nil
                        newMediaData                                    = locationItemCopy
                    }
                    else if ( copyMediaData is JSQVideoMediaItem    ) {
                        let videoItemCopy : JSQVideoMediaItem           = (copyMediaData as! JSQVideoMediaItem).copy()    as! JSQVideoMediaItem
                        videoItemCopy.appliesMediaViewMaskAsOutgoing    = false
                        newMediaAttachmentCopy                          = videoItemCopy.fileURL.copy()
                        
                        /**
                        *  Reset video item to simulate "downloading" the video
                        */
                        videoItemCopy.fileURL                           = nil
                        videoItemCopy.isReadyToPlay                     = false
                        
                        newMediaData                                    = videoItemCopy
                    }
                    else {
                        NSLog("%s error: unrecognized media item, line :%s", __FUNCTION__, __LINE__)
                    }
                    
                    newMessage = JSQMessage( senderId: randomUserId,   displayName: userDisplayedName,    media: newMediaData)
                    
                }
                else {
                    /**
                    *  Last message was a text message
                    */
                    newMessage = JSQMessage( senderId: randomUserId,   displayName:userDisplayedName,      text: copyMessage.text)
                }
                
                
                
                /**
                *  Upon receiving a message, you should:
                *
                *  1. Play sound (optional)
                *  2. Add new id<JSQMessageData> object to your data source
                *  3. Call `finishReceivingMessage`
                */
                JSQSystemSoundPlayer.jsq_playMessageReceivedSound()
                self.demoData.messages.append(newMessage!)              // Error if newMessage is nil.
                self.finishReceivingMessageAnimated(true)
                
                //-------- Use swift 2. Note : nil chek here is useless if the case is not handled for above "newMessage!"
                if let msg = newMessage where msg.isMediaMessage {
                    /**
                    *  Simulate "downloading" media
                    */
                    let fake_downloading_delay = 2.0
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64( fake_downloading_delay * Double(NSEC_PER_SEC) )), dispatch_get_main_queue()) {
                        /**
                        *  Media is "finished downloading", re-display visible cells
                        *
                        *  If media cell is not visible, the next time it is dequeued the view controller will display its new attachment data
                        *
                        *  Reload the specific item, or simply call `reloadData`
                        */
                        
                        if        newMediaData is JSQPhotoMediaItem     {
                            let photoMediaItem           = newMediaData as! JSQPhotoMediaItem
                            photoMediaItem.image         = newMediaAttachmentCopy  as! UIImage
                            self.collectionView.reloadData()
                        }
                        else if   newMediaData is JSQLocationMediaItem  {
                            let locationMediatItem       = newMediaData as! JSQLocationMediaItem
                            locationMediatItem.setLocation( newMediaAttachmentCopy as! CLLocation , withCompletionHandler:{ self.collectionView.reloadData() } )
                        }
                        else if   newMediaData is JSQVideoMediaItem     {
                            let videoMediaItem           = newMediaData as! JSQVideoMediaItem
                            videoMediaItem.fileURL       = newMediaAttachmentCopy  as! NSURL
                            videoMediaItem.isReadyToPlay = true
                            self.collectionView.reloadData()
                        }
                        else {
                            NSLog("%s error: unrecognized media item, line :%s", __FUNCTION__, __LINE__)
                        }
                        
                    }
                }
                
        }
    }
    
    func closePressed(sender : UIBarButtonItem ){
        self.delegateModal?.didDismissJSQDemoViewController(self)
    }

    
    
    // ----------------------------------------------------------------------
    // MARK: - JSQMessagesViewController method overrides
    // ----------------------------------------------------------------------
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
    
        /**
        *  Sending a message. Your implementation of this method should do *at least* the following:
        *
        *  1. Play sound (optional)
        *  2. Add new id<JSQMessageData> object to your data source
        *  3. Call `finishSendingMessage`
        */
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        let message : JSQMessage = JSQMessage(    senderId: senderId         ,
                                        senderDisplayName: senderDisplayName,
                                                     date: date             ,
                                                     text: text)
        self.demoData.messages.append(message)
        
        self.finishSendingMessageAnimated(true)
    }
    
    override func didPressAccessoryButton( sender : UIButton ) {
        let  sheet : UIActionSheet = UIActionSheet(title: "Media messages"  ,
                                                delegate: self              ,
                                       cancelButtonTitle: "Cancel"          ,
                                  destructiveButtonTitle: nil               ,
                                       otherButtonTitles: "Send photo", "Send location", "Send video")
        
        
        sheet.showFromToolbar(self.inputToolbar)
    }

    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return;
        }
        
        switch (buttonIndex) {
        case 0:
            self.demoData.addPhotoMediaMessage()
            
        case 1:
            weak var weakView : UICollectionView? = self.collectionView
            self.demoData.addLocationMediaMessageCompletion( { weakView?.reloadData() } )
            
        case 2:
            self.demoData.addVideoMediaMessage()
            
        default:
            // Swift require switch to be exhaustive. 
            NSLog("%s error: unrecognized button index, line :%s", __FUNCTION__, __LINE__)

        }
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        self.finishSendingMessageAnimated(true)
    }
    
    
    
    // ----------------------------------------------------------------------
    // MARK: - JSQMessages CollectionView DataSource
    // ----------------------------------------------------------------------
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.demoData.messages[indexPath.item]
    }

    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
    /**
    *  You may return nil here if you do not want bubbles.
    *  In this case, you should set the background color of your collection view cell's textView.
    *
    *  Otherwise, return your previously created bubble image data objects.
    */
    
        let  message : JSQMessage! = self.demoData.messages[indexPath.item];
        if   message.senderId == self.senderId {
            return self.demoData.outgoingBubbleImageData
        } else {
            return self.demoData.incomingBubbleImageData
        }
    }
    
    override  func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource? {
        
        /**
        *  Return `nil` here if you do not want avatars.
        *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
        *
        *  self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
        *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
        *
        *  It is possible to have only outgoing avatars or only incoming avatars, too.
        */
        
        /**
        *  Return your previously created avatar image data objects.
        *
        *  Note: these the avatars will be sized according to these values:
        *
        *  self.collectionView.collectionViewLayout.incomingAvatarViewSize
        *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize
        *
        *  Override the defaults in `viewDidLoad`
        */
        let message : JSQMessage = self.demoData.messages[indexPath.item]
        
        if message.senderId == self.senderId {
            if !NSUserDefaults.outgoingAvatarSetting() {
                return nil
            }
        } else {
            if !NSUserDefaults.incomingAvatarSetting() {
                return nil;
            }
        }
        
        
        return self.demoData.avatars[message.senderId]
    }

    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString? {
        
        /**
        *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
        *  The other label text delegate methods should follow a similar pattern.
        *
        *  Show a timestamp for every 3rd message
        */
        if (indexPath.item % 3 == 0) {
            let  message : JSQMessage = self.demoData.messages[indexPath.item]
            return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
        }
        
        return nil
    }
    
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString? {
        
        let  message : JSQMessage = self.demoData.messages[indexPath.item]
        
        /**
        *  iOS7-style sender name labels
        */
        if  message.senderId == self.senderId  {
            return nil
        }
        
        if  indexPath.item - 1 > 0 {
            let  previousMessage : JSQMessage = self.demoData.messages[indexPath.item - 1]
            if   previousMessage.senderId == message.senderId  {
                return nil;
            }
        }
        
        /**
        *  Don't specify attributes to use the defaults.
        */
        return NSAttributedString(string: message.senderDisplayName)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString? {
        return nil
    }
    
    
    // ----------------------------------------------------------------------
    // MARK: - UICollectionView DataSource
    // ----------------------------------------------------------------------
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.demoData.messages.count
    }
    

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        /**
        *  Override point for customizing cells
        */
        let cell : JSQMessagesCollectionViewCell = super.collectionView(collectionView, cellForItemAtIndexPath:indexPath) as! JSQMessagesCollectionViewCell
        
        /**
        *  Configure almost *anything* on the cell
        *
        *  Text colors, label text, label colors, etc.
        *
        *
        *  DO NOT set `cell.textView.font` !
        *  Instead, you need to set `self.collectionView.collectionViewLayout.messageBubbleFont` to the font you want in `viewDidLoad`
        *
        *
        *  DO NOT manipulate cell layout information!
        *  Instead, override the properties you want on `self.collectionView.collectionViewLayout` from `viewDidLoad`
        */
        
        let msg : JSQMessage = self.demoData.messages[indexPath.item]
        
        if !msg.isMediaMessage {
            if msg.senderId == self.senderId {
                cell.textView.textColor = UIColor.blackColor()
            }
            else {
                cell.textView.textColor = UIColor.whiteColor()
            }
            
            // TODO: lignes suivantes.
            cell.textView.linkTextAttributes = [ NSForegroundColorAttributeName : cell.textView.textColor ] //,
//                NSUnderlineStyleAttributeName : (.NSUnderlineStyleSingle | .NSUnderlinePatternSolid) ]
        }
        
        return cell
    }
    
    // ----------------------------------------------------------------------
    // MARK: - UICollectionView DataSource
    // ----------------------------------------------------------------------
    
    
}