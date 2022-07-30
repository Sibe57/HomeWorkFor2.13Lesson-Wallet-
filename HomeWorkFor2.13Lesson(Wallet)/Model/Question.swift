//
//  Question.swift
//  HomeWorkFor2.13Lesson(Wallet)
//
//  Created by Федор Еронин on 30.07.2022.
//

import Foundation


struct Question {
    let question: String
    let answers: [String: Int]
    
    static func getQuestions() -> [Question] {
        var questions: [Question] = []
        
        let questionsCount = min(TestsDataStore.shared.questions.count,
                             TestsDataStore.shared.answers.count)
        
        for i in 0..<questionsCount {
            questions.append(Question(question: TestsDataStore.shared.questions[i],
                                       answers: TestsDataStore.shared.answers[i]))
        }
        
        return questions
    }
}

enum InvestingProfile {
    case agressive
    case middle
    case conservative
    
    static func setFromValue(investorProfileValue: Int) -> InvestingProfile {
        if investorProfileValue > 10 {
            return .agressive
        } else if investorProfileValue > 5 {
            return .middle
        } else {
            return .conservative
        }
    }
    
    func getTargetBalance() -> [TypeOfFunds: ClosedRange<Double>] {
        var targetBalance: [TypeOfFunds: ClosedRange<Double>] = [:]
        
        switch self {
        case .agressive:
            targetBalance[.stock] = 0.49...0.70
            targetBalance[.bound] = 0.0...0.15
            targetBalance[.cash] = 0.05...0.15
            targetBalance[.metall] = 0.05...0.10
            targetBalance[.cryptoCurrency] = 0.10...0.25
        case .middle:
            targetBalance[.stock] = 0.25...0.40
            targetBalance[.bound] = 0.25...0.40
            targetBalance[.cash] = 0.05...0.15
            targetBalance[.metall] = 0.05...0.15
            targetBalance[.cryptoCurrency] = 0.05...0.10
        case .conservative:
            targetBalance[.stock] = 0.05...0.20
            targetBalance[.bound] = 0.49...0.70
            targetBalance[.cash] = 0.05...0.15
            targetBalance[.metall] = 0.15...0.25
            targetBalance[.cryptoCurrency] = 0.0...0.5
        }
        
        return targetBalance
    }
}
