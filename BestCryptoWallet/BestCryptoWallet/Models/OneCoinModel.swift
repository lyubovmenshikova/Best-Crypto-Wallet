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
    let relevant_resources: [Resources]?
}

struct Resources: Decodable {
    let url: String?
}
