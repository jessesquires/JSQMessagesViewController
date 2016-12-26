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


final class MessagesViewController: JSQMessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func senderId() -> String {
        return "id"
    }

    override func senderDisplayName() -> String {
        return "jsq"
    }

}
