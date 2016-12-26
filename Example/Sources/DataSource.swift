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


import Foundation
import UIKit
import JSQMessagesViewController


fileprivate let jsq = User.jsq()
fileprivate let jobs = User.jobs()
fileprivate let woz = User.woz()
fileprivate let cook = User.cook()


final class DataSource {

    private let settings = Settings.shared

    let bubbles = Bubbles()
    let allUsers = [jsq, jobs, woz, cook]
    var messages = [JSQMessage]()

    init() {
        if (!settings.emptyMessages) {
            self.messages = loadFakeMessages()
        }
    }

    private func loadFakeMessages() -> [JSQMessage] {
        let messages = [JSQMessage]()

        

        return messages
    }

}
