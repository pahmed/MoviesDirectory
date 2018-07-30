//
//  EndpointType.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A protocol that defines the requirements for creating an endpoint
protocol EndpointType {
    
    /// The endpoint http method
    var method: HTTPMethod { get }
    
    /// The endopint path
    func pathFor(apiKey: String) -> String
    
    /// A generic mthod to decode raw Data response to an object with type T.
    ///
    /// - Parameter data: The API response data
    /// - Returns: A Decodable object to type T
    /// - Throws: An error if failed to map data to generic type T
    func decode<T>(data: Data) throws -> T where T : Decodable
}
