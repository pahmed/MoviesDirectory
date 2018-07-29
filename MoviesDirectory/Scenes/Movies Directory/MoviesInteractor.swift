//
//  MoviesInteractor.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A protocol the defines the business logic abilities for an interactor
/// An interactor is responsible for handling screen business logic
protocol MoviesInteractorType {
    
    /// Load search results for a given query
    ///
    /// - Parameter query: A search string, this could be a substring of the movie name
    func loadSearchResults(for query: String)
    
    /// Loads recent searches for user
    func loadRecentSearches()
    
    /// Loads the last search resuls
    func loadCurrentMovies()
    
    /// Loads another page of results
    func loadNexPage()
}

class MoviesInteractor: MoviesInteractorType {
    
    // MARK: - Instance vars
    
    let presenter: MoviesPresenterType
    let store: MovieStoreType
    var runningTask: DataRequestTask?
    var accumlatedResponse: MoviesResponse? {
        didSet {
            loadCurrentMovies()
        }
    }
    var isLoading = false {
        didSet {
            loadCurrentMovies()
        }
    }
    var query: String?
    
    // MARK: - Initializers
    
    init(presenter: MoviesPresenterType, store: MovieStoreType = MoviesAPIStore()) {
        self.presenter = presenter
        self.store = store
    }
    
    // MARK: - MoviesInteractorType
    
    func loadSearchResults(for query: String) {
        self.query = query
        reset()
        loadNexPage()
    }
    
    func loadRecentSearches() {
        presenter.present(recentSearches: store.recentQueries)
    }
    
    func loadCurrentMovies() {
        presenter.present(movies: accumlatedResponse?.results ?? [], isLoading: isLoading)
    }
    
    func loadNexPage() {
        guard
            isLoading == false &&
                (accumlatedResponse == nil || accumlatedResponse?.isLastPage == false) else { return }
        
        runningTask?.cancel()
        
        let currentPage = accumlatedResponse?.page ?? 0
        let query = self.query!
        isLoading = true
        
        runningTask = store.movies(for: query, page: currentPage + 1) { [weak self] (result) in
            self?.isLoading = false
            
            switch result {
            case let .success(response):
                self?.accumlatedResponse = self?.accumlate(
                    response: response,
                    to: self?.accumlatedResponse
                )
                
                self?.store.saveSearchQuery(query)
                
            case let .failure(error):
                self?.presenter.present(error: error)
            }
        }
    }
    
    // MARK: - Helpers
    
    func reset() {
        accumlatedResponse = nil
    }
    
    func accumlate(response: MoviesResponse, to baseResponse: MoviesResponse?) -> MoviesResponse {
        let movies = (baseResponse?.results ?? []) + (response.results ?? [])
        
        return MoviesResponse(
            page: response.page,
            totalPages: response.totalPages,
            totalResults: response.totalResults,
            results: movies
        )
    }
}

extension MoviesResponse {
    var isLastPage: Bool {
        return page == totalPages
    }
}
