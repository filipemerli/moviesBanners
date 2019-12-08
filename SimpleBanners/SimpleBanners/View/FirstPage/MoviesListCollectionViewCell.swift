//
//  MoviesListCollectionViewCell.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 08/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class MoviesListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let bannerImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
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
        return label
    }()
    
    // MARK: VC Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setCell(with: .none)
        activityIndicator.startAnimating()
    }
    
    // MARK: Class Functions
    
    func setCell(with movie: Movie?) {
        activityIndicator.startAnimating()
        if let movie = movie {
            movieTitleLabel.text = "Title: \(movie.title)"
            bannerImageView.loadImageWithUrl(theUrl: movie.coverUrl) { result in
                switch result {
                case .failure ( _):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.bannerImageView.image = #imageLiteral(resourceName: "placeholder")
                    }
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.bannerImageView.image = response.bannerImage
                    }
                }
            }
        }
    }
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(bannerImageView)
        contentView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        containerView.addSubview(movieTitleLabel)
        contentView.addSubview(containerView)
    
        bannerImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:10).isActive = true
        bannerImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        bannerImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:30).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        movieTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
