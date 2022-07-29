//
//  FundDetailsViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 27.07.2022.
//

import UIKit

class FundDetailsViewController: UITableViewController {
    
    var typeOfFunds = TypeOfFunds.stock
    
    var funds: [Fund] {
        Fund.getAllFunds(of: typeOfFunds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = typeOfFunds.rawValue

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        funds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fundElement", for: indexPath) as? FundDetailsTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none
        
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
//        cell.setSumLabel(
//            with: funds[indexPath.row].totalPrice,
//            in: funds[indexPath.row].currency
//        )
//
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
