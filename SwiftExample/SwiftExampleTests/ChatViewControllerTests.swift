//
//  ViewControllertTests.swift
//  SwiftExample
//
//  Created by Gianni Carlo on 5/30/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import UIKit
import XCTest
import JSQMessagesViewController
@testable import SwiftExample

class ChatViewControllerTests: XCTestCase {
    let defaults = UserDefaults.standard
    let chatViewController = ChatViewController()
    
    override func setUp() {
        super.setUp()
        let chatViewController = ChatViewController()
        chatViewController.messages = makeNormalConversation()
        
        // This ensures that ViewDidLoad() has been called
        let _ = chatViewController.view
       
    }
    override func tearDown() {
        super.tearDown()
        defaults.set(false, forKey: Setting.removeAvatar.rawValue)
        defaults.set(false, forKey: Setting.removeSenderDisplayName.rawValue)
        defaults.set(false, forKey: Setting.removeBubbleTails.rawValue)
    }
    
    func testSendButtonAction() {
        let _ = chatViewController.view
        let button = self.chatViewController.inputToolbar.sendButtonLocation == .right ? self.chatViewController.inputToolbar.contentView!.rightBarButtonItem! : self.chatViewController.inputToolbar.contentView!.leftBarButtonItem!
        let text = "Testing text"
        let senderId = self.chatViewController.senderId()
        let senderDisplayName = self.chatViewController.senderDisplayName()
        let date = Date()
        
        let originalCount = self.chatViewController.messages.count
        
        self.chatViewController.didPressSend(button, withMessageText: text, senderId: senderId, senderDisplayName: senderDisplayName, date: date)
        
        let newCount = self.chatViewController.messages.count
        
        XCTAssert(newCount == (originalCount + 1))
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage.senderId == senderId)
        XCTAssert(newMessage.senderDisplayName == senderDisplayName)
        XCTAssert(newMessage.date == date)
        XCTAssert(newMessage.text == text)
    }
    
    func testSendImage() {
        let senderId = self.chatViewController.senderId()
        let senderDisplayName = self.chatViewController.senderDisplayName()
        
        let photoItem = JSQPhotoMediaItem(image: UIImage(named: "goldengate"))
        self.chatViewController.addMedia(photoItem)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage.senderId == senderId)
        XCTAssert(newMessage.senderDisplayName == senderDisplayName)
        XCTAssert(newMessage.media is JSQPhotoMediaItem)
        
    }
    
    func testSendLocation() {
        let senderId = self.chatViewController.senderId()
        let senderDisplayName = self.chatViewController.senderDisplayName()
        
        let locationItem = self.chatViewController.buildLocationItem()
        
        self.chatViewController.addMedia(locationItem)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage.senderId == senderId)
        XCTAssert(newMessage.senderDisplayName == senderDisplayName)
        XCTAssert(newMessage.media is JSQLocationMediaItem)
        
    }
    
    func testSendVideo() {
        let senderId = self.chatViewController.senderId()
        let senderDisplayName = self.chatViewController.senderDisplayName()
        
        let videoItem = self.chatViewController.buildVideoItem()
        
        self.chatViewController.addMedia(videoItem)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage.senderId == senderId)
        XCTAssert(newMessage.senderDisplayName == senderDisplayName)
        XCTAssert(newMessage.media is JSQVideoMediaItem)
        
    }
    
    func testSendAudio() {
        let senderId = self.chatViewController.senderId()
        let senderDisplayName = self.chatViewController.senderDisplayName()
        
        let audioItem = self.chatViewController.buildAudioItem()
        
        self.chatViewController.addMedia(audioItem)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage.senderId == senderId)
        XCTAssert(newMessage.senderDisplayName == senderDisplayName)
        XCTAssert(newMessage.media is JSQAudioMediaItem)
    }
    
    /**
     * Test when the messages array is empty, it should add a new incoming text message
     * Test when the messages array last message is a text message, it should add a new incoming text message
     */
    func testSimulatedIncomingTextMessage() {
        self.chatViewController.messages = []
        let _ = chatViewController.view
        self.chatViewController.collectionView!.reloadData()
        
        // trigger action
        let rightBarButton = self.chatViewController.navigationItem.rightBarButtonItem!
        rightBarButton.target!.perform(rightBarButton.action, with: rightBarButton)
        
        let lastMessage = self.chatViewController.messages.last!
        
        XCTAssert(!lastMessage.isMediaMessage)
        XCTAssert(lastMessage.senderId != self.chatViewController.senderId())
        XCTAssert(lastMessage.senderDisplayName != self.chatViewController.senderDisplayName())
        
        // triger action
        rightBarButton.target!.perform(rightBarButton.action, with: rightBarButton)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage != lastMessage)
        XCTAssert(!newMessage.isMediaMessage)
        XCTAssert(newMessage.senderId != self.chatViewController.senderId())
        XCTAssert(newMessage.senderDisplayName != self.chatViewController.senderDisplayName())
    }
    
    /**
     * Simulate that last message is an image and test message received functionality
     */
    func testSimulatedIncomingImage() {
        
        // add image
        let photoItem = JSQPhotoMediaItem(image: UIImage(named: "goldengate"))
        self.chatViewController.addMedia(photoItem)
        let _ = chatViewController.view
        let lastMessage = self.chatViewController.messages.last!
        
        // trigger action
        let rightBarButton = self.chatViewController.navigationItem.rightBarButtonItem!
        rightBarButton.target!.perform(rightBarButton.action, with: rightBarButton)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage != lastMessage)
        XCTAssert(newMessage.media is JSQPhotoMediaItem)
        XCTAssert(newMessage.senderId != self.chatViewController.senderId())
        XCTAssert(newMessage.senderDisplayName != self.chatViewController.senderDisplayName())
    }
    
    /**
     * Simulate that last message is a location and test message received functionality
     */
    func testSimulatedIncomingLocation() {
        
        // add location
        let locationItem = self.chatViewController.buildLocationItem()
        self.chatViewController.addMedia(locationItem)
        let _ = chatViewController.view
        let lastMessage = self.chatViewController.messages.last!
        
        // trigger action
        let rightBarButton = self.chatViewController.navigationItem.rightBarButtonItem!
        rightBarButton.target!.perform(rightBarButton.action, with: rightBarButton)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage != lastMessage)
        XCTAssert(newMessage.media is JSQLocationMediaItem)
        XCTAssert(newMessage.senderId != self.chatViewController.senderId())
        XCTAssert(newMessage.senderDisplayName != self.chatViewController.senderDisplayName())
    }
    
    func testRemoveAvatarSetting() {
        defaults.set(true, forKey: Setting.removeAvatar.rawValue)
        let _ = chatViewController.view
        
        XCTAssertEqual(chatViewController.collectionView?.collectionViewLayout.incomingAvatarViewSize, .zero, "Incoming Avatar should be hidden")
        XCTAssertEqual(chatViewController.collectionView?.collectionViewLayout.outgoingAvatarViewSize, .zero, "Outgoing Avatar should be hidden")
    }
    
    func testSenderDisplayNameDefaultSetting() {
        defaults.set(false, forKey: Setting.removeSenderDisplayName.rawValue)
        let _ = chatViewController.view
        let button = self.chatViewController.inputToolbar.sendButtonLocation == .right ? self.chatViewController.inputToolbar.contentView!.rightBarButtonItem! : self.chatViewController.inputToolbar.contentView!.leftBarButtonItem!
        let sender = User.Cook
        self.chatViewController.didPressSend(button, withMessageText: "Testing Text", senderId: sender.rawValue, senderDisplayName: getName(sender), date: Date())
        
        let senderDisplayName = chatViewController.collectionView(self.chatViewController.collectionView!, attributedTextForMessageBubbleTopLabelAt: IndexPath(item: self.chatViewController.messages.count - 1, section: 0))
        XCTAssertNotNil(senderDisplayName, "Sender Display should not be nil")

    }
    
    func testRemoveSenderDisplayNameSetting() {
        defaults.set(true, forKey: Setting.removeSenderDisplayName.rawValue)
        let _ = chatViewController.view
        
        let button = self.chatViewController.inputToolbar.sendButtonLocation == .right ? self.chatViewController.inputToolbar.contentView!.rightBarButtonItem! : self.chatViewController.inputToolbar.contentView!.leftBarButtonItem!
        self.chatViewController.didPressSend(button, withMessageText: "Testing Text", senderId: chatViewController.senderId(), senderDisplayName: chatViewController.senderDisplayName(), date: Date())
        
        XCTAssertNil(chatViewController.collectionView(self.chatViewController.collectionView!, attributedTextForMessageBubbleTopLabelAt: IndexPath(item: self.chatViewController.messages.count - 1, section: 0)), "Sender Display should be nil")
        
    }
    
}
