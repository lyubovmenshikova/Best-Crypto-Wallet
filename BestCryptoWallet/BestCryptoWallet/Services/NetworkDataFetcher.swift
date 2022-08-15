//
//  NetworkDataFetcher.swift
//  MovieChooser
//
//  Created by Lyubov Menshikova on 18.05.2022.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (Result<T, Error>) -> Void)
}


class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    init(networking: Networking = NetworkService() ){
        self.networking = networking
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (Result<T, Error>) -> Void) {
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                response(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    response(.success(result))
                } catch {
                    response(.failure(error))
                }
            } else {
                response(.failure(NetworkError.unknown))
            }
        }
    }
    
}
