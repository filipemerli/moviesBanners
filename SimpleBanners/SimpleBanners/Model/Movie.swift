//
//  Movie.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 05/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

struct Movie {
    let title: String
    let overview: String
    let duration: String
    let releaseYear: String
    let coverUrl: String
    let backDrops: [String]
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case duration
        case releaseYear = "release_year"
        case coverUrl = "cover_url"
        case backDrops = "backdrops_url"
        case id
    }
    
    init(title: String, overview: String, duration: String, releaseYear: String, coverUrl: String, backDrops: [String], id: String) {
        self.title = title
        self.overview = overview
        self.duration = duration
        self.releaseYear = releaseYear
        self.coverUrl = coverUrl
        self.backDrops = backDrops
        self.id = id
    }
}

extension Movie: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let overview = try container.decode(String.self, forKey: .overview)
        let duration = try container.decode(String.self, forKey: .duration)
        let releaseYear = try container.decode(String.self, forKey: .releaseYear)
        let coverUrl = try container.decode(String.self, forKey: .coverUrl)
        let backDrops = try container.decode([String].self, forKey: .backDrops)
        let id = try container.decode(String.self, forKey: .id)
        self.init(title: title, overview: overview, duration: duration, releaseYear: releaseYear, coverUrl: coverUrl, backDrops: backDrops, id: id)
    }
    
}
