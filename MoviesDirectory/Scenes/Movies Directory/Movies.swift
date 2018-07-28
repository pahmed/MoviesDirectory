//
//  Movies.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import Foundation

struct Movies {
    struct ViewModel {
        struct Section {
            let title: String?
            let items: [Item]
        }
        
        enum Item {
            case movie(Movie)
            case recent(Recent)
        }
        
        struct Movie: MovieViewModelType {
            let moviePoster: URL?
            let movieName: String
            let releaseDate: String
            let movieOverview: String
        }
        
        struct Recent {
            let movieName: String
        }
        
        struct Alert {
            let title: String
            let message: String
        }
    }
}
