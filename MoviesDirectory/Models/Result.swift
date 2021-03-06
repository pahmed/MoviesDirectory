//
//  Result.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// An enum value to hold the result for an
/// operarion that resturns either success or failure.
///
/// - success: An enum case that holds the value that is returned with successful operation
/// - failure: An enum case that holds the value that is returned with failed operation
enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
