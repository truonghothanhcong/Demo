//
//  Questionaire.swift
//  EnglishHub
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import Foundation

class Questionaire {
    var question: String
    var answer: [String]?
    var trueAnswer: Int
    
    init(question: String, trueAnswer: Int) {
        self.question = question
        self.trueAnswer = trueAnswer
        self.answer = nil
    }
}