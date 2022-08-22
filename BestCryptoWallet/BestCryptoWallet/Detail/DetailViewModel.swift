//
//  DetailViewModel.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 22.08.2022.
//

import Foundation


class DetailViewModel: DetailViewControllerProtocolIn, DetailViewControllerProtocolOut {
    
    var symbol: String?
    
    func getCoinModel() {
        if let symbol = symbol {
            DataFetcherService.sharedInstance.fetchOneCoin(symbol: symbol) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let oneCoin):
                    self.setCoinModel(oneCoin)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
        
 
    var setCoinModel: (OneCoinModel?) -> Void = { _ in }
    
}
