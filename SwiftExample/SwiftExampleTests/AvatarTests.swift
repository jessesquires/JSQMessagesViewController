//
//  AvatarTests.swift
//  SwiftExample
//
//  Created by P D Leonard on 6/7/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import XCTest
@testable import SwiftExample

class AvatarTests: XCTestCase {
    
    let chatView = ChatViewController()
    let settingsTable = SettingsTableViewController()
    
    override func setUp() {
        super.setUp()
        //Ensures that viewDidLoad is called before testing.
        let _ = chatView.view
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAvatarsArePreasent() {

        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "removeAvatars")
        chatView.configureAvatars()
        XCTAssertNotEqual(chatView.collectionView?.collectionViewLayout.incomingAvatarViewSize, .zero, "The avatars should not be set to zero")
        
    }
    func testAvatarsAreRemoved() {
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "removeAvatars")
        chatView.configureAvatars()
        XCTAssertEqual(chatView.collectionView?.collectionViewLayout.incomingAvatarViewSize, .zero, "The avatars should not be set to zero")
    }
    
}
