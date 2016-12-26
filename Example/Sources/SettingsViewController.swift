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
//  Copyright © 2014-present Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import UIKit

final class SettingsViewController: UITableViewController {

    let settings = Settings.shared

    // MARK: Outlets

    @IBOutlet weak var modalSwitch: UISwitch!

    @IBOutlet weak var extraMessagesSwitch: UISwitch!
    @IBOutlet weak var longMessageSwitch: UISwitch!
    @IBOutlet weak var emptyMessagesSwitch: UISwitch!

    @IBOutlet weak var incomingAvatarSwitch: UISwitch!
    @IBOutlet weak var outgoingAvatarSwitch: UISwitch!
    @IBOutlet weak var accessoryForMediaSwitch: UISwitch!

    @IBOutlet weak var springBubblesSwitch: UISwitch!

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        modalSwitch.isOn = settings.presentModally

        extraMessagesSwitch.isOn = settings.extraMessages
        longMessageSwitch.isOn = settings.longMessage
        emptyMessagesSwitch.isOn = settings.emptyMessages

        incomingAvatarSwitch.isOn = settings.incomingAvatars
        outgoingAvatarSwitch.isOn = settings.outgoingAvatar
        accessoryForMediaSwitch.isOn = settings.accessoryForMedia

        springBubblesSwitch.isOn = settings.springyBubbles
    }

    // MARK: Actions

    @IBAction func didFlipSwitch(_ sender: UISwitch) {
        let value = sender.isOn

        switch sender {
        case modalSwitch:
            settings.presentModally = value

        case extraMessagesSwitch:
            settings.extraMessages = value

        case longMessageSwitch:
            settings.longMessage = value

        case emptyMessagesSwitch:
            settings.emptyMessages = value

        case incomingAvatarSwitch:
            settings.incomingAvatars = value

        case outgoingAvatarSwitch:
            settings.outgoingAvatar = value

        case accessoryForMediaSwitch:
            settings.accessoryForMedia = value

        case springBubblesSwitch:
            settings.springyBubbles = value

        default:
            fatalError()
        }
    }
}
