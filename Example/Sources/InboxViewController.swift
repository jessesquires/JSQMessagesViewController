//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright © 2013-present Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import UIKit
import JSQMessagesViewController


final class InboxViewController: UITableViewController, MessagesViewControllerDelegate {

    // MARK: Properties

    let settings = Settings.shared

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = "Jobs, Woz, Cook"
        cell.detailTextLabel?.text = "Now"
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Messages"
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MessagesViewController()

        if settings.presentModally {
            controller.modalDelegate = self
            let nav = UINavigationController(rootViewController: controller)
            present(nav, animated: true, completion: nil)
        }
        else {
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: MessagesViewControllerDelegate

    func didDismiss(messagesViewController: MessagesViewController) {
        dismiss(animated: true, completion: nil)
    }
}
