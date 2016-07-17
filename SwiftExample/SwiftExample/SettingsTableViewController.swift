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

enum Setting {
    case bubbleTails, senderDisplayName, removeAvatars
}

let defaults = NSUserDefaults.standardUserDefaults()

class SettingsTableViewController: UITableViewController {
    let rows: [Setting] = [.bubbleTails, .senderDisplayName, .removeAvatars]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init () {
        super.init(nibName: nil, bundle: nil)
        // Give the table view style.
        self.tableView = UITableView(frame: tableView.frame, style: .Grouped)
    }
    
    //Mark: Navigaton
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        prepareTable()
    }
    
    func prepareTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tailessBubblesTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: taillessSettingKey)
    }
    
    func removeDisplayNameTapped(sender: AnyObject) {
        defaults.setBool(sender.on, forKey: removeSenderDisplayNameKey)
    }
    
    func removeAvatarsTapped(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: avatarSettingKey)
    }
    
    
    func getTitleForCell(setting: Setting) -> String {
        switch setting {
        case .bubbleTails:
            return "Remove Message Bubble Tails"
        case.removeAvatars:
            return "Remove Avatars"
        case.senderDisplayName:
            return "Remove Sender Display Name"
        }
    }
    
    func getKeyForSetting(setting: Setting) -> String {
        switch setting {
        case .bubbleTails:
            return taillessSettingKey
        case.removeAvatars:
            return avatarSettingKey
        case.senderDisplayName:
            return removeSenderDisplayNameKey
        }
    }
    
    func addActionToSwitch(setting: Setting, settingSwitch: UISwitch) {
        switch setting {
        case .bubbleTails:
            settingSwitch.addTarget(self, action: #selector(tailessBubblesTapped), forControlEvents: .TouchUpInside)
        case.removeAvatars:
            settingSwitch.addTarget(self, action: #selector(removeAvatarsTapped), forControlEvents: .TouchUpInside)
        case.senderDisplayName:
            settingSwitch.addTarget(self, action: #selector(removeDisplayNameTapped), forControlEvents: .TouchUpInside)
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let setting = rows[indexPath.item]
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = getTitleForCell(setting)
        let settingSwitch = UISwitch()
        settingSwitch.on = defaults.boolForKey(getKeyForSetting(setting))
        addActionToSwitch(setting, settingSwitch: settingSwitch)
        cell.accessoryView = settingSwitch
        
        return cell
    }
    
}
