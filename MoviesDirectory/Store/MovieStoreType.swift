//
//  MovieStoreType.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// This type respresents the required operarions in any Movie Store
protocol MovieStoreType {
    
    /// An asyncrounus function that returns a list of movies or an error,  given a search query
    ///
    /// - Parameters:
    ///   - query: A substring of the movie name you are searching for
    ///   - page: The requested page number, this is helpful when you want to implement pagination
    ///   - completion: A `Result` closure to be called on completion with result of either `MoviesResponse` or `MoviesRequestError`
    /// - Returns: A task refrence to the running operaiton, this is helpful if you want to cancel a running operation
    func movies(for query: String, page: Int, completion: @escaping (Result<MoviesResponse, MoviesRequestError>) -> ()) -> DataRequestTask?
    
    /// Save a search query to the store
    ///
    /// - Parameter query: A string represents the query you want to save
    func saveSearchQuery(_ query: String)
    
    /// A property returns the recently saved queries
    var recentQueries: [String] { get }
}
