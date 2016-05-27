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

let removeAvatarsKey = "removeAvatars"


let defaults = NSUserDefaults.standardUserDefaults()

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var RemoveBubbleTailsSwitch: UISwitch!
    @IBOutlet weak var removeAvatarsSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeAvatarsSwitch.on = defaults.boolForKey(removeAvatarsKey)
        RemoveBubbleTailsSwitch.on = defaults.boolForKey(taillessSettingKey)
    }
    
    @IBAction func taillessSettingTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: taillessSettingKey)
    }
    
    @IBAction func removeAvatarsTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: removeAvatarsKey)
    }
    
}