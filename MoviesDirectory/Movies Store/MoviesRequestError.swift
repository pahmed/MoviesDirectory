//
//  MoviesRequestError.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// An enum that represents the list of errors that might happen
/// on performing a request to the Movie Store
///
/// - unknown: An enum case represents that case where the error is unknown
/// - mapping: An enum case represents that case where the error is happens while parsing the raw data in the store
/// - noResults: An enum case represents that case where the request got nothing form the store
enum MoviesRequestError: Error {
    case unknown
    case mapping
    case noResults
    case noInternetConnection
}
