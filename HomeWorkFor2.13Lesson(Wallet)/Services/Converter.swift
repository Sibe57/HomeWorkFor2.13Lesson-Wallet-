//
//  Converter.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 27.07.2022.
//

import Foundation

class Converter {
    static func getExchangeRate(of currency: Currency) -> Double {
        switch currency {
        case .usd:
            return 1
        case .eur:
            return 0.99
        case .rur:
            return 60.13
        case .cny:
            return 6.76
        case .jpy:
            return 136.66
        }
    }
    
    static func getText(from value: Double, with currency: Currency) -> String {
        let currencySign: String
        
        switch currency {
        case .usd:
            currencySign = "$"
        case .eur:
            currencySign = "€"
        default:
            currencySign = "₽"
        }
        return value.thousands() + " " + currencySign
    }
}

