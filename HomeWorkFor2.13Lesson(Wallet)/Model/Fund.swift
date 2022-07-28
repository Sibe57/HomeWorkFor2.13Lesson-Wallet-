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
}



class Stock: Fund {
    let issuer: String
    init(image: String, name: String, currency: Currency,
         price: Double, quantity: Double, issuer: String) {
        self.issuer = issuer
        super.init(typeOfFunds: .stock, image: image, name: name,
                    currency: currency, price: price, quantity: quantity)
    }
    
    static func getMockStocks() -> [Stock] {
        
        var stocks: [Stock] = []
        
        let ds = DataStore.shared
        let quantityOfStocks = min(ds.stockImages.count, ds.stockNames.count,
                                   ds.stockCurrencies.count, ds.stockPrices.count,
                                   ds.stockQuantities.count, ds.stockIssuers.count)
        
        for i in 0..<quantityOfStocks {
            stocks.append(Stock(image: ds.stockImages[i],
                                name: ds.stockNames[i],
                                currency: ds.stockCurrencies[i],
                                price: ds.stockPrices[i],
                                quantity: ds.stockQuantities[i],
                                issuer: ds.stockIssuers[i]))
        }
        return stocks
    }
}



class Bond: Fund {
    let issuer: String
    let yield: Double
    
    init(image: String, name: String, currency: Currency,
         price: Double, quantity: Double, issuer: String, yield: Double) {
        self.issuer = issuer
        self.yield = yield
        super.init(typeOfFunds: .bound, image: image, name: name,
                   currency: currency, price: price, quantity: quantity)
    }
    
    static func getMockBounds() -> [Bond] {
        
        var bonds: [Bond] = []
        
        let ds = DataStore.shared
        let quantityOfBonds = min(ds.bondImages.count, ds.bondNames.count,
                                   ds.bondCurrencies.count, ds.bondPrices.count,
                                   ds.bondQuantities.count, ds.bondIssuers.count,
                                   ds.bondYelds.count)
        
        for i in 0..<quantityOfBonds {
            bonds.append(Bond(image: ds.bondImages[i],
                              name: ds.bondNames[i],
                              currency: ds.bondCurrencies[i],
                              price: ds.bondPrices[i],
                              quantity: ds.bondQuantities[i],
                              issuer: ds.stockIssuers[i],
                              yield: ds.bondYelds[i]))
        }
        return bonds
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
    
    static func getMockCash() -> [Cash] {
        
        var cash: [Cash] = []
        
        let ds = DataStore.shared
        let quantityOfCash = min(ds.cashImages.count,
                                 ds.cashCurrencies.count,
                                 ds.cashQuantities.count)
        
        for i in 0..<quantityOfCash {
            cash.append(Cash(image: ds.cashImages[i],
                             currency: ds.cashCurrencies[i],
                             quantity: ds.cashQuantities[i]))
        }
        return cash
    }
}



class CryptoCurrency: Fund {
    let ticker: String
    
    init(image: String, name: String,
         price: Double, quantity: Double, ticker: String) {
        self.ticker = ticker
        super.init(typeOfFunds: .cryptoCurrency, image: image, name: name,
                   currency: .usd, price: price, quantity: quantity)
    }
    
    static func getMockCrypto() -> [CryptoCurrency] {
        
        var cryptoCurrencies: [CryptoCurrency] = []
        
        let ds = DataStore.shared
        let quantityOfCrypto = min(ds.cryptoImages.count, ds.cryptoNames.count,
                                   ds.cryptoPrices.count, ds.cryptoQuantities.count,
                                   ds.cryptoTickers.count)
        
        for i in 0..<quantityOfCrypto {
            cryptoCurrencies.append(CryptoCurrency(image: ds.cryptoImages[i],
                                                   name: ds.cryptoNames[i],
                                                   price: ds.cryptoPrices[i],
                                                   quantity: ds.cryptoQuantities[i],
                                                   ticker: ds.cryptoTickers[i]))
        }
        return cryptoCurrencies
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
    
    static func getMockMetalls() -> [Metall] {
        
        var metalls: [Metall] = []
        
        let ds = DataStore.shared
        let quantityOfMetalls = min(ds.metallTypes.count, ds.metalImages.count,
                                   ds.metalPrices.count, ds.metalQantities.count)
        
        for i in 0..<quantityOfMetalls {
            metalls.append(Metall(typeOfMetall: ds.metallTypes[i],
                                  image: ds.metalImages[i],
                                  price: ds.metalPrices[i],
                                  quantity: ds.metalQantities[i]))
        }
        return metalls
    }
}


enum TypeOfFunds: String {
    case stock = "Акции"
    case bound = "Облигации"
    case cash = "Фиатная Валюта"
    case cryptoCurrency = "Криптовалюта"
    case metall = "Драгоценые металлы"
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
