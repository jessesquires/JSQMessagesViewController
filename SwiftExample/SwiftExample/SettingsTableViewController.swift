//
//  SettingsTableViewController.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/15/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

//MARK: SettingKeys
let taillessSettingKey = "taillessSetting"
let avatarSettingKey = "avatarSetting"

let defaults = NSUserDefaults.standardUserDefaults()

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var RemoveBubbleTailsSwitch: UISwitch!
    @IBOutlet weak var removeAvatarSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RemoveBubbleTailsSwitch.on = defaults.boolForKey(taillessSettingKey)
        removeAvatarSwitch.on = defaults.boolForKey(avatarSettingKey)
    }
    
    @IBAction func taillessSettingTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: taillessSettingKey)
    }
    
    @IBAction func avatarSettingTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: avatarSettingKey)
    }
    
}