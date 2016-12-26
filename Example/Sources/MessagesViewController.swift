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


protocol MessagesViewControllerDelegate: class {
    func didDismiss(messagesViewController: MessagesViewController) -> Void
}


final class MessagesViewController: JSQMessagesViewController,
JSQMessagesComposerTextViewPasteDelegate {

    weak var modalDelegate: MessagesViewControllerDelegate?

    let dataSource = DataSource()
    let settings = Settings.shared

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "JSQMessages"
        inputToolbar.contentView?.textView?.pasteDelegate = self

        if !settings.incomingAvatars {
            collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        }

        if !settings.outgoingAvatar {
            collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        }

        showLoadEarlierMessagesHeader = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapReceiveMessage(sender:)))

        // TODO: menu actions
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if modalDelegate != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: self,
                                                               action: #selector(didTapClose(sender:)))
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        /**
         *  Enable/disable springy bubbles, default is NO.
         *  You must set this from `viewDidAppear:`
         *  Note: this feature is mostly stable, but still experimental
         */
        collectionView?.collectionViewLayout.springinessEnabled = settings.springyBubbles
    }

    // MARK: JSQMessagesCollectionViewDataSource

    override func senderId() -> String {
        return dataSource.senderId
    }

    override func senderDisplayName() -> String {
        return dataSource.senderName
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return dataSource.messages[indexPath.item]
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 didDeleteMessageAt indexPath: IndexPath) {
        dataSource.messages.remove(at: indexPath.item)
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource? {
        let message = dataSource.messages[indexPath.item]

        let isOutgoing = message.senderId == dataSource.senderId
        if isOutgoing {
            return dataSource.bubbles.outgoing
        }

        return dataSource.bubbles.incoming
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        let message = dataSource.messages[indexPath.item]
        let avatar = dataSource.allUsers[message.senderId]?.avatar

        let isOutgoing = message.senderId == dataSource.senderId
        if isOutgoing {
            return settings.outgoingAvatar ? avatar : nil
        }

        return settings.incomingAvatars ? avatar : nil
    }

    // MARK:  UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.messages.count
    }

    // MARK: Actions

    @objc func didTapReceiveMessage(sender: UIBarButtonItem) {
        // TODO: simulate receiving messages
    }

    @objc func didTapClose(sender: UIBarButtonItem) {
        modalDelegate?.didDismiss(messagesViewController: self)
    }


    // MARK: JSQMessagesComposerTextViewPasteDelegate

    func composerTextView(_ textView: JSQMessagesComposerTextView, shouldPasteWithSender sender: Any) -> Bool {
        // TODO:
        
        return true
    }
    
}
