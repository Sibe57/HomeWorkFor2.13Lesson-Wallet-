//
//  FundDetailsViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 27.07.2022.
//

import UIKit

class FundDetailsViewController: UITableViewController {
    
    let typeOfFunds = TypeOfFunds.stock
    
    var funds: [Fund] {
        get {
            Fund.getAllFunds(of: typeOfFunds)
        }
        set {} //сделал чтобы не ругался что funds immutable
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = typeOfFunds.rawValue
        
        navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        funds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fundElement", for: indexPath)

        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()

        content.text = funds[indexPath.row].name
        content.image = UIImage(systemName: funds[indexPath.row].image)
        content.secondaryText = String(funds[indexPath.row].totalPrice)

        cell.contentConfiguration = content
        
        return cell
    }

//     Override to support editing the table view. - ПОЧЕМУ-ТО ПАДАЕТ ПРИ УДАЛЕНИИ
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            funds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData() // не помогло

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


}
