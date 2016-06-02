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

        let button = self.chatViewController.inputToolbar.sendButtonOnRight ? self.chatViewController.inputToolbar.contentView.rightBarButtonItem : self.chatViewController.inputToolbar.contentView.leftBarButtonItem
        let text = "Testing text"
        let senderId = self.chatViewController.senderId
        let senderDisplayName = self.chatViewController.senderDisplayName
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
        let senderId = self.chatViewController.senderId
        let senderDisplayName = self.chatViewController.senderDisplayName
        
        let photoItem = JSQPhotoMediaItem(image: UIImage(named: "goldengate"))
        self.chatViewController.addMedia(photoItem)
        
        let newMessage = self.chatViewController.messages.last!
        
        XCTAssert(newMessage.senderId == senderId)
        XCTAssert(newMessage.senderDisplayName == senderDisplayName)
        XCTAssert(newMessage.media is JSQPhotoMediaItem)
        
    }
}