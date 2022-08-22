//
//  DetailProtocols.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 22.08.2022.
//

import Foundation

protocol DetailViewControllerProtocolIn {
    func getCoinModel()
}

protocol DetailViewControllerProtocolOut {
    var setCoinModel: (OneCoinModel?) -> Void { get set }
}
