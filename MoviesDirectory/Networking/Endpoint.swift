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
    
    case search(apiKey: String, query: String, page: Int)
    
    var path: String {
        switch self {
        case let .search(apiKey, query, page):
            return "/search/movie?api_key=\(apiKey)&query=\(query)&page=\(page)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    func decode<T>(data: Data) throws -> T where T : Decodable {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
