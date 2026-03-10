//
//  QuizView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//

import Foundation
import SwiftUI

struct QuizView: View {

    @StateObject private var viewModel: QuizViewModel

    init(lessonId: String) {

        _viewModel = StateObject(
            wrappedValue: QuizViewModel(lessonId: lessonId)
        )

    }

    var body: some View {

        ScrollView {

            if viewModel.isLoading {

                ProgressView()

            } else if let quiz = viewModel.quiz {

                VStack(alignment: .leading, spacing: 24) {

                    ForEach(quiz.questions) { question in

                        questionView(question)

                    }

                    submitButton

                }
                .padding()

            }

        }
        .navigationTitle("Quiz")
        .task {

            await viewModel.loadQuiz()

        }
    }

    private func questionView(_ question: QuizQuestion) -> some View {

        VStack(alignment: .leading, spacing: 12) {
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Text(question.text)
                .font(.headline)

            ForEach(Array(question.options.enumerated()), id: \.offset) { index, option in

                Button {

                    viewModel.selectAnswer(
                        questionId: question.id,
                        answerIndex: index
                    )

                } label: {

                    HStack {

                        Text(option)

                        Spacer()

                        if viewModel.selectedAnswers[question.id] == index {

                            Image(systemName: "checkmark.circle.fill")

                        }

                    }

                }

            }

        }
    }
    private var submitButton: some View {

        Button {

            Task {

                await viewModel.submitQuiz()

            }

        } label: {

            Text("Submit Quiz")
                .frame(maxWidth: .infinity)

        }
        .buttonStyle(.borderedProminent)

    }
}
