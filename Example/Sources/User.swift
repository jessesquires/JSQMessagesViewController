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

fileprivate let avatarSize = UInt(kJSQMessagesCollectionViewAvatarSizeDefault)
fileprivate let avatarFactory = JSQMessagesAvatarImageFactory(diameter: avatarSize)


final class User {
    let name: String
    let avatar: JSQMessagesAvatarImage

    let id = UUID().uuidString

    init(name: String, avatar: JSQMessagesAvatarImage) {
        self.name = name
        self.avatar = avatar
    }
}


extension User {
    static func jsq() -> User {
        let image = avatarFactory.avatarImage(withUserInitials: "JSQ",
                                              backgroundColor: UIColor(white: 0.85, alpha: 1.0),
                                              textColor: UIColor(white:0.6, alpha: 1.0),
                                              font: UIFont.systemFont(ofSize: 14.0))
        return User(name: "Jesse Squires", avatar: image)
    }

    static func jobs() -> User {
        let image = avatarFactory.avatarImage(with: UIImage(named: "avatar_jobs")!)
        return User(name: "Jobs", avatar: image)
    }

    static func woz() -> User {
        let image = avatarFactory.avatarImage(with: UIImage(named: "avatar_woz")!)
        return User(name: "Steve Wozniak", avatar: image)
    }

    static func cook() -> User {
        let image = avatarFactory.avatarImage(with: UIImage(named: "avatar_cook")!)
        return User(name: "Tim Cook", avatar: image)
    }
}
