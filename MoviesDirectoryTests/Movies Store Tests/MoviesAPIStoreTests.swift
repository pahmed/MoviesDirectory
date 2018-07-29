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
        store.clearRecent()
        
        store.saveSearchQuery("A")
        store.saveSearchQuery("B")
        store.saveSearchQuery("A")
        
        XCTAssertEqual(store.recentQueries.count, 2)
        XCTAssertEqual(store.recentQueries.first, "A")
        XCTAssertEqual(store.recentQueries.last, "B")
    }
    
    func testSaveMoreThan10RecentItems() {
        let store = MoviesAPIStore(api: API())
        store.clearRecent()
        
        store.saveSearchQuery("1")
        store.saveSearchQuery("2")
        store.saveSearchQuery("3")
        store.saveSearchQuery("4")
        store.saveSearchQuery("5")
        store.saveSearchQuery("6")
        store.saveSearchQuery("7")
        store.saveSearchQuery("8")
        store.saveSearchQuery("9")
        store.saveSearchQuery("10")
        store.saveSearchQuery("11")
        
        XCTAssertEqual(store.recentQueries.count, 10)
        XCTAssertEqual(store.recentQueries.first, "11")
        XCTAssertEqual(store.recentQueries.last, "2")
    }
    
}
