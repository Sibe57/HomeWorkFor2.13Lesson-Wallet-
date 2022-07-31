//
//  FundsOverviewViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 28.07.2022.
//

import UIKit

class FundsOverviewViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pieChartImage: UIImageView!
    @IBOutlet weak var toTestsImage: UIImageView!
    
    @IBOutlet weak var investingProfileLabel: UILabel!
    private var investingProfile: InvestingProfile?
    
    private var histogrammShowing = false
    private var currencyForShowing: Currency = .rur
    
    private var costOfTypeOfFunds: [(TypeOfFunds, Double)]!
    private let refToDb = MockFundsContainer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backItem?.title = "Мои Активы"
        setInvestingProfileLabel()
        setGistogrammImage()
        setToTestsImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFundsType()
        tableView.reloadData()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? FundDetailsViewController
        else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        detailVC.typeOfFunds = costOfTypeOfFunds[index.row].0
    }
    
    private func setInvestingProfileLabel() {
        switch investingProfile {
        case .agressive:
            investingProfileLabel.textColor = UIColor(named: "MainColor")
            investingProfileLabel.text = "Цель - Агрессивный"
        case .middle:
            investingProfileLabel.textColor = UIColor(named: "MainColor")
            investingProfileLabel.text = "Цель - Сбалансированный"
        case .conservative:
            investingProfileLabel.textColor = UIColor(named: "MainColor")
            investingProfileLabel.text = "Цель - Консервативный"
        case .none:
            investingProfileLabel.textColor = .secondaryLabel
            investingProfileLabel.text = "Узнать инвест-профиль:"
        }
    }
    
    private func setGistogrammImage() {
        let pieChartTapped = UITapGestureRecognizer(target: self,
                                             action: #selector(showGistogramm))
        
        
        pieChartImage.isUserInteractionEnabled = true
        pieChartImage.addGestureRecognizer(pieChartTapped)
    }
    
    private func setToTestsImage() {
        let toTestsTapped = UITapGestureRecognizer(target: self,
                                                   action: #selector(openTests))
        toTestsImage.isUserInteractionEnabled = true
        toTestsImage.addGestureRecognizer(toTestsTapped)
    }
    
    @objc private func openTests() {
        toTestsImage.transform = CGAffineTransform(rotationAngle: 0.3)
        
        UIImageView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0) {
            self.toTestsImage.transform = .identity
        }
        
        performSegue(withIdentifier: "toTests", sender: nil)
    }
    
    @objc private func showGistogramm() {
        pieChartImage.transform = CGAffineTransform(rotationAngle: Double.pi)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.45,
                       initialSpringVelocity: 5, options: .curveEaseOut) {
            self.pieChartImage.transform = CGAffineTransform(rotationAngle: Double.pi)
            self.pieChartImage.transform = .identity
            self.pieChartImage.image = self.histogrammShowing
            ? UIImage(systemName: "chart.pie")
            : UIImage(systemName: "chart.pie.fill")
        }
        
        tableView.reloadData()
        histogrammShowing.toggle()
    }
    
    private func setupFundsType() {
        costOfTypeOfFunds = []
        for (fundsType, _) in refToDb.userFunds {
            costOfTypeOfFunds.append((fundsType,
                                      refToDb.getTotalPrice(ofType: fundsType,
                                                            in: currencyForShowing)))
        }
        costOfTypeOfFunds.sort { $0.0 < $1.0 }
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let testVC = segue.source as? TestsViewController else { return }
        investingProfile = testVC.investingProfile
        setInvestingProfileLabel()
        tableView.reloadData()
    }
}


extension FundsOverviewViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
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
            
            cell.fundsTypeLabel.text = fundsInfo.0.rawValue
            cell.totalCostLabel.text = Converter.getText(from: fundsInfo.1,
                                                         with: currencyForShowing)
            
            let percentage = fundsInfo.1 / refToDb.getTotalPrice(in: currencyForShowing)
            cell.fundsPercent.text = String(format: "%.1f", percentage * 100) + "%"
            
            if histogrammShowing {
                cell.setProgressView(on: percentage)
            }
            
            var recomendation: Recomendation? = nil
            let targetBalance = investingProfile?.getTargetBalance()[fundsInfo.0]
            if let targetBalance = targetBalance {
                print(102938)
                if targetBalance.contains(percentage) {
                    recomendation = .perfect
                } else if percentage < targetBalance.lowerBound {
                    recomendation = .lessThan
                } else {
                    recomendation = .moreThan
                }
            }
            
            cell.setRecomendationCircle(recomendation: recomendation)
            cell.selectionStyle = .none
            cell.setNeedsUpdateConfiguration()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "FundsOverviewHeader",
                for: indexPath
            ) as? HeaderFundsTypeTableViewCell else { return UITableViewCell() }
            
            cell.setCurrencyLabel(to: self.currencyForShowing)
            
            cell.totalValueLabel.text = Converter.getText(
                from: self.refToDb.getTotalPrice(in: currencyForShowing),
                with: self.currencyForShowing)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
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
        } else {
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            
            UIView.animate(withDuration: 0.1,delay: 0, options:[.curveEaseOut]) {
                cell.transform = cell.transform.scaledBy(x: 0.9, y: 0.90)
            } completion: {_ in
                UIView.animate(withDuration: 0.1) {
                    cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        }
    }
}
