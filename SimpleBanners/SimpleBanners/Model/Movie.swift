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
    
    enum CodingKeys: String, CodingKey {
        case title
    }
    
    init(title: String) {
        self.title = title
    }
}

extension Movie: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        self.init(title: title)
    }
    
}
