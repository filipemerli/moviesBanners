//
//  DetalhesViewModel.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 08/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

protocol DetalhesViewModelDelegate: class {
    func didFetch()
    func didFailFetch(with reason: String)
}

final class DetalhesViewModel {
    
    // MARK: Properties
    
    private weak var delegate: DetalhesViewModelDelegate?
    public var movie: Movie
    public var coverBanner = UIImageView()
    private var isFetching = false
    
    // MARK: Initializer
    
    init(movie: Movie, delegate: DetalhesViewModelDelegate) {
        self.delegate = delegate
        self.movie = movie
    }
    
    // MARK: Class Functions
    
    public func fetchCoverBanner() {
        guard !isFetching else {
            return
        }
        isFetching = true
        coverBanner.loadImageWithUrl(theUrl: movie.backDrops.first ?? "http://") { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetching = false
                    self.delegate?.didFailFetch(with: error.reason)
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self.isFetching = false
                    self.coverBanner.image = image.bannerImage
                    self.delegate?.didFetch()
                }
            }
        }
    }
    
}


