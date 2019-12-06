//
//  MoviesAPIClient.swift
//  SimpleBanners
//
//  Created by Filipe Merli on 05/12/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

class MoviesAPIClient {
    
    private lazy var endPoint: URL = {
        return URL(string: "https://sky-exercise.herokuapp.com")!
    }()
    
    let session: URLSession
    let path = "api/Movies"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchMovies(completion: @escaping (Result<[Movie], NetworkResponseError>) -> Void) {
        let urlRequest = URLRequest(url: endPoint.appendingPathComponent(path))
        print("URLRequest = \(urlRequest)")
        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
        print("Data = \(String(describing: data))")
        guard let httpResponse = response as? HTTPURLResponse,
        httpResponse.hasSuccessStatusCode,
        let dados = data
        else {
            completion(Result.failure(NetworkResponseError.rede))
            return
        }
            guard let decodedResponse = try? JSONDecoder().decode([Movie].self, from: dados) else {
            completion(Result.failure(NetworkResponseError.decoding))
            return
        }
        completion(Result.success(decodedResponse))
        }).resume()
    }
}
