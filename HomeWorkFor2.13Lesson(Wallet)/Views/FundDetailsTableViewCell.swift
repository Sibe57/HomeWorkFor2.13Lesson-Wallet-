//
//  FundDetailsTableViewCell.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 29.07.2022.
//

import UIKit

class FundDetailsTableViewCell: UITableViewCell {

    @IBOutlet var activeNameLabel: UILabel!
    @IBOutlet var activePriceLabel: UILabel!
    @IBOutlet var activeSumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSumLabel(with value: Double, in currency: Currency) {
        let currencySign: String
        switch currency {
        case .usd:
            currencySign = "$"
        case .eur:
            currencySign = "€"
        default:
            currencySign = "₽"
        }
        activeSumLabel.text = value.thousands() + " " + currencySign
    }

}
