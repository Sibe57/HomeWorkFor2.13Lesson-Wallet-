//
//  MockFundsContainer.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 27.07.2022.
//

import Foundation

class MockFundsContainer {
    static let shared = MockFundsContainer()
    
    var userFunds: [TypeOfFunds: [Fund]] = [
        .stock: Stock.getMockStocks(),
        .bound: Bond.getMockBounds(),
        .cash: Cash.getMockCash(),
        .cryptoCurrency: CryptoCurrency.getMockCrypto(),
        .metall: Metall.getMockMetalls()
    ]
    
    func delFund(ofType type: TypeOfFunds, number: Int) {
        userFunds[type]?.remove(at: number)
    }
    
    func getTotalPrice(ofType type: TypeOfFunds, in currency: Currency) -> Double {
        var totalPrice = 0.0
        guard let funds = userFunds[type] else { return 0 }
        for fund in funds {
            totalPrice += fund.getTotalPrice(in: currency)
        }
        return totalPrice
    }
    
    func getTotalPrice(in currency: Currency) -> Double {
        var totalPrice = 0.0
        for funds in userFunds {
            for fund in funds.value {
                totalPrice += fund.getTotalPrice(in: currency)
            }
        }
        return totalPrice
    }
    
    func updateQuantityOfFund(type: TypeOfFunds, index: Int, newValue: Double) {
        guard newValue > 0
        else {
            delFund(ofType: type, number: index)
            return
        }
        guard let funds = userFunds[type], index < funds.count else { return }
        
        let fund = funds[index]
        
        fund.quantity = newValue
        
        userFunds[type]?[index] = fund
        
    }
    
    func addStock(
        image: String = "n.circle",
        name: String,
        currency: Currency,
        price: Double,
        quantity: Double,
        issuer: String
    ) {
        let newStock = Stock(
            image: image,
            name: name,
            currency: currency,
            price: price,
            quantity: quantity,
            issuer: issuer
        )
        
        userFunds[.stock]?.append(newStock)
    }
    
    private init() {}
}
