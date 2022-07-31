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
    @IBOutlet var tickerTF: UITextField!
    @IBOutlet var quantityTF: UITextField!
    @IBOutlet var priceTF: UITextField!
    @IBOutlet var issuerTF: UITextField!
    @IBOutlet var yieldTF: UITextField!
    
    @IBOutlet var metallSC: UISegmentedControl!
    @IBOutlet var currencySC: UISegmentedControl!
    
    var typeOfFund: TypeOfFunds!
    let addedByUserIcon = "person.circle"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Добавить \(typeOfFund.rawValue.lowercased())"
        
        setupTFInput()
        showTextFieldsNeeded(for: typeOfFund)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    
    func setupTFInput() {
        quantityTF.keyboardType = .decimalPad
        priceTF.keyboardType = .decimalPad
        yieldTF.keyboardType = .decimalPad
    }
    
    func showTextFieldsNeeded(for typeOfFund: TypeOfFunds) {
        hideAllItems()
        
        switch typeOfFund {
        case .bound:
            nameTF.isHidden = false
            issuerTF.isHidden = false
            yieldTF.isHidden = false
            quantityTF.isHidden = false
            priceTF.isHidden = false
            currencySC.isHidden = false
            
        case .metall:
            metallSC.isHidden = false
            priceTF.isHidden = false
            quantityTF.isHidden = false
            
        case .stock:
            nameTF.isHidden = false
            issuerTF.isHidden = false
            quantityTF.isHidden = false
            priceTF.isHidden = false
            currencySC.isHidden = false
        
        case .cryptoCurrency:
            nameTF.isHidden = false
            priceTF.isHidden = false
            quantityTF.isHidden = false
            tickerTF.isHidden = false
            
        default: //cash
            quantityTF.isHidden = false
            currencySC.isHidden = false
        }
    }
    
    func hideAllItems() {
        metallSC.isHidden = true

        nameTF.isHidden = true
        tickerTF.isHidden = true
        issuerTF.isHidden = true
        yieldTF.isHidden = true
        quantityTF.isHidden = true
        priceTF.isHidden = true
        
        currencySC.isHidden = true
        
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
    
    func getSelectedMetall() -> TypeOfMetall {
        switch metallSC.titleForSegment(at: metallSC.selectedSegmentIndex) {
        case "Gold":
            return .gold
        case "Silver":
            return .silver
        default:
            return .palladium
        }
    }
    
    func checkCorrectInputNumber(for textFields: UITextField...) -> Bool {
        for textField in textFields {
            if !textField.isHidden {
                if Double(textField.text ?? "") ?? -1 < 0 {
                    showIncorrectNumber(textField: textField)
                    return false
                }
            }
        }
        return true
    }
    
    func checkCorrectInputString(for textFields: UITextField...) -> Bool {
        for textField in textFields {
            if !textField.isHidden {
                if textField.text?.isEmpty ?? false {
                    showEmptyTextFieldWarning(textField: textField)
                    return false
                }
            }
        }
        return true
    }

    
    func showIncorrectNumber(textField: UITextField) {
        let incorrectAlert = UIAlertController(
            title: "Некорректное значение",
            message: "Введите корректное значение для поля '\(textField.placeholder ?? "поля")': число от 0 и больше",
            preferredStyle: .alert
        )
        
        let alertButton = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in
                textField.text?.removeAll()
            }
        )
        
        incorrectAlert.addAction(alertButton)
        
        present(incorrectAlert, animated: true)
    }
    
    func showEmptyTextFieldWarning(textField: UITextField) {
        let incorrectAlert = UIAlertController(
            title: "Введите '\(textField.placeholder ?? "значение")'",
            message: "Введите '\(textField.placeholder ?? "значение")'",
            preferredStyle: .alert
        )
        
        let alertButton = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        
        incorrectAlert.addAction(alertButton)
        
        present(incorrectAlert, animated: true)
    }
//    проверка корректности ввода в текстовые поля с цифрами
//    проверка названия акции - нет ли уже такого

    
    @IBAction func addFundButtonPressed() {
        guard checkCorrectInputString(for: nameTF, tickerTF, issuerTF) else { return }
        guard checkCorrectInputNumber(for: yieldTF, quantityTF, priceTF) else { return }
        
        switch typeOfFund {
        case .stock:
            MockFundsContainer.shared.userFunds[.stock]?.append(
                Stock(
                    image: addedByUserIcon,
                    name: nameTF.text ?? "",
                    currency: getSelectedCurrency(),
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(quantityTF.text ?? "") ?? 0,
                    issuer: issuerTF.text ?? ""
                )
            )
        case .bound:
            MockFundsContainer.shared.userFunds[.bound]?.append(
                Bond(
                    image: addedByUserIcon,
                    name: nameTF.text ?? "",
                    currency: getSelectedCurrency(),
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(quantityTF.text ?? "") ?? 0,
                    issuer: issuerTF.text ?? "",
                    yield: Double(yieldTF.text ?? "") ?? 0
                )
            )
        case .metall:
            MockFundsContainer.shared.userFunds[.metall]?.append(
                Metall(
                    typeOfMetall: getSelectedMetall(),
                    image: addedByUserIcon,
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(quantityTF.text ?? "") ?? 0
                )
            )
        case .cryptoCurrency:
            MockFundsContainer.shared.userFunds[.cryptoCurrency]?.append(
                CryptoCurrency(
                    image: addedByUserIcon,
                    name: nameTF.text ?? "",
                    price: Double(priceTF.text ?? "") ?? 0,
                    quantity: Double(quantityTF.text ?? "") ?? 0,
                    ticker: tickerTF.text ?? ""
                )
            )
        default:
            MockFundsContainer.shared.userFunds[.cash]?.append(
                Cash(
                    image: addedByUserIcon,
                    currency: getSelectedCurrency(),
                    quantity: Double(quantityTF.text ?? "") ?? 0
                )
            )
        }
        
        performSegue(withIdentifier: "manualUnwind", sender: nil)

    }
    
    
    
    
}
