//
//  QuizView.swift
//  Subjecta
//

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

            } else if let result = viewModel.result {

                resultView(result)

            } else if let quiz = viewModel.quiz {

                quizContent(quiz)

            }

        }
        .navigationTitle("Quiz")
        .task {
            await viewModel.loadQuiz()
        }
    }

    // MARK: Quiz Content

    private func quizContent(_ quiz: Quiz) -> some View {

        VStack(alignment: .leading, spacing: 24) {

            if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)

            }

            ForEach(quiz.questions) { question in

                questionView(question)

            }

            submitButton

        }
        .padding()
    }

    // MARK: Question View

    private func questionView(_ question: QuizQuestion) -> some View {

        VStack(alignment: .leading, spacing: 12) {

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
                                .foregroundColor(.green)

                        }

                    }

                }
                .buttonStyle(.plain)

            }

        }
    }

    // MARK: Submit Button

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

    // MARK: Result Screen

    private func resultView(_ result: QuizResult) -> some View {

        VStack(spacing: 20) {

            Text("Quiz Result")
                .font(.title2)
                .fontWeight(.bold)

            Text("Score: \(result.scoreText)")
                .font(.title3)

            Text("\(Int(result.percentage))%")
                .font(.headline)

            if result.passed {

                Text("Lesson completed 🎉")
                    .foregroundColor(.green)

            } else {

                Text("Try again")
                    .foregroundColor(.orange)

            }

        }
        .padding()

    }

}
