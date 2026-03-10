//
//  LessonDetailView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 07.03.2026.
//

import SwiftUI

struct LessonDetailView: View {

    @StateObject private var viewModel: LessonDetailViewModel
    @EnvironmentObject var router: Router


    init(lessonId: String) {
        _viewModel = StateObject(
            wrappedValue: LessonDetailViewModel(lessonId: lessonId)
        )
    }

    var body: some View {

        Group {

            if let detail = viewModel.lessonDetail {

                lessonContent(detail)

            } else if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)

            } else {

                ProgressView()

            }
        }
        .navigationTitle("Lesson")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadLesson()
        }
    }

    private func lessonContent(_ detail: LessonDetail) -> some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 20) {

                Text(detail.lesson.title)
                    .font(.title2)
                    .fontWeight(.bold)

                if let summary = detail.lesson.summary {

                    Text(summary)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                }

                Divider()

                if detail.locked {

                    lockedView()

                } else {

                    lessonText(detail.lesson)

                }
                

            }
            .padding()

        }
        .safeAreaInset(edge: .bottom) {

            Button {

                router.navigateToQuiz(lessonId: detail.lesson.id)

            } label: {

                Text("Start Quiz")
                    .frame(maxWidth: .infinity)

            }
            .buttonStyle(.borderedProminent)
            .padding()

        }
    }

    private func lockedView() -> some View {

        VStack(spacing: 12) {

            Image(systemName: "lock.fill")
                .font(.largeTitle)

            Text("Complete the previous quiz to unlock this lesson")
                .multilineTextAlignment(.center)

        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }

    @ViewBuilder
    private func lessonText(_ lesson: Lesson) -> some View {

        if let document = RichTextParser.parse(lesson.content) {

            RichTextView(document: document)

        } else {

            Text("Lesson content unavailable")
                .foregroundColor(.secondary)

        }

    }
}
