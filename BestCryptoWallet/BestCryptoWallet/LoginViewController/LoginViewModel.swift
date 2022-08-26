//
//  LoginViewModel.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 25.08.2022.
//

import Foundation


final class LoginViewModel {
    
    private let userData: UserData
    @Published private(set) var login: String?
    @Published private(set) var password: String?
    
    init(userData: UserData) {
        self.userData = userData
    }
    
    func getUserData() {
        login = userData.login
        password = userData.password
    }
}
