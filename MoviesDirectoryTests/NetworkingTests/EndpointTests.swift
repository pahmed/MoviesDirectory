//
//  EndpointTests.swift
//  MoviesDirectoryTests
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import XCTest
@testable import MoviesDirectory

class EndpointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPath() {
        let endpoint = Endpoint.search(query: "query", page: 1)
        
        XCTAssertEqual(endpoint.pathFor(apiKey: "key"), "/search/movie?api_key=key&query=query&page=1")
    }
    
    func testMethod() {
        let endpoint = Endpoint.search(query: "query", page: 1)
        
         XCTAssertEqual(endpoint.method, HTTPMethod.get)
    }
    
    func testDecodingMovie() {
        let endpoint = Endpoint.search(query: "query", page: 1)
        
        let bundle = Bundle(for: type(of: self))
        
        let data = try! Data(contentsOf: bundle.url(forResource: "movie", withExtension: "json")!)
        
        do {
            let movie: Movie = try endpoint.decode(data: data)
            XCTAssertEqual(movie.title, "movie title")
            XCTAssertEqual(movie.posterPath, "movie posterPath")
            XCTAssertEqual(movie.overview, "movie overview")
            XCTAssertEqual(movie.releaseDate, "movie releaseDate")
            
        } catch {
            XCTFail("Failed to decode movie")
        }
    }
    
    func testDecodingMoviesResponse() {
        let endpoint = Endpoint.search(query: "query", page: 1)
        
        let bundle = Bundle(for: type(of: self))
        
        let data = try! Data(contentsOf: bundle.url(forResource: "movies-response", withExtension: "json")!)
        
        do {
            let response: MoviesResponse = try endpoint.decode(data: data)
            XCTAssertEqual(response.page, 1)
            XCTAssertEqual(response.totalPages, 9)
            XCTAssertEqual(response.totalResults, 30)
            
            let movie = response.results?.first
            
            XCTAssertEqual(movie?.title, "movie title")
            XCTAssertEqual(movie?.posterPath, "movie posterPath")
            XCTAssertEqual(movie?.overview, "movie overview")
            XCTAssertEqual(movie?.releaseDate, "movie releaseDate")
            
        } catch {
            XCTFail("Failed to decode movie")
        }
    }
    
}
