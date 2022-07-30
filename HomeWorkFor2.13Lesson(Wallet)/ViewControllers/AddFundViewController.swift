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
    
//    проверка корректности ввода в текстовые поля с цифрами
//    проверка названия акции - нет ли уже такого

    
    @IBAction func addFundButtonPressed() {
        switch typeOfFund {
        case .stock:
            MockFundsContainer.shared.userFunds[.stock]?.append(
                Stock(
                    image: "person.circle",
                    name: nameTF.text ?? "",
                    currency: getSelectedCurrency(),
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(priceTF.text ?? "") ?? 0,
                    issuer: "Added by user"
                )
            )
        case .bound:
            MockFundsContainer.shared.userFunds[.bound]?.append(
                Bond(
                    image: "person.circle",
                    name: nameTF.text ?? "",
                    currency: getSelectedCurrency(),
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(priceTF.text ?? "") ?? 0,
                    issuer: "Added by user",
                    yield: 0
                )
            )
        case .metall:
            MockFundsContainer.shared.userFunds[.metall]?.append(
                Metall(
                    typeOfMetall: .gold, //надо как-то выбирать металл вместо валюты
                    image: "person.circle",
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(quantityTF.text ?? "") ?? 0
                )
            )
        case .cryptoCurrency:
            MockFundsContainer.shared.userFunds[.cryptoCurrency]?.append(
                CryptoCurrency(
                    image: "person.circle",
                    name: nameTF.text ?? "",
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(priceTF.text ?? "") ?? 0,
                    ticker: nameTF.text ?? "" //как-то надо достать тикер
                )
            )
        default:
            MockFundsContainer.shared.userFunds[.cash]?.append(
                Cash(
                    image: "person.circle",
                    currency: getSelectedCurrency(),
                    quantity: Double(priceTF.text ?? "") ?? 0 // кэш надо как-то по-другому добавлять
                )
            )
        }
    }
    
    
    
    
}
