//
//  UIImageViewExtension.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 07/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
import UIKit

let imgCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageWithUrl(theUrl: String, completion: @escaping (Result<BannerImageResponse, NetworkResponseError>) -> Void) {
        let url = URL(string: theUrl)
        image = nil
        if let imageFromCache = imgCache.object(forKey: theUrl as NSString) {
            self.image = imageFromCache
            let poster = BannerImageResponse.init(bannerImage: self.image!)
            completion(Result.success(poster))
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(NetworkResponseError.rede))
                    return
            }
            let downloadedImage = UIImage(data: data)!
            imgCache.setObject(downloadedImage, forKey: url!.absoluteString as NSString)
            let image = BannerImageResponse.init(bannerImage: downloadedImage)
            completion(Result.success(image))
        }).resume()
    }

}
