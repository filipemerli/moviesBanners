//
//  RootNavigationViewController.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 08/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class RootNavigationViewController: UINavigationController {
    
    private let moviesListCollectionViewController = MoviesListCollectionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        configInitialView()
    }
    

    // MARK: Class Functions
        
    private func configInitialView() {
        //push CollectionVC
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150.0, height: 150.0)
        
        let moviesListCollectionVC = MoviesListCollectionViewController(collectionViewLayout: layout)
        self.pushViewController(moviesListCollectionVC, animated: false)
    }

}
