//
//  Constants.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A value that defines app constants
struct Constants {
    struct API {
        /// A private initializer to make sure that no instance will be created
        /// from this struct, since its use is just for holding constants
        private init() {}
        
        #if DEBUG
        static let baseURL = URL(string: "http://api.themoviedb.org/3")!
        static let imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w92")!
        static let apiKey = "474f68a7f2c60f95baf92b7337632b58"
        #else
        static let baseURL = URL(string: "http://api.themoviedb.org/3")!
        static let imageBaseURL = URL(string: "http://image.tmdb.org/t/p/w92")!
        static let apiKey = "474f68a7f2c60f95baf92b7337632b58"
        #endif
    }
    
    struct Preferences {
        static let maximumNumerOfRecentMovies = 10
    }
    
    struct UserDefaultsKeys {
        static let recentQueries = "recentQueries"
    }
}
