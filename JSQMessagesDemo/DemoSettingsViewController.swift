//
//  DemoMessagesViewController.swift
//  JSQMessages
//
//  Created by Raphaël Bellec on 11/08/2015.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

import Foundation

class DemoMessagesViewController : UITableViewController {
    
    @IBOutlet var extraMessagesSwitch   : UISwitch!
    @IBOutlet var longMessageSwitch     : UISwitch!
    @IBOutlet var emptySwitch           : UISwitch!
    @IBOutlet var incomingAvatarsSwitch : UISwitch!
    @IBOutlet var outgoingAvatarsSwitch : UISwitch!
    @IBOutlet var springySwitch         : UISwitch!

    // --------- View Lifecycle
    override func viewDidLoad() {
        self.extraMessagesSwitch.on   = NSUserDefaults.extraMessagesSetting()
        self.longMessageSwitch.on     = NSUserDefaults.longMessageSetting()
        self.emptySwitch.on           = NSUserDefaults.emptyMessagesSetting()
        
        self.incomingAvatarsSwitch.on = NSUserDefaults.incomingAvatarSetting()
        self.outgoingAvatarsSwitch.on = NSUserDefaults.outgoingAvatarSetting()
        
        self.springySwitch.on         = NSUserDefaults.springinessSetting()
    }
    
    
    
    
    
}


