//
//  TestAlert.swift
//  MoviesDirectoryTests
//
//  Created by Ahmed Ibrahim on 7/30/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import XCTest
@testable import MoviesDirectory

class TestAlert: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        let alert = Alert(title: "t", message: "m")
        
        XCTAssertEqual(alert.alert.title, "t")
        XCTAssertEqual(alert.alert.message, "m")
    }
    
    func testAddAction() {
        let alert = Alert()
        
        let action = UIAlertAction(title: "a", style: .cancel, handler: nil)
        _ = alert.add(action: action)
        
        XCTAssertEqual(alert.alert.actions.count, 1)
        XCTAssertEqual(alert.alert.actions.first?.title, "a")
        XCTAssertEqual(alert.alert.actions.first?.style, .cancel)
    }
    
    func testAddCancelAction() {
        let alert = Alert()
        
        _ = alert.addCancelAction()
        
        XCTAssertEqual(alert.alert.actions.count, 1)
        XCTAssertEqual(alert.alert.actions.first?.title, "Cancel")
        XCTAssertEqual(alert.alert.actions.first?.style, .cancel)
    }
    
    func testAddCancelActionWithCustomTitle() {
        let alert = Alert()
        
        _ = alert.addCancelAction(title: "Ok")
        
        XCTAssertEqual(alert.alert.actions.count, 1)
        XCTAssertEqual(alert.alert.actions.first?.title, "Ok")
        XCTAssertEqual(alert.alert.actions.first?.style, .cancel)
    }
    
}
