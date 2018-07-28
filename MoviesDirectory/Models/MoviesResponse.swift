//
//  MoviesResponse.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A value the holds the details if Movie search response
struct MoviesResponse: Codable {
    
    /// The index of the current page
    let page: Int
    
    /// The total number of pages
    let totalPages: Int
    
    /// The total number of movies for the given query
    let totalResults: Int
    
    /// A list of the movies found for the given query
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
