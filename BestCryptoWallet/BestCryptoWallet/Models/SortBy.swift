//
//  SortBy.swift
//  BestCryptoWallet
//
//  Created by Lyubov Menshikova on 30.07.2022.
//

import Foundation

enum SortBy: Int {
    case fallingInAnHour = 0
    case growthInAnHour
    case fallingPerDay
    case growthPerDay
    
    init?(index: Int) {
            switch index {
            case 0: self = .fallingInAnHour
            case 1: self = .growthInAnHour
            case 2: self = .fallingPerDay
            case 3: self = .growthPerDay
            default:
                return nil
            }
        }
    
    var description: String? {
        get {
            switch self {
            case .fallingInAnHour: return "Падению за час"
            case .growthInAnHour: return "Росту за час"
            case .fallingPerDay: return "Падению за сутки"
            case .growthPerDay: return "Росту за сутки"
            }
        }
    }
}
