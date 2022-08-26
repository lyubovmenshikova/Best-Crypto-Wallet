//
//  LoginViewControllerBuilder.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 25.08.2022.
//

import Foundation

final class LoginViewControllerBuilder {
    
    static func build() -> LoginViewController {
        let loginView = LoginView()
        let loginViewController = LoginViewController(loginView: loginView)
        let viewModel = LoginViewModel(userData: UserData.getUserData())
        
        loginViewController.viewModel = viewModel
        
        return loginViewController
    }
}
