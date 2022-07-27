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
                            Cash.getMockCash()
    private init() {}
}
