//
//  TestsViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 30.07.2022.
//

import UIKit

class TestsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerLabels: [UILabel]!
    
    @IBOutlet weak var firstAnswerCheckBox: UIButton!
    @IBOutlet weak var secondAnswerCheckBox: UIButton!
    @IBOutlet weak var thirdAnswerCheckBox: UIButton!
    @IBOutlet weak var fourthAnswerCheckBox: UIButton!
    
    @IBOutlet weak var answersStackView: UIStackView!
    @IBOutlet weak var resultBalanceLabel: UILabel!
    
    @IBOutlet weak var toTestsButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    @IBOutlet weak var promtStackView: UIStackView!
    
    private var questions: [Question]!
    private var answers: [(String, Int)] = []
    
    private var currentQuestion = -1
    private var investorProfileValue = 0
    var investingProfile: InvestingProfile!

    override func viewDidLoad() {
        super.viewDidLoad()
        questions = Question.getQuestions()
        setTitleLabel()
        resultBalanceLabel.isHidden = true
        okButton.isHidden = true
        answersStackView.isHidden = true
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        var indexOfAnswer: Int
        switch sender {
        case firstAnswerCheckBox:
            indexOfAnswer = 0
        case secondAnswerCheckBox:
            indexOfAnswer = 1
        case thirdAnswerCheckBox:
            indexOfAnswer = 2
        default:
            indexOfAnswer = 3
        }
        investorProfileValue += answers[indexOfAnswer].1
        currentQuestion += 1
        guard questions.count > currentQuestion
        else {
            investingProfile = InvestingProfile.setFromValue(
                investorProfileValue: investorProfileValue
            )
            hideView(withReload: false)
            showResult()
            return
        }
        hideView(withReload: true)
    }
    
    @IBAction func toTestTapped(_ sender: Any) {
        currentQuestion += 1
        UIView.animate(withDuration: 0.3) {
            self.toTestsButton.alpha = 0
            self.promtStackView.alpha = 0
            self.titleLabel.alpha = 0
            self.questionLabel.alpha = 0

        } completion: { _ in
            self.answersStackView.alpha = 0
            self.answersStackView.isHidden = false
            self.toTestsButton.isHidden = true
            self.toTestsButton.isHidden = true
            self.setTitleLabel()
            self.setQuestion(number: self.currentQuestion)
            
            
            UIView.animate(withDuration: 0.3) {
                self.titleLabel.alpha = 1
                self.questionLabel.alpha = 1
                self.answersStackView.alpha = 1
            }
        }
    }
    
    private func setTitleLabel() {
        if currentQuestion == -1 {
            titleLabel.text = "Инвест-профиль"
        } else {
            titleLabel.text = "Вопрос \(currentQuestion + 1) / \(questions.count)"
        }
    }
    
    private func hideView(withReload: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.titleLabel.alpha = 0
            self.questionLabel.alpha = 0
            self.answersStackView.alpha = 0
        } completion: { _ in
            
            if withReload {
                self.showView()
            }
        }
    }
    
    private func showView() {
        UIView.animate(withDuration: 0.3) {
            self.setQuestion(number: self.currentQuestion)
            self.setTitleLabel()
            self.titleLabel.alpha = 1
            self.questionLabel.alpha = 1
            self.answersStackView.alpha = 1
        }
    }
    
    private func setQuestion(number: Int) {
        let question = questions[number]
        answers = question.answers.sorted { $0.value < $1.value }
        guard answers.count == answerLabels.count else { return }
        questionLabel.text = question.question
        for i in answerLabels.indices {
            answerLabels[i].text = answers[i].0
        }
    }
    
    private func showResult() {
        okButton.alpha = 0
        okButton.isHidden = false
        resultBalanceLabel.alpha = 0
        resultBalanceLabel.isHidden = false
        resultBalanceLabel.text = """
Рекомендуемый баланс:
Акции: \(getTargetString(for: .stock))
Облигации: \(getTargetString(for: .bound))
Валюта: \(getTargetString(for: .cash))
Драг. металлы: \(getTargetString(for: .metall))
Криптовалюта: \(getTargetString(for: .cryptoCurrency))
"""
        UIView.animate(withDuration: 0.3, delay: 0.4) {
            self.titleLabel.text = "Ваш результат:"
            self.questionLabel.text = self.investingProfile.getDescription()
            self.titleLabel.alpha = 1
            self.questionLabel.alpha = 1
            self.resultBalanceLabel.alpha = 1
            self.okButton.alpha = 1
        }
        
    }
    
    private func getTargetString(for type:TypeOfFunds) -> String {
        let targetBalance = investingProfile.getTargetBalance()
        let lowerBound = (Int((targetBalance[type]?.lowerBound ?? 0) * 100))
        let upperBound = (Int((targetBalance[type]?.upperBound ?? 0) * 100))
        return "\(lowerBound)% - \(upperBound)%"
        
    }
}
