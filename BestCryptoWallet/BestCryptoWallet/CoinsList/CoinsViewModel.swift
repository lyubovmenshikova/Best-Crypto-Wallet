//
//  CoinsViewModel.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 22.08.2022.
//

import Foundation

final class CoinsViewModel {
    
    @Published private(set) var coins: [Items]?
    @Published private(set) var result: Bool?
    
    func getCoinsModel(completion: @escaping () -> Void) {
        DataFetcherService.sharedInstance.fetchCoins { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coinsModel):
                self.coins = coinsModel?.data ?? []
                self.result = true
                completion()
            case .failure(let error):
                self.result = false
                print(error) 
            }
        }
    }
}
