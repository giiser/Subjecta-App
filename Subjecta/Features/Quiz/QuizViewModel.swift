//
//  QuizViewModel.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//

import Foundation
import Combine

@MainActor
class QuizViewModel: ObservableObject {

    @Published var quiz: Quiz?
    @Published var selectedAnswers: [String: Int] = [:]
    @Published var result: QuizResult?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = QuizService()
    private let lessonId: String

    init(lessonId: String) {
        self.lessonId = lessonId
    }

    func loadQuiz() async {

        isLoading = true

        do {

            quiz = try await service.getQuiz(lessonId: lessonId)
            
            print("QUIZ LOADED:", quiz?.questions.count ?? 0)

        } catch {

            print("QUIZ LOAD ERROR", error)

        }

        isLoading = false
    }

    func selectAnswer(questionId: String, answerIndex: Int) {
        selectedAnswers[questionId] = answerIndex
    }

    func submitQuiz() async {

        guard let quiz = quiz else { return }

        do {

            let submission = QuizSubmission(
                answers: selectedAnswers
            )

            result = try await service.submitQuiz(
                lessonId: quiz.lessonId,
                submission: submission
            )

        } catch {

            errorMessage = "Failed to submit quiz"

        }

    }
}
