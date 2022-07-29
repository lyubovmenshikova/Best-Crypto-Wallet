//
//  CoinsModel.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 28.07.2022.
//

import Foundation

struct CoinsModel: Decodable {
    let data: [Items]
}

struct Items: Decodable {
    let symbol: String
    let name: String
    let metrics: Metrics
}

struct Metrics: Decodable {
    let market_data: MarketData
}

struct MarketData: Decodable {
    let price_usd: Double
    let percent_change_usd_last_1_hour: Double?
    let percent_change_usd_last_24_hours: Double?
}
