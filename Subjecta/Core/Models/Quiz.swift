//
//  Quiz.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//

import Foundation

struct Quiz: Codable {

    let lessonId: String
    let questions: [QuizQuestion]

}

struct QuizQuestion: Codable, Identifiable {

    let id: String
    let text: String
    let options: [String]

}

struct QuizOption: Codable, Identifiable {

    let id: String
    let text: String

}

struct QuizAnswer: Codable {

    let questionId: String
    let selectedOptionId: String

}

struct QuizSubmission: Codable {
    let answers: [String: Int]
}

struct QuizResult: Codable {

    let score: Int
    let passed: Bool

}
