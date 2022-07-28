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
    
    private var funds: [Fund]!
    
    private var costOfTypeOfFundsCounter: [TypeOfFunds: Double] = [:]
    private var costOfTypeOfFunds: [(TypeOfFunds, Double)]!
    private var totalValue: Double = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        funds = MockFundsContainer.shared.userFunds
        setupFundsType()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? FundDetailsViewController
        else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        detailVC.typeOfFunds = costOfTypeOfFunds[index.row].0
    }
    
    private func setupFundsType() {
        for fund in funds {
            costOfTypeOfFundsCounter[fund.typeOfFunds] =
            ((costOfTypeOfFundsCounter[fund.typeOfFunds]) ?? 0) +
            fund.getTotalPrice(in: currencyForShowing)
            totalValue += fund.getTotalPrice(in: currencyForShowing)
        }
        costOfTypeOfFunds = costOfTypeOfFundsCounter.sorted { $0.key < $1.key }
    }
}


extension FundsOverviewViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
}

extension FundsOverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return costOfTypeOfFunds.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let fundsInfo = costOfTypeOfFunds[indexPath.row]
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "FundsOverview",
                for: indexPath
            ) as? FundsTypeTableViewCell else { return UITableViewCell() }
            
            cell.fundsTypeLabel.text = fundsInfo.0.rawValue
            
            cell.setTotalCostLabel(with: fundsInfo.1, in: currencyForShowing)
            
            let percentage = (fundsInfo.1 / totalValue) * 100
            cell.fundsPercent.text = String(format: "%.1f", percentage) + "%"
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FundsOverviewHeader",
                                                     for: indexPath)
            return cell
        }
    }
    
    
}
