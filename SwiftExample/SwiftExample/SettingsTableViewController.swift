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

let defaults = UserDefaults.standard
var rows = [Setting]()
class SettingsTableViewController: UITableViewController {
    
    //MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        rows = [.removeAvatar, .removeBubbleTails, .removeSenderDisplayName]
        // Set the Switch to the currents settings
        self.title = "Settings"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
        // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) else {
            return UITableViewCell()
        }
        let row = rows[indexPath.row]
        let settingSwitch = UISwitch()
        settingSwitch.tag = indexPath.row
        settingSwitch.isOn = defaults.bool(forKey: row.rawValue) 
        settingSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
        cell.accessoryView = settingSwitch
        cell.textLabel?.text = row.rawValue
        
        return cell
    }
    func switchValueChanged(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: rows[sender.tag].rawValue)
    }
    
    func setupBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    //Mark: - Table view delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
