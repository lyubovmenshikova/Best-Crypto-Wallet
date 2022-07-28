//
//  UserDataModel.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 28.07.2022.
//

import Foundation

struct UserData {
    var login: String
    var password: String
    
    static func getUserData() -> UserData {
        UserData(login: "User", password: "1")
    }
}
