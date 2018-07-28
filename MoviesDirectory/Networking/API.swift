//
//  API.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// This class represents the network access layer.
/// Any HTTP request should happen through an object of this class
class API {
    
    /// A configuration value for the API
    private let configuration: API.Configuration
    
    /// The intializer takes a configuration value,
    /// it uses the `Configuration.default` as a default parameter
    ///
    /// - Parameter configuration: configuration value
    init(configuration: API.Configuration = API.Configuration.default) {
        self.configuration = configuration
    }
    
    /// A search movies API that returns a movies result page given a search query
    ///
    /// - Parameters:
    ///   - query: A substring of the movie name
    ///   - page: A 1 based index for the
    ///   - completion: A `Result` closure to be called on completion with result of either `MoviesResponse` or `MoviesRequestError`
    /// - Returns: The request data task.
    func movies(for query: String, page: Int, completion: @escaping (Result<MoviesResponse, MoviesRequestError>) -> ()) -> URLSessionTask {
        let endpoint = Endpoint.search(apiKey: configuration.apiKey, query: query, page: page)
        
        let task = requestObject(for: endpoint) { (result: Result<MoviesResponse, MoviesRequestError>) in
            switch result {
            case .success(let response):
                if (response.results?.isEmpty ?? true) {
                    completion(.failure(.noResults))
                } else {
                    completion(.success(response))
                }
                
            case .failure:
                completion(.failure(.mapping))
            }
        }
        
        task.resume()
        
        return task
    }
    
    /// A generic async method that takes and API endpoint and execute a URLSession task
    ///
    /// - Parameters:
    ///   - endpoint: The end point to be called
    ///   - completion: A generic `Result` closure to be called on completion with result of either `T` or `MoviesRequestError`
    /// - Returns: The request data task.
    func requestObject<T: Decodable>(
        for endpoint: EndpointType,
        completion: @escaping (Result<T, MoviesRequestError>) -> ()) -> URLSessionTask {
        
        let url = URL(string: configuration.baseURL.absoluteString.appending(endpoint.path))!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do {
                let result: T = try endpoint.decode(data: data)
                
                completion(.success(result))
            } catch {
                completion(.failure(.mapping))
            }
        }
        
        return task
    }
}
