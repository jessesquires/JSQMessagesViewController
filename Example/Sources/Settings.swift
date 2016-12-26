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


fileprivate enum Key: String {
    case presentModal

    case extraMessages
    case longMessage
    case emptyMessages

    case incomingAvatars
    case outgoingAvatars
    case accessoryForMedia

    case springyBubbles
}


extension UserDefaults {
    fileprivate func bool(key: Key) -> Bool {
        return bool(forKey: key.rawValue)
    }

    fileprivate func set(_ value: Bool, key: Key) {
        set(value, forKey: key.rawValue)
    }
}


final class Settings {
    static let shared = Settings()

    fileprivate let defaults = UserDefaults.standard

    private init() { }
}


extension Settings {
    var presentModally: Bool {
        get {
            return defaults.bool(key: .presentModal)
        }
        set {
            defaults.set(newValue, key: .presentModal)
        }
    }
}


extension Settings {
    var extraMessages: Bool {
        get {
            return defaults.bool(key: .extraMessages)
        }
        set {
            defaults.set(newValue, key: .extraMessages)
        }
    }

    var longMessage: Bool {
        get {
            return defaults.bool(key: .longMessage)
        }
        set {
            defaults.set(newValue, key: .longMessage)
        }
    }

    var emptyMessages: Bool {
        get {
            return defaults.bool(key: .emptyMessages)
        }
        set {
            defaults.set(newValue, key: .emptyMessages)
        }
    }
}


extension Settings {
    var incomingAvatars: Bool {
        get {
            return defaults.bool(key: .incomingAvatars)
        }
        set {
            defaults.set(newValue, key: .incomingAvatars)
        }
    }

    var outgoingAvatar: Bool {
        get {
            return defaults.bool(key: .outgoingAvatars)
        }
        set {
            defaults.set(newValue, key: .outgoingAvatars)
        }
    }

    var accessoryForMedia: Bool {
        get {
            return defaults.bool(key: .accessoryForMedia)
        }
        set {
            defaults.set(newValue, key: .accessoryForMedia)
        }
    }
}


extension Settings {
    var springyBubbles: Bool {
        get {
            return defaults.bool(key: .springyBubbles)
        }
        set {
            defaults.set(newValue, key: .springyBubbles)
        }
    }
}
