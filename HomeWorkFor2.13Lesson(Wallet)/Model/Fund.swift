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
    var quantity: Double
    var totalPrice: Double {
        quantity * price
    }
    
    init(typeOfFunds: TypeOfFunds, image: String, name: String,
         currency: Currency, price: Double, quantity: Double) {
        
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
                    price: Double.random(in: 1...100),
                    quantity: Double.random(in: 1...10)
                )
            )
        }
        
        return funds
    }
}



class Stock: Fund {
    let issuer: String
    init(image: String, name: String, currency: Currency,
         price: Double, quantity: Double, issuer: String) {
        self.issuer = issuer
        super.init(typeOfFunds: .stock, image: image, name: name,
                    currency: currency, price: price, quantity: quantity)
    }
}



class Bound: Fund {
    let issuer: String
    let yield: Double
    
    init(image: String, name: String, currency: Currency,
         price: Double, quantity: Double, issuer: String, yield: Double) {
        self.issuer = issuer
        self.yield = yield
        super.init(typeOfFunds: .bound, image: image, name: name,
                   currency: currency, price: price, quantity: quantity)
    }
}



class Cash: Fund {
    
    var country: String {
        switch currency {
        case .usd:
            return "США"
        case .eur:
            return "Евро Союз"
        case .rur:
            return "Российская Федерация"
        case .cny:
            return "Китай"
        case .jpy:
            return "Япония"
        }
    }
    
    init(image: String, currency: Currency,
                  quantity: Double) {
        super.init(typeOfFunds: .cash, image: image, name: currency.rawValue,
                   currency: currency, price: 1, quantity: quantity)
    }
}



class cryptoCurrency: Fund {
    let ticker: String
    
    init(image: String, name: String,
         price: Double, quantity: Double, ticker: String) {
        self.ticker = ticker
        super.init(typeOfFunds: .cryptoCurrency, image: image, name: name,
                   currency: .usd, price: price, quantity: quantity)
    }
}



class Eft: Fund {
    let issuer: String
    
    init(image: String, name: String, currency: Currency,
         price: Double, quantity: Double, issuer: String) {
        self.issuer = issuer
        super.init(typeOfFunds: .etf, image: image, name: name,
                    currency: currency, price: price, quantity: quantity)
    }
}



class Metall: Fund {
    let typeOfMetall: TypeOfMetall
    init(typeOfMetall: TypeOfMetall, image: String, price: Double, quantity: Double) {
        self.typeOfMetall = typeOfMetall
        super.init(typeOfFunds: .metall, image: image,
                   name: typeOfMetall.rawValue, currency: .usd,
                   price: price, quantity: quantity)
    }
}



enum TypeOfFunds: String {
    case stock = "Акция"
    case bound = "Облигация"
    case cash = "Фиатная Валюта"
    case cryptoCurrency = "Криптовалюта"
    case etf = "ETF"
    case metall = "Драгоценый металл"
}

enum Currency: String {
    case usd = "Доллар США"
    case eur = "Евро"
    case rur = "Российский рубль"
    case cny = "Юань"
    case jpy = "Йена"
}

enum TypeOfMetall: String {
    case gold = "Золото"
    case silver = "Серебро"
    case palladium = "Палладий"
}
