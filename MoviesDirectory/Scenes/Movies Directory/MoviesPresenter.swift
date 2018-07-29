//
//  MoviesPresenter.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// A protocol the defines the presentation logic abilities for a presenter
/// A presenter is responsible for receiving raw model objects from an interactor,
/// generate view models, then pass it to the displayer to be displayed
protocol MoviesPresenterType {
    
    /// Generate view models for a given list of movies and send it to `displayer`
    ///
    /// - Parameters:
    ///   - movies: The list of movies to be presented
    ///   - isLoading: A flag that indicate weather another movies list is being loaded
    func present(movies: [Movie], isLoading: Bool)
    
    /// Generate view models for a given list of recent items and send it to `displayer`
    ///
    /// - Parameter recentSearches: A list of the recent search queries
    func present(recentSearches: [String])
    
    /// Generate view models for a given error and send it to `displayer`
    ///
    /// - Parameter error: An error value
    func present(error: MoviesRequestError)
    
    func present(isLoading: Bool)
}

class MoviesPresenter: MoviesPresenterType {
    let viewController: MoviesDisplayerType
    
    init(viewController: MoviesDisplayerType) {
        self.viewController = viewController
    }
    
    // MARK: - Presentation Logic
    
    func present(movies: [Movie], isLoading: Bool) {
        let viewModels = movies
            .map({ [unowned self] movie in self.viewModel(for: movie) })
            .map({ Movies.ViewModel.Item.movie($0) })
        
        let section = Movies.ViewModel.Section(
            title: nil,
            items: viewModels
        )
        
        viewController.display(sections: [section], showLoadingIndicator: isLoading)
    }
    
    func present(recentSearches: [String]) {
        let viewModels = recentSearches
            .map({ Movies.ViewModel.Recent(query: $0) })
            .map({ Movies.ViewModel.Item.recent($0) })
        
        let section = Movies.ViewModel.Section(
            title: NSLocalizedString("Recent Searches", comment: ""),
            items: viewModels
        )
        
        viewController.display(sections: [section], showLoadingIndicator: false)
    }
    
    func present(error: MoviesRequestError) {
        let viewModel = self.viewModel(for: error)
        viewController.display(alert: viewModel)
    }
    
    func present(isLoading: Bool) {
        viewController.displayLoadingIndicator(visibile: isLoading)
    }
    
    // MARK: - Helpers
    
    func viewModel(for error: MoviesRequestError) -> Movies.ViewModel.Alert {
        let title: String
        let message: String
        
        switch error {
        case .noResults:
            title = NSLocalizedString("No Results!", comment: "")
            message = NSLocalizedString("No results found, try to search using different movie name", comment: "")
            
        case .noInternetConnection:
            title = NSLocalizedString("No Internet Connection!", comment: "")
            message = NSLocalizedString("Please make sure you are connected to the internet and try again later", comment: "")
            
        default:
            title = NSLocalizedString("Oops!", comment: "")
            message = NSLocalizedString("Something went wrong, please try again", comment: "")
        }
        
        let viewModel = Movies.ViewModel.Alert(title: title, message: message)
        
        return viewModel
    }
    
    func viewModel(for movie: Movie) -> Movies.ViewModel.Movie {
        return Movies.ViewModel.Movie(
            moviePoster: movie.posterURL,
            movieName: movie.title,
            releaseDate: movie.releaseDate,
            movieOverview: movie.overview
        )
    }
}

extension Movie {
    var posterURL: URL? {
        return posterPath
            .map({ Constants.API.imageBaseURL.absoluteString + $0 })
            .flatMap({ URL(string: $0.trimmingCharacters(in: .whitespacesAndNewlines)) })
    }
}
