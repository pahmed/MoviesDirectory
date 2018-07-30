//
//  Endpoint.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A concrete implementation for protocol `EndpointType`.
/// Any new endpoint should be defines here
enum Endpoint: EndpointType {
    
    case search(query: String, page: Int)
        
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    func pathFor(apiKey: String) -> String {
        switch self {
        case let .search(query, page):
            return "/search/movie?api_key=\(apiKey)&query=\(query)&page=\(page)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
    }
    
    func decode<T>(data: Data) throws -> T where T : Decodable {
        switch self {
        default:
            return try JSONDecoder().decode(T.self, from: data)
        }
    }
    
}
