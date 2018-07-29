//
//  MoviesInteractorTests.swift
//  MoviesDirectoryTests
//
//  Created by Ahmed Ibrahim on 7/29/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import XCTest
@testable import MoviesDirectory

class PresenterMock: MoviesPresenterType {
    
    var movies: [Movie] = []
    var recentSearches: [String] = []
    var error: MoviesRequestError?
    var isLoading = false
    
    func present(movies: [Movie], isLoading: Bool) {
        self.movies = movies
        self.isLoading = isLoading
    }
    
    func present(recentSearches: [String]) {
        self.recentSearches = recentSearches
    }
    
    func present(error: MoviesRequestError) {
        self.error = error
    }
    
    func present(isLoading: Bool) {
        self.isLoading = isLoading
    }
}

class StoreMock: MovieStoreType {
    func movies(for query: String, page: Int, completion: @escaping (Result<MoviesResponse, MoviesRequestError>) -> ()) -> DataRequestTask? {
        return URLSessionDataTask()
    }
    
    func saveSearchQuery(_ query: String) {
        
    }
    
    var recentQueries: [String]  = []
}

class MoviesInteractorTests: XCTestCase {
    
    var movie: Movie!
    
    override func setUp() {
        super.setUp()
        
        movie = Movie(
            title: "title",
            posterPath: "/image",
            overview: "overview",
            releaseDate: "12-1-2001"
        )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSettingIsLoading() {
        let presenter = PresenterMock()
        let interactor = MoviesInteractor(
            presenter: presenter,
            store: StoreMock()
        )
        
        interactor.accumlatedResponse = MoviesResponse(
            page: 1,
            totalPages: 3,
            totalResults: 30,
            results: [movie]
        )
        
        interactor.isLoading = true
        
        XCTAssertEqual(presenter.movies.count, 1)
        XCTAssertEqual(presenter.isLoading, true)
    }
    
    func testLoadRecentSearches() {
        class StoreMock: MovieStoreType {
            func movies(for query: String, page: Int, completion: @escaping (Result<MoviesResponse, MoviesRequestError>) -> ()) -> DataRequestTask? {
                return URLSessionDataTask()
            }
            
            func saveSearchQuery(_ query: String) {
                
            }
            
            var recentQueries: [String] {
                return ["a", "b"]
            }
        }
        
        let store = StoreMock()
        let presenter = PresenterMock()
        let interactor = MoviesInteractor(
            presenter: presenter,
            store: store
        )
        
        interactor.loadRecentSearches()
        
        XCTAssertEqual(presenter.recentSearches.first, "a")
        XCTAssertEqual(presenter.recentSearches.last, "b")
    }
    
    func testReset() {
        let interactor = MoviesInteractor(
            presenter: PresenterMock(),
            store: StoreMock()
        )
        
        interactor.accumlatedResponse = MoviesResponse(
            page: 0, totalPages: 0, totalResults: 0, results: nil
        )
        
        XCTAssertNotNil(interactor.accumlatedResponse)
        
        interactor.reset()
        
        XCTAssertNil(interactor.accumlatedResponse)
    }
    
    func testIsLastPage() {
        let response1 = MoviesResponse(
            page: 1,
            totalPages: 2,
            totalResults: 90,
            results: nil
        )
        
        XCTAssertEqual(response1.isLastPage, false)
        
        let response2 = MoviesResponse(
            page: 2,
            totalPages: 2,
            totalResults: 90,
            results: nil
        )
        
        XCTAssertEqual(response2.isLastPage, true)
    }
    
    func testLoadCurrentMovies() {
        let presenter = PresenterMock()
        let interactor = MoviesInteractor(
            presenter: presenter,
            store: StoreMock()
        )
        
        interactor.accumlatedResponse = MoviesResponse(
            page: 1,
            totalPages: 3,
            totalResults: 30,
            results: [movie]
        )
        
        interactor.loadCurrentMovies()
        
        XCTAssertEqual(presenter.movies.first?.title, "title")
        XCTAssertEqual(presenter.movies.first?.overview, "overview")
        XCTAssertEqual(presenter.movies.first?.releaseDate, "12-1-2001")
        XCTAssertEqual(
            presenter.movies.first?.posterURL,
            URL(string: Constants.API.imageBaseURL.absoluteString + "/image")!
        )
    }
    
    func testAccumlateResponse() {
        let interactor = MoviesInteractor(
            presenter: PresenterMock(),
            store: StoreMock()
        )
        
        let movie1 = Movie(
            title: "t1",
            posterPath: "/p1",
            overview: "o1",
            releaseDate: "d1"
        )
        
        let movie2 = Movie(
            title: "t2",
            posterPath: "/p2",
            overview: "o2",
            releaseDate: "d2"
        )
        
        let response1 = MoviesResponse(
            page: 1,
            totalPages: 3,
            totalResults: 30,
            results: [movie1])
        
        XCTAssertEqual(response1.page, 1)
        
        let response2 = MoviesResponse(
            page: 2,
            totalPages: 3,
            totalResults: 30,
            results: [movie2])
        
        let result = interactor.accumlate(response: response2, to: response1)
        
        XCTAssertEqual(result.page, 2)
        XCTAssertEqual(result.results?.count, 2)
    }
}
