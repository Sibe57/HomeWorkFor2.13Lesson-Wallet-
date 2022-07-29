//
//  FundDetailsViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 27.07.2022.
//

import UIKit
import Foundation

class FundDetailsViewController: UITableViewController {
    
    var typeOfFunds = TypeOfFunds.stock
    
    var funds: [Fund]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = typeOfFunds.rawValue
        
        funds = Fund.getAllFunds(of: typeOfFunds)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        funds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fundElement", for: indexPath) as? FundDetailsTableViewCell else { return UITableViewCell() }

//        cell.selectionStyle = .none
        
        cell.activeNameLabel.text = funds[indexPath.row].name
        
        cell.activePriceLabel.text = String(Int(funds[indexPath.row].quantity)) +
        " шт. | " +
        Converter.getText(
            from: funds[indexPath.row].price,
            with: funds[indexPath.row].currency
        )
        
        cell.activeSumLabel.text = Converter.getText(
            from: funds[indexPath.row].totalPrice,
            with: funds[indexPath.row].currency
        )
        
        cell.iconImage.image = UIImage(systemName: funds[indexPath.row].image) ?? UIImage(systemName: "exclamationmark.icloud.fill")

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditQuantityAlert(for: indexPath.row)
    }
    
    func showEditQuantityAlert(for index: Int) {
        let editAlert = UIAlertController(
            title: typeOfFunds.rawValue + " " + funds[index].name,
            message: "Введите кол-во, шт.",
            preferredStyle: .alert
        )
        
        editAlert.addTextField()
        editAlert.textFields?.first?.text = String(Int(funds[index].quantity))
        
        let alertButton = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in
                if let quantity = Double((editAlert.textFields?.first?.text) ?? "") {
                    MockFundsContainer.shared.updateQuantityOfFund(type: self.typeOfFunds, index: index, newValue: quantity)
                    self.tableView.reloadData()
                }
            }
        )
        
        editAlert.addAction(alertButton)
        
        present(editAlert, animated: true)
    }
    
    

}
