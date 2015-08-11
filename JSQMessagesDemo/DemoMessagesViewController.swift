//
//  DemoMessagesViewController.swift
//  JSQMessages
//
//  Created by Raphaël Bellec on 11/08/2015.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

import Foundation
import UIKit


class DemoMessagesViewController : JSQMessagesViewController, UIActionSheetDelegate {
    
    // var id<JSQDemoViewControllerDelegate> delegateModal;
    var  demoData : DemoModelData!
    
    
    // ----------------------------------------------------------------------
    // View lifecycle
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
    
}