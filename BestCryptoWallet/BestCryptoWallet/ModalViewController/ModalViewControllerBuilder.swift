//
//  ModalViewControllerBuilder.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 25.08.2022.
//

import Foundation

final class ModalViewControllerBuilder {
    
    static func build(coinsViewModel: SortViewControllerDelegate) -> ModalViewController {
        let modalViewController = ModalViewController()
        let viewModel = ModalViewModel()
        
        modalViewController.viewModel = viewModel
        modalViewController.delegate = coinsViewModel
        
        return modalViewController
    }
}
