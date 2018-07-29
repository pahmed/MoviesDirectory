//
//  Movies.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

/// Models for Movies Directory scence
struct Movies {
    
    /// This is a container value for all the scene view models
    struct ViewModel {
        
        /// Represents the view model to a table view section
        struct Section {
            
            /// Title for tableview section
            let title: String?
            
            /// The items to be displayed in the table view
            let items: [Item]
        }
        
        /// enum type represents the view model for either movie item OR recent item
        ///
        /// - movie: An enum case for `movie` item, with the `Movie` value as associated value
        /// - recent: An enum case for `recent` item, with the `Recent` value as associated value
        enum Item {
            case movie(Movie)
            case recent(Recent)
        }
        
        /// A view model for movie item
        struct Movie: MovieViewModelType {
            let moviePoster: URL?
            let movieName: String
            let releaseDate: String
            let movieOverview: String
        }
        
        /// A view model for the `Recent` item
        struct Recent {
            let query: String
        }
        
        /// A view model for an alert
        struct Alert {
            let title: String
            let message: String
        }
    }
}
