//
//  SettingsTableViewController.swift
//  SwiftExample
//
//  Created by Dan Leonard on 5/15/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

let cellReuseIdentifier = "settingsCell"

public enum Setting: String{
    case removeBubbleTails = "Remove message bubble tails"
    case removeSenderDisplayName = "Remove sender Display Name"
    case removeAvatar = "Remove Avatars"
}

let defaults = NSUserDefaults.standardUserDefaults()
var rows = [Setting]()
class SettingsTableViewController: UITableViewController {
    
    //MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        rows = [.removeAvatar, .removeBubbleTails, .removeSenderDisplayName]
        // Set the Switch to the currents settings
        self.title = "Settings"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
        // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) else {
            return UITableViewCell()
        }
        let row = rows[indexPath.row]
        let settingSwitch = UISwitch()
        settingSwitch.tag = indexPath.row
        settingSwitch.on = defaults.boolForKey(row.rawValue) ?? false
        settingSwitch.addTarget(self, action: #selector(switchValueChanged), forControlEvents: .ValueChanged)
        
        cell.accessoryView = settingSwitch
        cell.textLabel?.text = row.rawValue
        
        return cell
    }
    func switchValueChanged(sender: UISwitch) {
        defaults.setBool(sender.on, forKey: rows[sender.tag].rawValue)
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //Mark: - Table view delegate
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
