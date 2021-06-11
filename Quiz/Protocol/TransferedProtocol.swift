//
//  TransferedProtocol.swift
//  Quiz
//
//  Created by Евгений Петренко on 11.06.2021.
//

import Foundation

protocol TransferedProtocol {
    func getData() -> (questions: [Question]?, userAnswers: [Int]?)
    func newGameStarted()
}
