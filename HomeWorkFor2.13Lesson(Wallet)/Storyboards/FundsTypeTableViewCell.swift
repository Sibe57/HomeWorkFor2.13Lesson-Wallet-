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
    
    @IBOutlet weak var recomendationCircle: UIImageView!
    
    var progressView: UIView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

    
    override func prepareForReuse() {
        progressView.removeFromSuperview()
    }
    
    func setProgressView(on position: Double) {
        progressView = UIView(frame: CGRect(
            origin: CGPoint(x: 16, y: 2),
            size: CGSize(
                width: UIScreen.main.bounds.width * position,
                height: contentView.layer.bounds.height - 4)
        ))
        
        progressView.backgroundColor = UIColor(named: "MainColor")
        progressView.alpha = 0
        progressView.layer.cornerRadius = progressView.layer.bounds.width > 32
        ? 16
        : progressView.layer.bounds.width / 2
        contentView.addSubview(progressView)
        UIView.animate(withDuration: 0.25) { [unowned self] in
            self.progressView.alpha = 0.2
        }
    }
    
    func setRecomendationCircle(recomendation: Recomendation?) {
        switch recomendation {
        case .moreThan:
            recomendationCircle.image = UIImage(systemName: "arrow.down.circle")
            recomendationCircle.tintColor = .systemOrange
        case .lessThan:
            recomendationCircle.image = UIImage(systemName: "arrow.up.circle")
            recomendationCircle.tintColor = .systemOrange
        case .perfect:
            recomendationCircle.image = UIImage(systemName: "checkmark.circle")
            recomendationCircle.tintColor = .systemGreen
        case .none:
            recomendationCircle.image = nil
        }
    }
}
