//
//  SettingsTests.swift
//  SwiftExample
//
//  Created by P D Leonard on 7/23/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import XCTest
@testable import SwiftExample

class SettingsTests: XCTestCase {
    
    let settingsView = SettingsTableViewController()
    
    override func setUp() {
        super.setUp()
    }
    
    func testSettingsView() {
        let _ = settingsView.view
        XCTAssertEqual(settingsView.tableView.numberOfRowsInSection(0), 3)
    }
}
