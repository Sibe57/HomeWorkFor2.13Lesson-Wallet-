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
    var progressView: UIView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        progressView.removeFromSuperview()
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
        self.totalCostLabel.text = value.thousands() + " " + currencySign
    }
    
    func setProgressView(on position: Double) {
        progressView = UIView(frame: CGRect(
            origin: CGPoint(x: 16, y: 2),
            size: CGSize(
                width: contentView.layer.bounds.width * position,
                height: contentView.layer.bounds.height - 4)
        ))
        
        progressView.backgroundColor = .blue
        progressView.alpha = 0.2
        progressView.layer.cornerRadius = progressView.layer.bounds.width > 32
        ? 16
        : progressView.layer.bounds.width / 2
        contentView.addSubview(progressView)
    }
}
