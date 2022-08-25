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
        let loginViewController = LoginViewController(loginView: loginView, userData: UserData.getUserData())
        let viewModel = LoginViewModel()
        
        loginViewController.viewModel = viewModel
        
        return loginViewController
    }
}
