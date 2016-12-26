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


struct Bubbles {
    let incoming: JSQMessagesBubbleImage
    let outgoing: JSQMessagesBubbleImage

    init() {
        let factory = JSQMessagesBubbleImageFactory()
        self.incoming = factory.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        self.outgoing = factory.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
}
