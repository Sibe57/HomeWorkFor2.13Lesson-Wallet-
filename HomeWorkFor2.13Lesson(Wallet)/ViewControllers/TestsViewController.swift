//
//  TestsViewController.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 30.07.2022.
//

import UIKit

class TestsViewController: UIViewController {
    
    @IBOutlet weak var qustionCounter: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerLabels: [UILabel]!
    
    
    @IBOutlet weak var firstAnswerCheckBox: UIButton!
    @IBOutlet weak var secondAnswerCheckBox: UIButton!
    @IBOutlet weak var thirdAnswerCheckBox: UIButton!
    @IBOutlet weak var fourthAnswerCheckBox: UIButton!
    
    private var questions: [Question]!
    private var answers: [(String, Int)] = []
    
    @IBOutlet weak var resultLabel: UILabel!
    private var currentQuestion = 0
    private var investorProfileValue = 0
    private var investingProfile: InvestingProfile!

    override func viewDidLoad() {
        super.viewDidLoad()
        questions = Question.getQuestions()
        setQuestion(number: currentQuestion)
        setQustionCounter()
        resultLabel.isHidden = true
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
        print("MEMEM" + String(investorProfileValue))
        guard questions.count > currentQuestion
        else {
            investingProfile = InvestingProfile.setFromValue(investorProfileValue: investorProfileValue)
            resultLabel.text = investingProfile.getDescription()
            resultLabel.isHidden = false
            hideView(withReload: false)
            return
        }
        hideView(withReload: true)
        
    }
    
    private func setQustionCounter() {
        qustionCounter.text = "Вопрос \(currentQuestion + 1) / \(questions.count)"
    }
    
    private func hideView(withReload: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.qustionCounter.alpha = 0
            self.questionLabel.alpha = 0
            for label in self.answerLabels {
                label.alpha = 0
            }
            self.firstAnswerCheckBox.alpha = 0
            self.secondAnswerCheckBox.alpha = 0
            self.thirdAnswerCheckBox.alpha = 0
            self.fourthAnswerCheckBox.alpha = 0
        } completion: { _ in
            
            if withReload {
                self.showView()
            }
            
        }
    }
    
    private func showView() {
        UIView.animate(withDuration: 0.2) {
            self.setQuestion(number: self.currentQuestion)
            self.setQustionCounter()
            self.qustionCounter.alpha = 1
            self.questionLabel.alpha = 1
            for label in self.answerLabels {
                label.alpha = 1
            }
            self.firstAnswerCheckBox.alpha = 1
            self.secondAnswerCheckBox.alpha = 1
            self.thirdAnswerCheckBox.alpha = 1
            self.fourthAnswerCheckBox.alpha = 1
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
    

    
    
    


}
