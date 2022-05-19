//
//  Question.swift
//  iQuiz
//
//  Created by 🧊🧊 on 5/15/22.
//

import Foundation

struct Question: Codable {
    let text: String
    let answer: String
    let answers: [String]
}
