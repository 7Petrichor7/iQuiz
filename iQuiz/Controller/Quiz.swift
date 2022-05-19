//
//  Quiz.swift
//  iQuiz
//
//  Created by 🧊🧊 on 5/19/22.
//

import Foundation

struct Quiz: Codable {
    let title : String
    let desc : String
    let questions : [Question]
}
