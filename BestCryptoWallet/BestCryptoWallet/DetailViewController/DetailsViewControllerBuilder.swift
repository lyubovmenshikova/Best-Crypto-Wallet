//
//  DetailsViewControllerBuilder.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 22.08.2022.
//

import Foundation

final class DetailsViewControllerBuilder {
    
    static func build(symbol: String) -> DetailViewController {
        let detailViewController = DetailViewController()
        let viewModel = DetailViewModel()
        
        detailViewController.viewModel = viewModel
        viewModel.symbol = symbol
        
        return detailViewController
    }
}
