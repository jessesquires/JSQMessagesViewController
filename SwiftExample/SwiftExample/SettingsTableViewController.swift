//
//  SettingsTableViewController.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/15/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

//MARK: SettingKeys
let taillessSettingKey      = "taillessSetting"
let senderDisplayNameKey    = "senderDisplayName"

let defaults = NSUserDefaults.standardUserDefaults()

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var RemoveBubbleTailsSwitch: UISwitch!
    @IBOutlet weak var SenderDisplayNameSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the Switch to the currents settings
        RemoveBubbleTailsSwitch.on = defaults.boolForKey(taillessSettingKey)
        SenderDisplayNameSwitch.on = defaults.boolForKey(senderDisplayNameKey)
    }
    
    @IBAction func taillessSettingTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: taillessSettingKey)
    }
    
    @IBAction func SenderDisplayNameTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: senderDisplayNameKey)
    }
    
    
}