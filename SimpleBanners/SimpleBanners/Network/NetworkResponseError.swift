//
//  NetworkResponseError.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 05/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

enum NetworkResponseError: Error {
    case rede
    case decoding
    
    var reason: String {
        switch self {
        case .rede:
            return "Erro de rede. Por favor verifique sua conexão"
        case .decoding:
            return "Erro de comunicação com o servidor. Em breve voltaremos."
        }
    }
}
