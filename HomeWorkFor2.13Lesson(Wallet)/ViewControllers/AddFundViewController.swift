//
//  AddFundViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Ilya Kozhevnikov on 30.07.2022.
//

import UIKit

class AddFundViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var quantityTF: UITextField!
    @IBOutlet var priceTF: UITextField!
    
    @IBOutlet var currencySC: UISegmentedControl!
    
    var typeOfFund: TypeOfFunds!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Добавить \(typeOfFund.rawValue.lowercased())"
    }
    
    func getSelectedCurrency() -> Currency {
        switch currencySC.titleForSegment(at: currencySC.selectedSegmentIndex) {
        case "USD":
            return .usd
        case "RUR":
            return .rur
        case "CNY":
            return .cny
        case "EUR":
            return .eur
        default:
            return .jpy
        }
    }
    
    


}
