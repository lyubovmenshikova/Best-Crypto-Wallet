//
//  CoinsViewControllerBuilder.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 22.08.2022.
//

import Foundation

final class CoinsViewControllerBuilder {
    
    static func build() -> CoinsViewController {
        let coinsViewController = CoinsViewController()
        let viewModel = CoinsViewModel()
        
        coinsViewController.viewModel = viewModel
        
        return coinsViewController
    }
}
