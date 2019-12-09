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
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 5.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(MoviesListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        viewModel = MoviesListViewModel(delegate: self)
        viewModel.fetchMovies()

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoviesListCollectionViewCell
        if (viewModel.currentCount > 0) {
            cell.setCell(with: viewModel.movie(at: indexPath.row))
        } else {
            cell.setCell(with: .none)
        }
        return cell
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detalhesVC = DetalheViewController(movie: viewModel.movie(at: indexPath.row))
        navigationController?.pushViewController(detalhesVC, animated: false)
    }
    
    private func endOfFetchRequest() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}

// MARK: - Collection View Model Delegate
    
extension MoviesListCollectionViewController: MoviesListViewModelDelegate {
    func didFetch() {
        endOfFetchRequest()
    }
    
    func didFailFetch(with reason: String) {
        endOfFetchRequest()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesListCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: (widthPerItem * 1.5))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}
