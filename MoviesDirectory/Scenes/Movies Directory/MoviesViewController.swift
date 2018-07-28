//
//  MoviesViewController.swift
//  MoviesDirectory
//
//  Created by Ahmed Ibrahim on 7/28/18.
//  Copyright © 2018 Ahmed Ibrahim. All rights reserved.
//

import UIKit

protocol MoviesDisplayerType {
    func display(sections: [Movies.ViewModel.Section], showLoadingIndicator: Bool)
    func display(alert viewModel: Movies.ViewModel.Alert)
}

class MoviesViewController: UIViewController, MoviesDisplayerType {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var seachBar: UISearchBar!
    
    private var sections: [Movies.ViewModel.Section] = []
    
    lazy var interactor: MoviesInteractorType = {
        return SearchInteractor(viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingIndicator(visibile: false)
    }
    
    // MARK: - Display Logic
    
    func display(sections: [Movies.ViewModel.Section], showLoadingIndicator: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.sections = sections
            self?.tableView?.reloadData()
            self?.setLoadingIndicator(visibile: showLoadingIndicator)
        }
    }
    
    func display(alert viewModel: Movies.ViewModel.Alert) {
        Alert(title: viewModel.title, message: viewModel.message)
            .addCancelAction(title: NSLocalizedString("Ok", comment: ""))
            .show(in: self)
    }
    
    private func setLoadingIndicator(visibile: Bool) {
        if visibile {
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 66)
            activityIndicator.startAnimating()
            tableView.tableFooterView = activityIndicator
        } else {
            tableView.tableFooterView = UIView()
        }
    }
}

// MARK: - UISearchBarDelegate

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        interactor.showRecentSearches()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        interactor.showSearchResults(for: searchBar.text ?? "")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        interactor.showCurrentMovies()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .movie(let movieItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
            cell.configure(with: movieItem)
            return cell
            
        case .recent(let recentItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: "recentCell", for: indexPath)
            cell.textLabel?.text = recentItem.movieName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastItem = (indexPath.row == self.tableView(tableView, numberOfRowsInSection: 0) - 1)
        
        if isLastItem && seachBar.isFirstResponder == false {
            interactor.loadNexPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        
        switch item {
        case .recent(let recentItem):
            seachBar.text = recentItem.movieName
            interactor.showSearchResults(for: recentItem.movieName)
            seachBar.resignFirstResponder()
            
        case .movie:
            ()
        }
    }
}