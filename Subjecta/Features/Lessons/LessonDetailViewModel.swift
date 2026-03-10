//
//  LessonDetailViewModel.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 07.03.2026.
//

import Foundation
import Combine

@MainActor
class LessonDetailViewModel: ObservableObject {

    @Published var lessonDetail: LessonDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let lessonId: String
    private let service = LessonsService()

    init(lessonId: String) {
        self.lessonId = lessonId
    }

    func loadLesson() async {

        print("LOADING LESSON:", lessonId)

        isLoading = true
        errorMessage = nil

        do {

            lessonDetail = try await service.getLessonDetail(
                lessonId: lessonId
            )

            print("LESSON LOADED:", lessonDetail?.lesson.title ?? "nil")

        } catch {

            print("LESSON ERROR:", error)
            errorMessage = "Failed to load lesson"

        }

        isLoading = false
    }
}
