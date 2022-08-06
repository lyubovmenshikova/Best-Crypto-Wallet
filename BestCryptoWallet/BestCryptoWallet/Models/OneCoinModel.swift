//
//  OneCoinModel.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 04.08.2022.
//

import Foundation

struct OneCoinModel: Decodable {
    let data: Item
}

struct Item: Decodable {
    let name: String?
    let tagline: String?
    let token_distribution: TokenDistribution
}

struct TokenDistribution: Decodable {
    let sale_start: String?
    let description: String?
}
