//
//  MainRootViewController.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 05/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class MainRootViewController: UIViewController {

    private let reposListTableViewController = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    private let client = MoviesAPIClient()
        
    // MARK: View Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        configInitialView()
        client.fetchMovies { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let result):
                print(result)
            }
        }
            
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
    }
        
    // MARK: Class Functions
        
    private func configInitialView() {
        view.addSubview(reposListTableViewController)
        reposListTableViewController.isHidden = true
        reposListTableViewController.translatesAutoresizingMaskIntoConstraints = false
        reposListTableViewController.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        reposListTableViewController.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        reposListTableViewController.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        reposListTableViewController.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        activityIndicator.color = .systemGray
            
    }
        
    private func endOfFetchRequest() {
        activityIndicator.stopAnimating()
        reposListTableViewController.isHidden = false
        DispatchQueue.main.async {
            self.reposListTableViewController.reloadData()
        }
    }

}
