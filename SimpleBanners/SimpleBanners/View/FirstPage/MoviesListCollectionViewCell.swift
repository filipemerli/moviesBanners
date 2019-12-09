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
        image.layer.cornerRadius = 8
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
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
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
            let title = movie.title
            movieTitleLabel.text = title
            bannerImageView.loadImageWithUrl(theUrl: movie.coverUrl ?? "http://") { result in
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
    
        bannerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        bannerImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -30).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: bannerImageView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: bannerImageView.centerXAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        bannerImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        movieTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        movieTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
