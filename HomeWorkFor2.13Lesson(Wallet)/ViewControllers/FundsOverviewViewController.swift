//
//  FundsOverviewViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 28.07.2022.
//

import UIKit

class FundsOverviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var currencyForShowing: Currency = .rur
    
    private var costOfTypeOfFunds: [(TypeOfFunds, Double)]!
    private var totalValue: Double!
    private var refToDb = MockFundsContainer.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFundsType()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? FundDetailsViewController
        else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        detailVC.typeOfFunds = costOfTypeOfFunds[index.row].0
    }
    
    private func setupFundsType() {
        
        costOfTypeOfFunds = []
        for (fundsType, _) in refToDb.userFunds {
            costOfTypeOfFunds.append((fundsType, refToDb.getTotalPrice(ofType: fundsType, in: currencyForShowing)))
        }
    }
}


extension FundsOverviewViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
}

extension FundsOverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : refToDb.userFunds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let fundsInfo = costOfTypeOfFunds[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "FundsOverview",
                for: indexPath
            ) as? FundsTypeTableViewCell else { return UITableViewCell() }
            
            cell.totalCostLabel.alpha = 0
            
            cell.fundsTypeLabel.text = fundsInfo.0.rawValue
            
            cell.setTotalCostLabel(with: fundsInfo.1, in: currencyForShowing)
            
            let percentage = (fundsInfo.1 / refToDb.getTotalPrice(in: currencyForShowing)) * 100
            cell.fundsPercent.text = String(format: "%.1f", percentage) + "%"
            
            UIView.animate(withDuration: 0.25) {
                cell.totalCostLabel.alpha = 1
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "FundsOverviewHeader",
                for: indexPath
            ) as? HeaderFundsTypeTableViewCell else { return UITableViewCell() }
            
            cell.currencyLabel.alpha = 0
            cell.totalValueLabel.alpha = 0
            
            cell.setCurrencyLabel(to: self.currencyForShowing)
            cell.setTotalCostLabel(
                with: self.refToDb.getTotalPrice(in: currencyForShowing),
                in: self.currencyForShowing
            )
            UIView.animate(withDuration: 0.25) {
                cell.currencyLabel.alpha = 1
                cell.totalValueLabel.alpha = 1
            }
            
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 0 else { return }
        switch currencyForShowing {
        case .usd:
            currencyForShowing = .eur
        case .eur:
            currencyForShowing = .rur
        default:
            currencyForShowing = .usd
        }
        tableView.reloadData()
        self.setupFundsType()
    }
    
    
}
