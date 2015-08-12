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
        let nc = sb.instantiateInitialViewController()
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
        var copyMessage : JSQMessage = self.demoData?.messages.last().copy()
        
        // TODO: change with swift2
        if (copyMessage == nil) {
            copyMessage = JSQMessage(senderId: demoData?.kJSQDemoAvatarIdJobs,
                                  displayName: demoData?.kJSQDemoAvatarDisplayNameJobs,
                                         text: "First received!")
        }
        
        /**
        *  Allow typing indicator to show
        */
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
            
            var userIds                 = self.demoData.users.allKeys
            userIds.removeObject(self.senderId)
            
            let randomUserId            = userIds[ arc4random_uniform((int)userIds.count()) ];
            let userDisplayedName       = self.demoData.users[randomUserId]
            
            
            var newMessage              : JSQMessage?
            var newMediaData            : JSQMessageMediaData?
            var newMediaAttachmentCopy  : AnyObject?
            
            // TODO: use a switch case to match class here.
            if ( copyMessage.isMediaMessage() ) {
                /**
                *  Last message was a media message
                */
                let copyMediaData : JSQMessageMediaData = copyMessage.media;
                
                if ( copyMediaData.isKindOfClass( JSQPhotoMediaItem.class() ) ) {
                    let photoItemCopy : JSQPhotoMediaItem           = (copyMediaData as JSQPhotoMediaItem).copy()
                    photoItemCopy.appliesMediaViewMaskAsOutgoing    = false
                    newMediaAttachmentCopy                          = UIImage( CGImage: photoItemCopy.image.CGImage )
                    
                    /**
                    *  Set image to nil to simulate "downloading" the image
                    *  and show the placeholder view
                    */
                    photoItemCopy.image = nil
                    
                    newMediaData = photoItemCopy
                }
                else if ( copyMediaData.isKindOfClass( JSQLocationMediaItem.class() ) ) {
                    let locationItemCopy : JSQLocationMediaItem?    = (copyMediaData as JSQLocationMediaItem).copy()
                    locationItemCopy.appliesMediaViewMaskAsOutgoing = false
                    newMediaAttachmentCopy                          = locationItemCopy.location.copy()
                    
                    /**
                    *  Set location to nil to simulate "downloading" the location data
                    */
                    locationItemCopy.location                       = nil
                    newMediaData                                    = locationItemCopy
                }
                else if ( copyMediaData.isKindOfClass( JSQVideoMediaItem.class(   ) ) ) {
                    let videoItemCopy : JSQVideoMediaItem           = (copyMediaData as JSQVideoMediaItem).copy()
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
                    NSLog("%s error: unrecognized media item", __PRETTY_FUNCTION__)
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
            self.demoData.messages.addObject(newMessage)
            self.finishReceivingMessageAnimated(true)
            
            //-------- TODO: From here
            if (newMessage.isMediaMessage) {
                /**
                *  Simulate "downloading" media
                */
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue()) {
                    /**
                    *  Media is "finished downloading", re-display visible cells
                    *
                    *  If media cell is not visible, the next time it is dequeued the view controller will display its new attachment data
                    *
                    *  Reload the specific item, or simply call `reloadData`
                    */
                    
                    if (      newMediaData.isKindOfClass( JSQPhotoMediaItem.   class() )  ) {
                        let photoMediaItem           = newMediaData as JSQPhotoMediaItem
                        photoMediaItem.image         = newMediaAttachmentCopy
                        self.collectionView.reloadData()
                    }
                    else if ( newMediaData.isKindOfClass( JSQLocationMediaItem.class() )  ) {
                        let locationMediatItem       = newMediaData as JSQLocationMediaItem
                        locationMediatItem.setLocation( newMediaAttachmentCopy, withCompletionHandler:{ self.collectionView.reloadData() } )
                    }
                    else if ( newMediaData.isKindOfClass( JSQVideoMediaItem.   class() )  ) {
                        let videoMediaItem           = newMediaData as JSQVideoMediaItem
                        videoMediaItem.fileURL       = newMediaAttachmentCopy
                        videoMediaItem.isReadyToPlay = true
                        self.collectionView.reloadData()
                    }
                    else {
                        NSLog("%s error: unrecognized media item", __PRETTY_FUNCTION__)
                    }
                    
                }
            }
            
        }
    }
    
    func closePressed(sender : UIBarButtonItem ){
        self.delegateModal?.didDismissJSQDemoViewController(self)
    }

    
    
    
    
    
    
    
    
    
    
    
    
}