//
//  DetalheViewController.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 08/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class DetalheViewController: UIViewController {
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel = DetalhesViewModel(movie: movie, delegate: self)
        viewModel.fetchCoverBanner()
    }
    
    // MARK: Properties
    
    private var viewModel: DetalhesViewModel!
    public let movie: Movie

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var coverBannerImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let movieOverview: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 13)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func configureView() {
        view.addSubview(coverBannerImageView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        containerView.addSubview(movieTitleLabel)
        containerView.addSubview(movieOverview)
        view.addSubview(containerView)
        
        coverBannerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        coverBannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        coverBannerImageView.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.size.height - (navigationController?.navigationBar.bounds.height ?? 0)) / 2).isActive = true
        coverBannerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        coverBannerImageView.backgroundColor = .red
            
        activityIndicator.centerYAnchor.constraint(equalTo: coverBannerImageView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: coverBannerImageView.centerXAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: coverBannerImageView.bottomAnchor).isActive = true
            
        coverBannerImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        movieTitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        movieOverview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        movieOverview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        movieOverview.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor).isActive = true
        movieOverview.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
    }
    
    private func endOfFetchRequest() {
        activityIndicator.stopAnimating()
    }

}

// MARK: - Collection View Model Delegate
    
extension DetalheViewController: DetalhesViewModelDelegate {
    func didFetch() {
        coverBannerImageView.image = viewModel.coverBanner.image
        movieTitleLabel.text = movie.title
        movieOverview.text = movie.overview
        endOfFetchRequest()
    }
    
    func didFailFetch(with reason: String) {
        coverBannerImageView.image = #imageLiteral(resourceName: "placeholder")
        endOfFetchRequest()
    }
    
}
