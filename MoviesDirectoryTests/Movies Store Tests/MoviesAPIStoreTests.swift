//
//  MoviesAPIStoreTests.swift
//  MoviesDirectoryTests
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import XCTest
@testable import MoviesDirectory

class MoviesAPIStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSaveRecent() {
        let store = MoviesAPIStore(api: API())
        
        store.saveSearchQuery("A")
        store.saveSearchQuery("B")
        store.saveSearchQuery("A")
        
        XCTAssertEqual(store.recentQueries.count, 2)
        XCTAssertEqual(store.recentQueries.first, "A")
        XCTAssertEqual(store.recentQueries.last, "B")
    }
    
}
