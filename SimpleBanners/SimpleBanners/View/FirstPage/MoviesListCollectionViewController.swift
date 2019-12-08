//
//  MoviesListCollectionViewController.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 08/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MoviesCell"

class MoviesListCollectionViewController: UICollectionViewController {
    
    private var viewModel: MoviesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel = MoviesListViewModel(delegate: self)
        viewModel.fetchMovies()

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesListCollectionViewCell
    
        if !(viewModel.currentCount > 0) {
            cell.setCell(with: .none)
        } else {
            cell.setCell(with: viewModel.movie(at: indexPath.row))
        }
        return cell
    }
    
    private func endOfFetchRequest() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

// MARK: - Table View Model Delegate
    
extension MoviesListCollectionViewController: MoviesListViewModelDelegate {
    func didFetch() {
        endOfFetchRequest()
    }
    
    func didFailFetch(with reason: String) {
        endOfFetchRequest()
    }
    
}
