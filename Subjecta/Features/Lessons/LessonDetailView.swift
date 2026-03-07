//
//  LessonDetailView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 07.03.2026.
//

import SwiftUI

struct LessonDetailView: View {

    let lessonId: String

    @StateObject private var viewModel = LessonDetailViewModel()

    var body: some View {

        ScrollView {

            if viewModel.isLoading {

                ProgressView()

            } else if let error = viewModel.errorMessage {

                Text(error)

            } else if let detail = viewModel.lessonDetail {

                if detail.locked {

                    VStack(spacing: 16) {

                        Image(systemName: "lock.fill")
                            .font(.largeTitle)

                        Text("Complete the previous lesson to unlock this one")

                    }

                } else {

                    VStack(alignment: .leading, spacing: 20) {

                        Text(detail.lesson.title)
                            .font(.title)
                            .fontWeight(.bold)

                        if let content = detail.lesson.content {

                            Text(content)

                        }

                    }
                    .padding()

                }

            }

        }
        .navigationTitle("Lesson")
        .task {

            await viewModel.loadLesson(id: lessonId)

        }

    }

}
