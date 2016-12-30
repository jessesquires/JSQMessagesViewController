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


let jsq = User.jsq()
let jobs = User.jobs()
let woz = User.woz()
let cook = User.cook()


final class DataSource {

    private let settings = Settings.shared

    let bubbles = Bubbles()
    let allUsers = [
        jsq.id : jsq,
        jobs.id : jobs,
        woz.id : woz,
        cook.id : cook
    ]

    var messages = [JSQMessage]()

    var senderId: String {
        return jsq.id
    }

    var senderName: String {
        return jsq.name
    }

    init() {
        self.messages = loadFakeMessages()
    }

    private func loadFakeMessages() -> [JSQMessage] {
        var messages = [JSQMessage]()
        if settings.emptyMessages {
            return messages
        }

        messages.append(JSQMessage(senderId: jsq.id,
                                   senderDisplayName: jsq.name,
                                   date: Date.distantPast,
                                   text: "Welcome to JSQMessages: A messaging UI framework for iOS."))

        messages.append(JSQMessage(senderId: woz.id,
                                   senderDisplayName: woz.name,
                                   date: Date.distantPast,
                                   text: "It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy."))

        messages.append(JSQMessage(senderId: jsq.id,
                                   senderDisplayName: jsq.name,
                                   date: Date.distantPast,
                                   text: "It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com."))

        messages.append(JSQMessage(senderId: jobs.id,
                                   senderDisplayName: jobs.name,
                                   date: Date(),
                                   text: "JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better."))

        messages.append(JSQMessage(senderId: cook.id,
                                   senderDisplayName: cook.name,
                                   date: Date(),
                                   text: "It is unit-tested, free, open-source, and documented."))

        messages.append(JSQMessage(senderId: jsq.id,
                                   senderDisplayName: jsq.name,
                                   date: Date(),
                                   text: "Now with media messages!"))

        if settings.extraMessages {
            for _ in 0..<4 {
                messages.append(contentsOf: messages)
            }
        }

        if settings.longMessage {
            messages.append(JSQMessage(senderId: jsq.id,
                                       senderDisplayName: jsq.name,
                                       date: Date(),
                                       text: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END"))
        }

        return messages
    }

    func appendPhotoMessage() {
        // TODO:
    }

    func appendAudioMessage() {
        // TODO:
    }

    func appendLocationMessage() {
        // TODO:
    }

    func appendVideoMessage(withThumbnail: Bool = false) {
        // TODO:
    }
}
