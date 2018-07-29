//
//  MovieTableViewCell.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieViewModelType {
    var moviePoster: URL? { get }
    var movieName: String { get }
    var releaseDate: String { get }
    var movieOverview: String { get }
}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configure(with viewModel: MovieViewModelType) {
        movieNameLabel.text = viewModel.movieName
        overviewLabel.text = viewModel.movieOverview
        dateLabel.text = viewModel.releaseDate
        
        let imageResource = viewModel.moviePoster.map({ ImageResource(downloadURL: $0) })
        posterImageView.kf.setImage(with: imageResource)
    }
    
}
