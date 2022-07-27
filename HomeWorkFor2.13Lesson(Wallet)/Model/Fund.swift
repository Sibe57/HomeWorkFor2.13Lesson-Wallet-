//
//  Funds.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 27.07.2022.
//

import Foundation

class Fund {
    let typeOfFunds: TypeOfFunds
    let image: String
    let name: String
    let currency: Currency
    var price: Double
    var quantity: Int
    var totalPrice: Double {
        Double(quantity) * price
    }
    
    init(typeOfFunds: TypeOfFunds, image: String, name: String,
         currency: Currency, price: Double, quantity: Int) {
        
        self.typeOfFunds = typeOfFunds
        self.image = image
        self.name = name
        self.currency = currency
        self.price = price
        self.quantity = quantity
    }
    // выводит стоимость актива в любой валюте
    func getTotalPrice(in currency: Currency) -> Double {
        let rateOfFunds = Converter.getExchangeRate(of: self.currency)
        let rateOfOutputCurrency = Converter.getExchangeRate(of: currency)
        return totalPrice / rateOfFunds * rateOfOutputCurrency
    }
    
    static func getFunds() -> [Fund] {
        let dataStore = DataStore()
        
        var funds = [Fund]()
        
        for name in dataStore.names {
            funds.append(
                Fund(
                    typeOfFunds: dataStore.fundsType,
                    image: dataStore.images.shuffled().first ?? "trash",
                    name: name,
                    currency: dataStore.currency,
                    price: Double.random(in: 0.1...100),
                    quantity: Int.random(in: 1...10)
                )
            )
        }
        
        return funds
    }
}



class Stock: Fund {
    let issuer: String
    init(image: String, name: String, currency: Currency,
         price: Double, quantity: Int, issuer: String) {
        self.issuer = issuer
        super.init(typeOfFunds: .stock, image: image, name: name,
                    currency: currency, price: price, quantity: quantity)
    }
}



class Bound: Fund {
    let issuer: String
    let yield: Double
    
    init(image: String, name: String, currency: Currency,
         price: Double, quantity: Int, issuer: String, yield: Double) {
        self.issuer = issuer
        self.yield = yield
        super.init(typeOfFunds: .bound, image: image, name: name,
                   currency: currency, price: price, quantity: quantity)
    }
}
//
//struct Cash: Funds {
//    var typeOffunds = TypeOfFunds.cash
//    var image: String
//    var name: String
//    var currency: Currency
//    var price: Double = 1.0
//    var country: String
//}
//
//struct cryptoCurrency: Funds {
//    var typeOffunds = TypeOfFunds.cryptoCurrency
//    var image: String
//    var name: String
//    var currency: Currency
//    var price: Double
//    var ticker: String
//}
//
//struct Eft: Funds {
//    var typeOffunds = TypeOfFunds.etf
//    var image: String
//    var name: String
//    var currency: Currency
//    var price: Double
//}
//
//struct Metall: Funds {
//    var typeOffunds = TypeOfFunds.metall
//    var typeOfMetal: TypeOfMetall
//    var image: String
//    var name: String {
//        switch typeOfMetal {
//        case .gold:
//            return "Золото"
//        case .silver:
//            return "Серебро"
//        case .palladium:
//            return "Палладий"
//        }
//    }
//    var currency: Currency
//    var price: Double
//}

enum TypeOfFunds {
    case stock
    case bound
    case cash
    case cryptoCurrency
    case etf
    case metall
}

enum Currency {
    case usd
    case eur
    case rur
    case cny
    case jpy
}

enum TypeOfMetall {
    case gold
    case silver
    case palladium
}
