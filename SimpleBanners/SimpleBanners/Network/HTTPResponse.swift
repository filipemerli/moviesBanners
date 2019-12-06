//
//  HTTPResponse.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 05/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation
extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
