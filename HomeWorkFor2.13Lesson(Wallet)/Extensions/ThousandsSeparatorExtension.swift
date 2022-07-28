//
//  ThousandsSeparatorExtension.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 28.07.2022.
//

import Foundation

extension Double {
    func thousands() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(for: self) ?? ""
    }
}
