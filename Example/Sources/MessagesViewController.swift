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
JSQMessagesComposerTextViewPasteDelegate,
JSQMessagesViewAccessoryButtonDelegate {

    weak var modalDelegate: MessagesViewControllerDelegate?

    /**
     *  Load up our fake data for the demo
     */
    let dataSource = DataSource()
    let settings = Settings.shared

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "JSQMessages"
        inputToolbar.contentView?.textView?.pasteDelegate = self

        /**
         *  Set up message accessory button delegate and configuration
         */
        collectionView?.accessoryDelegate = self

        /**
         *  You can set custom avatar sizes
         */
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

        /**
         *  Register custom menu actions for cells.
         */
        JSQMessagesCollectionViewCell.registerMenuAction(#selector(customAction(_:)))
        JSQMessagesCollectionViewCell.registerMenuAction(#selector(delete(_:)))

        /**
         *  Customize your toolbar buttons
         *
         *  inputToolbar.contentView.leftBarButtonItem = custom button or nil to remove
         *  inputToolbar.contentView.rightBarButtonItem = custom button or nil to remove
         */

        /**
         *  Set a maximum height for the input toolbar
         *
         *  inputToolbar.maximumHeight = 150;
         */
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
        /**
         *  You may return nil here if you do not want bubbles.
         *  In this case, you should set the background color of your collection view cell's textView.
         *
         *  Otherwise, return your previously created bubble image data objects.
         */
        let message = dataSource.messages[indexPath.item]

        let isOutgoing = message.senderId == senderId()
        if isOutgoing {
            return dataSource.bubbles.outgoing
        }

        return dataSource.bubbles.incoming
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView,
                                 avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        /**
         *  Return `nil` here if you do not want avatars.
         *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
         *
         *  self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
         *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
         *
         *  It is possible to have only outgoing avatars or only incoming avatars, too.
         */

        /**
         *  Return your previously created avatar image data objects.
         *
         *  Note: these the avatars will be sized according to these values:
         *
         *  self.collectionView.collectionViewLayout.incomingAvatarViewSize
         *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize
         *
         *  Override the defaults in `viewDidLoad`
         */
        let message = dataSource.messages[indexPath.item]
        let avatar = dataSource.allUsers[message.senderId]?.avatar

        let isOutgoing = message.senderId == senderId()
        if isOutgoing {
            return settings.outgoingAvatar ? avatar : nil
        }

        return settings.incomingAvatars ? avatar : nil
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        // TODO:
        return nil
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        // TODO:
        return nil
    }

    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForCellBottomLabelAt indexPath: IndexPath) -> NSAttributedString? {
        return nil
    }

    // MARK:  UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell

        let message = dataSource.messages[indexPath.item]
        if !message.isMediaMessage {
            if message.senderId == senderId() {
                cell.textView?.textColor = .black
            }
            else {
                cell.textView?.textColor = .white
            }

            cell.textView?.linkTextAttributes = [
                NSForegroundColorAttributeName : cell.textView!.textColor!,
                NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle
            ]
        }

        cell.accessoryButton?.isHidden = !(message.isMediaMessage && settings.accessoryForMedia)

        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView,
                        canPerformAction action: Selector,
                        forItemAt indexPath: IndexPath,
                        withSender sender: Any?) -> Bool {
        if action == #selector(customAction(_:)) {
            return true
        }

        return super.canPerformAction(action, withSender: sender)
    }

    override func collectionView(_ collectionView: UICollectionView,
                        performAction action: Selector,
                        forItemAt indexPath: IndexPath,
                        withSender sender: Any?) {
        if action == #selector(customAction(_:)) {
            customAction(sender)
            return
        }

        super.collectionView(collectionView, performAction: action, forItemAt: indexPath, withSender: sender)
    }


    // MARK: Custom menu actions for cells

    override func didReceiveMenuWillShow(_ notification: Notification) {
        /**
         *  Display custom menu actions for cells.
         */
        let menu = notification.object as! UIMenuController
        menu.menuItems = [ UIMenuItem(title: "Custom Action", action: #selector(customAction(_:))) ]

        super.didReceiveMenuWillShow(notification)
    }

    @objc func customAction(_ sender: Any?) {
        let alert = UIAlertController(title: "Custom action", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: Actions

    @objc func didTapReceiveMessage(sender: UIBarButtonItem) {
        showTypingIndicator = !showTypingIndicator

        scrollToBottom(animated: true)

        var lastMessage = dataSource.messages.last
        if lastMessage == nil {
            lastMessage = JSQMessage(senderId: jobs.id, displayName: jobs.name, text: "First message!")
        }

        // TODO: simulate receiving messages

    }

    @objc func didTapClose(sender: UIBarButtonItem) {
        modalDelegate?.didDismiss(messagesViewController: self)
    }

    // MARK: Overrides

    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)

        dataSource.messages.append(message)

        finishSendingMessage()
    }

    override func didPressAccessoryButton(_ sender: UIButton) {
        // TODO: accessory button
    }

    // MARK: JSQMessagesComposerTextViewPasteDelegate

    func composerTextView(_ textView: JSQMessagesComposerTextView, shouldPasteWithSender sender: Any) -> Bool {
        // TODO:
        
        return true
    }

    // MARK: JSQMessagesViewAccessoryButtonDelegate

    func messageView(_ messageView: JSQMessagesCollectionView, didTapAccessoryButtonAt indexPath: IndexPath) {
        print(#function)
    }
}
