//
//  LessonsViewModel.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation
import Combine

@MainActor
class LessonsViewModel: ObservableObject {

    @Published var lessons: [LessonWithAccess] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = LessonsService()

    func loadLessons(topicId: String) async {
        
        print("LOAD LESSONS FOR TOPIC:", topicId)
        isLoading = true
        errorMessage = nil

        do {

            lessons = try await service.getLessons(topicId: topicId)

        } catch {

            errorMessage = "Failed to load lessons"
        }

        isLoading = false
    }

}
