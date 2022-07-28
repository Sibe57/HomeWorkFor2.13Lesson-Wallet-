//
//  GetFundsExtension.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 27.07.2022.
//

import Foundation

extension Fund {
    static func getAllFunds(of type: TypeOfFunds) -> [Fund] {
        var funds = [Fund]()
        
        for fund in MockFundsContainer.shared.userFunds {
            print(1)
            if fund.typeOfFunds == type {
                funds.append(fund)
            }
        }
        
        return funds
    }
}
