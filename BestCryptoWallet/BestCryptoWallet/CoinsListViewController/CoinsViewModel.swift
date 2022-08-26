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
    
    func getCoinsModel() {
        DataFetcherService.sharedInstance.fetchCoins { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let coinsModel):
                self.coins = coinsModel?.data ?? []
                self.result = true
            case .failure(let error):
                self.result = false
                print(error) 
            }
        }
    }
}

extension CoinsViewModel: SortViewControllerDelegate {
    
    func sortBy(option: SortBy) {
        switch option {
        case .fallingInAnHour:
            coins = coins?.sorted(by: { $0.metrics.market_data.percent_change_usd_last_1_hour ?? 0 > $1.metrics.market_data.percent_change_usd_last_1_hour ?? 0
            })
        case .growthInAnHour:
            coins = coins?.sorted(by: { $0.metrics.market_data.percent_change_usd_last_1_hour ?? 0 < $1.metrics.market_data.percent_change_usd_last_1_hour ?? 0
            })
        case .fallingPerDay:
            coins = coins?.sorted(by: { $0.metrics.market_data.percent_change_usd_last_24_hours ?? 0 > $1.metrics.market_data.percent_change_usd_last_24_hours ?? 0
            })
        case .growthPerDay:
            coins = coins?.sorted(by: { $0.metrics.market_data.percent_change_usd_last_24_hours ?? 0 < $1.metrics.market_data.percent_change_usd_last_24_hours ?? 0
            })
        }
    }
    
}
