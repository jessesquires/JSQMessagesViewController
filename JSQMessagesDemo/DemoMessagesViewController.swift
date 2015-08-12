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

    
}