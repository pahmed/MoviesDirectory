//
//  Movie.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A value that holds the movie details
struct Movie {
    
    /// The title for the movie
    let title: String
    
    /// An optional path to the movie poster, this is NOT the complete url
    let posterPath: String?
    
    /// An overview about the movie
    let overview: String
    
    /// The relsae date for the movie
    let releaseDate: String
}
