//
//  Question.swift
//  Quiz
//
//  Created by Евгений Петренко on 10.06.2021.
//

import UIKit

struct Question : Codable {
    private (set) var question: String
    private (set) var answers: Dictionary<String, String>
  
}
