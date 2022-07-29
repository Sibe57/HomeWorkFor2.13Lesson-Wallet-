//
//  HeaderFundsTypeTableViewCell.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 28.07.2022.
//

import UIKit

class HeaderFundsTypeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var totalValueLabel: UILabel!
    
    func setCurrencyLabel(to currency: Currency) {
        switch currency {
        case .usd:
            currencyLabel.text = "(в долларах)"
        case .eur:
            currencyLabel.text = "(в евро)"
        default:
            currencyLabel.text = "(в рублях)"
        }
    }
}
