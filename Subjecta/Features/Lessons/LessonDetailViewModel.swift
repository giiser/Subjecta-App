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

    private let service = LessonsService()

    func loadLesson(id: String) async {

        isLoading = true

        do {

            lessonDetail = try await service.getLessonDetail(lessonId: id)

        } catch {

            errorMessage = "Failed to load lesson"

        }

        isLoading = false
    }

}
