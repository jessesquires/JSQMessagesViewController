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
    
    var chatViewController: ChatViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        self.chatViewController = storyboard.instantiateViewControllerWithIdentifier("ChatViewController") as! ChatViewController
        
        //load the view
        XCTAssertNotNil(self.chatViewController.view)
    }
    
    func testSendButtonAction() {

        let button = self.chatViewController.inputToolbar.sendButtonOnRight ? self.chatViewController.inputToolbar.contentView!.rightBarButtonItem! : self.chatViewController.inputToolbar.contentView!.leftBarButtonItem!
        let text = "Testing text"
        let senderId = self.chatViewController.senderId()
        let senderDisplayName = self.chatViewController.senderDisplayName()
        let date = NSDate()
        
        let originalCount = self.chatViewController.messages.count
        
        self.chatViewController.didPressSendButton(button, withMessageText: text, senderId: senderId, senderDisplayName: senderDisplayName, date: date)
        
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
    
    /**
     * Test when the messages array is empty, it should add a new incoming text message
     * Test when the messages array last message is a text message, it should add a new incoming text message
     */
    func testSimulatedIncomingTextMessage() {
        self.chatViewController.messages = []
        self.chatViewController.collectionView!.reloadData()
        
        // trigger action
        let rightBarButton = self.chatViewController.navigationItem.rightBarButtonItem!
        rightBarButton.target!.performSelector(rightBarButton.action, withObject: rightBarButton)
        
        let lastMessage = self.chatViewController.messages.last!
        
        XCTAssert(!lastMessage.isMediaMessage)
        XCTAssert(lastMessage.senderId != self.chatViewController.senderId())
        XCTAssert(lastMessage.senderDisplayName != self.chatViewController.senderDisplayName())
        
        // triger action
        rightBarButton.target!.performSelector(rightBarButton.action, withObject: rightBarButton)
        
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
        
        let lastMessage = self.chatViewController.messages.last!
        
        // trigger action
        let rightBarButton = self.chatViewController.navigationItem.rightBarButtonItem!
        rightBarButton.target!.performSelector(rightBarButton.action, withObject: rightBarButton)
        
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
        
        let lastMessage = self.chatViewController.messages.last!
        
        // trigger action
        let rightBarButton = self.chatViewController.navigationItem.rightBarButtonItem!
        rightBarButton.target!.performSelector(rightBarButton.action, withObject: rightBarButton)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage != lastMessage)
        XCTAssert(newMessage.media is JSQLocationMediaItem)
        XCTAssert(newMessage.senderId != self.chatViewController.senderId())
        XCTAssert(newMessage.senderDisplayName != self.chatViewController.senderDisplayName())
    }
}