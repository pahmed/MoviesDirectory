//
//  MoviesAPIStore.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A concrete implementation for `MovieStoreType`, this gets the data through API
class MoviesAPIStore: MovieStoreType {
    
    /// The api object used to make network request
    private let api: API
    
    /// The recent successful queries
    private(set) var recentQueries: [String] = []
    
    init(api: API = API()) {
        self.api = api
    }
    
    func movies(
        for query: String,
        page: Int,
        completion: @escaping (Result<MoviesResponse, MoviesRequestError>) -> ()) -> DataRequestTask {
        
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
    }
}

extension URLSessionTask: DataRequestTask {}
