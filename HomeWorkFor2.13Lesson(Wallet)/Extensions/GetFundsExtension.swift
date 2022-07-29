//
//  GetFundsExtension.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 27.07.2022.
//

import Foundation

extension Fund {
    static func getAllFunds(of type: TypeOfFunds) -> [Fund] {
        MockFundsContainer.shared.userFunds[type] ?? []
    }
}
