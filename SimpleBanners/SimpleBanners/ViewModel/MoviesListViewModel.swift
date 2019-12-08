//
//  MoviesListViewModel.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 07/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

protocol MoviesListViewModelDelegate: class {
    func didFetch()
    func didFailFetch(with reason: String)
}

final class MoviesListViewModel {
    
    // MARK: Properties
    
    private weak var delegate: MoviesListViewModelDelegate?
    private var movies: [Movie] = []
    private var isFetching = false
    private var total = 0
    
    private let client = MoviesAPIClient()
    
    public var totalCount: Int {
        return total
    }
    
    public var currentCount: Int {
        return movies.count
    }
    
    // MARK: Initializer
    
    init(delegate: MoviesListViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK: Class Functions
    
    public func movie(at index: Int) -> Movie {
        return movies[index]
    }
    
    public func fetchMovies() {
        guard !isFetching else {
            return
        }
        isFetching = true
        client.fetchMovies() { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetching = false
                    self.delegate?.didFailFetch(with: error.reason)
                }
            case .success(let result):
                DispatchQueue.main.async {
                    self.total = result.count
                    self.isFetching = false
                    self.movies.append(contentsOf: result)
                    self.delegate?.didFetch()
                }
            }
        }
    }
    
}


