//
//  Configuration.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

extension API {
    
    /// A value that holds the API configuration
    struct Configuration {
        let baseURL: URL
        let apiKey: String
        
        static let `default` = Configuration(
            baseURL: Constants.API.baseURL,
            apiKey: Constants.API.apiKey
        )
    }
}
