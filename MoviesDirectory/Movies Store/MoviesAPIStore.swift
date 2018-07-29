//
//  MoviesAPIStore.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation
import Reachability

/// A concrete implementation for `MovieStoreType`, this gets the data through API
class MoviesAPIStore: MovieStoreType {
    
    /// The api object used to make network request
    private let api: API
    
    /// The recent successful queries
    private(set) var recentQueries: [String] = []
    
    /// A network reacability variable for checking if there is internet connection
    private lazy var reachability = Reachability()
    
    init(api: API = API()) {
        self.api = api
        
        loadRecentQueries()
    }
    
    func movies(
        for query: String,
        page: Int,
        completion: @escaping (Result<MoviesResponse, MoviesRequestError>) -> ()) -> DataRequestTask? {
        
        guard reachability?.connection != .some(.none) else {
            completion(.failure(.noInternetConnection))
            return nil
        }
        
        return api.movies(for: query, page: page, completion: { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    /// Saves a search query to the recent searchs
    ///
    /// - Parameter query: Search query
    func saveSearchQuery(_ query: String) {
        if let indexForExistingQuery = recentQueries.index(where: {$0 == query }) {
            recentQueries.remove(at: indexForExistingQuery)
        }
        
        recentQueries.insert(query, at: 0)
        
        if recentQueries.count > Constants.Preferences.maximumNumerOfRecentMovies {
            recentQueries.removeLast()
        }
        
        persistRecentQueries()
    }
    
    /// Load the saved queries
    func loadRecentQueries() {
        self.recentQueries = UserDefaults.standard.array(forKey: Constants.UserDefaultsKeys.recentQueries) as? [String] ?? []
    }
    
    /// Persist the recent queries
    func persistRecentQueries() {
        UserDefaults.standard.set(recentQueries, forKey: Constants.UserDefaultsKeys.recentQueries)
        UserDefaults.standard.synchronize()
    }
    
    /// Clear the recent searches from memory and persistent store
    func clearRecent() {
        recentQueries = []
        UserDefaults.standard.set([], forKey: Constants.UserDefaultsKeys.recentQueries)
        UserDefaults.standard.synchronize()
    }
}

extension URLSessionTask: DataRequestTask {}
