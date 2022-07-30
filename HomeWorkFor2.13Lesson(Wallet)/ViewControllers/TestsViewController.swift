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
    
    private var currentQuestion = 0
    private var investorProfileValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        questions = Question.getQuestions()
        setQuestion(number: 2)
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
            self.dismiss(animated: true)
            return
        }
        
    }
    
    
    


}
