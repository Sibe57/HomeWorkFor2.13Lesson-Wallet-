//
//  MockFundsContainer.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 27.07.2022.
//

import Foundation

class MockFundsContainer {
    static let shared = MockFundsContainer()
    
    var userFunds: [Fund] = Stock.getMockStocks() + Bond.getMockBounds() +
    Cash.getMockCash() + CryptoCurrency.getMockCrypto() + Metall.getMockMetalls()
    
    func delFund(ofType type: TypeOfFunds, number: Int) {
        let basePointer = userFunds.firstIndex { $0.typeOfFunds == type }
        
        userFunds.remove(at: basePointer + number)
    }
    
    private init() {}
}
