//
//  DataFetcherService.swift
//  MovieChooser
//
//  Created by Lyubov Menshikova on 18.05.2022.
//

import Foundation
 
class DataFetcherService {
    
    var dataFetcher: DataFetcher!
    static let sharedInstance = DataFetcherService()
    
    private init(dataFetcher: DataFetcher = NetworkDataFetcher()){
        self.dataFetcher = dataFetcher
    }
    
    func fetchCoins (completion: @escaping (CoinsModel?) -> Void) {
        let urlCoins = "https://data.messari.io/api/v1/assets"
        dataFetcher.fetchGenericJSONData(urlString: urlCoins, response: completion)
    }
    
}
