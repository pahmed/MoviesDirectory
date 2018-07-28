//
//  MoviesInteractor.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

protocol MoviesInteractorType {
    func showSearchResults(for query: String)
    func showRecentSearches()
    func showCurrentMovies()
    func loadNexPage()
}

class MoviesInteractor: MoviesInteractorType {
    
}
