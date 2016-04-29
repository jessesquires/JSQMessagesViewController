//
//  MacmeSwiftChatTests.swift
//  MacmeSwiftChatTests
//
//  Created by Dan Leonard on 2/28/16.
//  Copyright © 2016 MacMeDan. All rights reserved.
//

import XCTest
@testable import MacmeSwiftChat

class MacmeSwiftChatTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let image = UIImage(imageLiteral: "NiceSelfi")
        XCTAssertNotNil(image, "This should not be nil")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
