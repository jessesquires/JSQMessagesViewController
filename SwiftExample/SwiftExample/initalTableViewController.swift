//
//  initalTableViewController.swift
//  SwiftExample
//
//  Created by P D Leonard on 7/15/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit

enum RowTypes: Int {
    case GroupConversation
    case Conversation
    case Settings
}

class initalTableViewController: UITableViewController {
    private let rows:[RowTypes] = [.Conversation, .GroupConversation, .Settings]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        prepareTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        self.navigationItem.title = "JSQ implimented in Swift"
        self.tableView = UITableView(frame: tableView.frame, style: .Grouped)
    }
    
    func prepareTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Examples"
        default:
            return ""
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func getTextForCell(row: RowTypes) -> String {
        switch  row {
        case .Conversation:
            return "Conversation"
        case .GroupConversation:
            return "Group conversation"
        case .Settings:
            return "Settings"
        }
    }
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            let index = indexPath.section + indexPath.row
            let row = rows[index]
            cell.textLabel?.text = getTextForCell(row)
            return cell
        case 1:
            let index = indexPath.section + indexPath.row + 1
            let row = rows[index]
            cell.textLabel?.text = getTextForCell(row)
            return cell
        default:
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let chatView = ChatViewController()
                chatView.messages = makeNormalConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                presentViewController(chatNavigationController, animated: true, completion: nil)
            case 1:
                let chatView = ChatViewController()
                chatView.messages = makeGroupConversation()
                let chatNavigationController = UINavigationController(rootViewController: chatView)
                presentViewController(chatNavigationController, animated: true, completion: nil)
            default:
                return
            }
        case 1:
            switch indexPath.row {
            case 0:
                
                let settingsView =  UINavigationController(rootViewController: SettingsTableViewController())
                self.presentViewController(settingsView, animated: true, completion: nil)
            default:
                return
            }
        default:
            return
        }
    }
}
