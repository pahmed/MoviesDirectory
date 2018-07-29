//
//  MoviesPresenterTests.swift
//  MoviesDirectoryTests
//
//  Created by Ahmed Ibrahim on 7/29/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import XCTest
@testable import MoviesDirectory

class MoviesPresenterTests: XCTestCase {
    
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
        movie = nil
        
        super.tearDown()
    }
    
    func testPresentMovies() {
        class MoviesDisplayerMock: MoviesDisplayerType {
            
            var sections: [Movies.ViewModel.Section] = []
            var showLoadingIndicator = false
            func display(sections: [Movies.ViewModel.Section], showLoadingIndicator: Bool) {
                self.sections = sections
                self.showLoadingIndicator = showLoadingIndicator
            }
            
            func display(alert viewModel: Movies.ViewModel.Alert) {
            }
            
            func displayLoadingIndicator(visibile: Bool) {
            }
        }
        
        let displayer = MoviesDisplayerMock()
        
        let presenter = MoviesPresenter(viewController: displayer)
        
        presenter.present(movies: [self.movie], isLoading: true)
        
        let sections = displayer.sections
        
        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections.first?.title, nil)
        XCTAssertEqual(sections.first?.items.count, 1)
        
        guard let displayedMovie = sections.first?.items.first else {
            XCTFail("expected movie not found")
            return
        }
        
        switch displayedMovie {
        case .movie(let item):
            XCTAssertEqual(item.movieName, "title")
            XCTAssertEqual(item.movieOverview, "overview")
            XCTAssertEqual(item.releaseDate, "12-1-2001")
            XCTAssertEqual(
                item.moviePoster,
                URL(string: Constants.API.imageBaseURL.absoluteString + "/image")!
            )
            
        default:
            XCTFail("expected movie not found")
        }
    }
    
    func testPresentRecentSearches() {
        class MoviesDisplayerMock: MoviesDisplayerType {
            
            var sections: [Movies.ViewModel.Section] = []
            var showLoadingIndicator = false
            func display(sections: [Movies.ViewModel.Section], showLoadingIndicator: Bool) {
                self.sections = sections
                self.showLoadingIndicator = showLoadingIndicator
            }
            
            func display(alert viewModel: Movies.ViewModel.Alert) {
            }
            
            func displayLoadingIndicator(visibile: Bool) {
            }
        }
        
        let displayer = MoviesDisplayerMock()
        
        let presenter = MoviesPresenter(viewController: displayer)
        
        presenter.present(recentSearches: ["a"])
        
        let sections = displayer.sections
        
        XCTAssertEqual(sections.count, 1)
        XCTAssertEqual(sections.first?.title, "Recent Searches")
        XCTAssertEqual(sections.first?.items.count, 1)
        
        guard let displayedRecents = sections.first?.items.first else {
            XCTFail("expected movie not found")
            return
        }
        
        switch displayedRecents {
        case .recent(let item):
            XCTAssertEqual(item.query, "a")
            
        default:
            XCTFail("expected movie not found")
        }
    }
    
    func testPresentError() {
        class MoviesDisplayerMock: MoviesDisplayerType {
            
            var viewModel: Movies.ViewModel.Alert?
            
            func display(sections: [Movies.ViewModel.Section], showLoadingIndicator: Bool) {
            }
            
            func display(alert viewModel: Movies.ViewModel.Alert) {
                self.viewModel = viewModel
            }
            
            func displayLoadingIndicator(visibile: Bool) {
            }
        }
        
        let displayer = MoviesDisplayerMock()
        
        let presenter = MoviesPresenter(viewController: displayer)
        
        presenter.present(error: .noResults)
        
        XCTAssertEqual(displayer.viewModel?.title, "No Results!")
        XCTAssertEqual(displayer.viewModel?.message, "No results found, try to search using different movie name")        
    }
    
    func testMovieViewModel() {
        let presenter = MoviesPresenter(
            viewController: MoviesViewController(
                nibName: nil, bundle: nil)
        )
        
        let movie = Movie(
            title: "title",
            posterPath: "/image",
            overview: "overview",
            releaseDate: "12-1-2001"
        )
        let viewModel = presenter.viewModel(for: movie)
        
        XCTAssertEqual(viewModel.movieName, "title")
        XCTAssertEqual(viewModel.movieOverview, "overview")
        XCTAssertEqual(
            viewModel.moviePoster,
            URL(string: Constants.API.imageBaseURL.absoluteString + "/image")!
        )
        XCTAssertEqual(viewModel.releaseDate, "12-1-2001")
    }
    
    func testErrorViewModel() {
        let presenter = MoviesPresenter(
            viewController: MoviesViewController(
                nibName: nil, bundle: nil)
        )
        
        let noResultsAlert = presenter.viewModel(for: MoviesRequestError.noResults)
        
        XCTAssertEqual(noResultsAlert.title, "No Results!")
        XCTAssertEqual(noResultsAlert.message, "No results found, try to search using different movie name")
        
        let mappingAlert = presenter.viewModel(for: MoviesRequestError.mapping)
        
        XCTAssertEqual(mappingAlert.title, "Oops!")
        XCTAssertEqual(mappingAlert.message, "Something went wrong, please try again")
    }
    
}
