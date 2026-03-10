//
//  QuizService.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//

import Foundation

class QuizService {

    func getQuiz(lessonId: String) async throws -> Quiz {

        try await APIClient.shared.request(
            QuizEndpoint.getQuiz(lessonId: lessonId)
        )

    }

    func submitQuiz(
        lessonId: String,
        submission: QuizSubmission
    ) async throws -> QuizResult {

        try await APIClient.shared.request(
            QuizEndpoint.submitQuiz(
                lessonId: lessonId,
                submission: submission
            )
        )

    }

}
