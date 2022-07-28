//
//  FundsTypeTableViewCell.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 28.07.2022.
//

import UIKit

class FundsTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var fundsPercent: UILabel!
    @IBOutlet weak var fundsTypeLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTotalCostLabel(with value: Double, in currency: Currency) {
        let currencySign: String
        switch currency {
        case .usd:
            currencySign = "$"
        case .eur:
            currencySign = "€"
        default:
            currencySign = "₽"
        }
        UIView.animate(withDuration: 0.3, animations: {
            
            self.totalCostLabel.text = String(format: "%.2f", value) + " " + currencySign
        })
    }
}
