//
//  QuizEndpoint.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//
import Foundation

enum QuizEndpoint: Endpoint {

    case getQuiz(lessonId: String)
    case submitQuiz(lessonId: String, submission: QuizSubmission)

    var path: String {

        switch self {

        case .getQuiz(let lessonId):
            return "/quizzes/\(lessonId)"

        case .submitQuiz(let lessonId, _):
            return "/quizzes/\(lessonId)/submit"

        }

    }

    var method: HTTPMethod {

        switch self {

        case .getQuiz:
            return .GET

        case .submitQuiz:
            return .POST

        }

    }

    var headers: [String : String] {

        [
            "Content-Type": "application/json"
        ]

    }

    var body: Data? {

        switch self {

        case .getQuiz:
            return nil

        case .submitQuiz(_, let submission):

            return try? JSONEncoder().encode(submission)

        }

    }

}
