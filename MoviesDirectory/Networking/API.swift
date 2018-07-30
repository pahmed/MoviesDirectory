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
    
    /// A generic async method that takes and API endpoint and execute a URLSession task
    ///
    /// - Parameters:
    ///   - endpoint: The end point to be called
    ///   - completion: A generic `Result` closure to be called on completion with result of either `T` or `MoviesRequestError`
    /// - Returns: The request data task.
    func requestObject<T: Decodable>(
        for endpoint: EndpointType,
        completion: @escaping (Result<T, MoviesRequestError>) -> ()) -> URLSessionTask {
        
        let path = endpoint.pathFor(apiKey: configuration.apiKey)
        let url = URL(string: configuration.baseURL.absoluteString.appending(path))!
        
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
        
        task.resume()
        
        return task
    }
}
