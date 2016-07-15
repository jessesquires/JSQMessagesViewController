//
//  SettingsTableViewController.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/15/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

//MARK: SettingKeys
let taillessSettingKey              = "taillessSetting"
let removeSenderDisplayNameKey      = "senderDisplayName"
let avatarSettingKey                = "avatarSetting"

let defaults = NSUserDefaults.standardUserDefaults()

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var removeBubbleTailsSwitch: UISwitch!
    @IBOutlet weak var senderDisplayNameSwitch: UISwitch!
    @IBOutlet weak var removeAvatarSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the Switch to the currents settings
        removeBubbleTailsSwitch.on = defaults.boolForKey(taillessSettingKey)
        senderDisplayNameSwitch.on = defaults.boolForKey(removeSenderDisplayNameKey)
        removeAvatarSwitch.on = defaults.boolForKey(avatarSettingKey)
    }
    
    @IBAction func taillessSettingTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: taillessSettingKey)
    }
    
    @IBAction func senderDisplayNameTapped(sender: AnyObject) {
        defaults.setBool(sender.on, forKey: removeSenderDisplayNameKey)
    }
    
    @IBAction func avatarSettingTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: avatarSettingKey)
    }
    
}