//
//  DetailViewModel.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 22.08.2022.
//

import Foundation

final class DetailViewModel {
    
    var symbol: String?
    
    @Published private(set) var oneCoinModel: OneCoinModel?
    
    
    func getCoinModel() {
        if let symbol = symbol {
            DataFetcherService.sharedInstance.fetchOneCoin(symbol: symbol) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let oneCoinModel):
                    self.oneCoinModel = oneCoinModel
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    
}
