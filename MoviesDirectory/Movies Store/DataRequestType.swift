//
//  DataRequestType.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A task for the running data request.
/// Use this for handling running request
protocol DataRequestTask {
    /// Cancel the running task
    func cancel()
}
