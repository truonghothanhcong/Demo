//
//  Lession.swift
//  EnglishHub
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import Foundation

class Lession {
    var name: String
    var sound: String
    var sentencesArray: [String]
    var questionArray: [Questionaire]?
    
    init(name: String, sound: String, sentencesArray: [String]) {
        self.name = name
        self.sound = sound
        self.sentencesArray = sentencesArray
        self.questionArray = nil
    }
}
