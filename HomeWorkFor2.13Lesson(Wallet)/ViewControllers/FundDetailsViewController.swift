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
        
        cell.activeNameLabel.text = funds[indexPath.row].name
        
        cell.activePriceLabel.text = "\(getTextQuantity(from: funds[indexPath.row].quantity)) шт. | " +
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
            title: "Изменить \(typeOfFunds.rawValue) \(funds[index].name)?",
            message: "Введите новое кол-во, шт.",
            preferredStyle: .alert
        )
        
        editAlert.addTextField()
        editAlert.textFields?.first?.text = getTextQuantity(from: funds[index].quantity)
        editAlert.textFields?.first?.keyboardType = .decimalPad
        
        let okButton = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in
                if let quantity = Double((editAlert.textFields?.first?.text)!) {
                    if quantity >= 0 {
                        MockFundsContainer.shared.updateQuantityOfFund(type: self.typeOfFunds, index: index, newValue: quantity)
                        if quantity == 0 {
                            self.funds.remove(at: index)
                        }
                        self.tableView.reloadData()
                    } else {
                        self.showIncorrectNumber(for: index)
                    }
                } else {
                    self.showIncorrectNumber(for: index)
                }
            }
        )
        
        editAlert.addAction(okButton)
        
        let cancelButton = UIAlertAction(title: "Отмена", style: .default)
        editAlert.addAction(cancelButton)
        
        present(editAlert, animated: true)
    }
    
    func showIncorrectNumber(for index: Int) {
        let incorrectAlert = UIAlertController(
            title: "Некорректное значение",
            message: "Введите корректное значение от 0 и больше",
            preferredStyle: .alert
        )
        
        let alertButton = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in
                self.showEditQuantityAlert(for: index)
            }
        )
        
        incorrectAlert.addAction(alertButton)
        
        present(incorrectAlert, animated: true)
    }
    
    func getTextQuantity(from number: Double) -> String {
        if number.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(number))
        } else {
            return String(number)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addFundVC = segue.destination as? AddFundViewController else { return }
        addFundVC.typeOfFund = typeOfFunds
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        funds = Fund.getAllFunds(of: typeOfFunds)
        tableView.reloadData()
    }

}
