//
//  LessonsService.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation

class LessonsService {

    func getLessons(topicId: String) async throws -> [LessonWithAccess] {

        try await APIClient.shared.request(
            LessonsEndpoint.lessonsByTopic(topicId)
        )

    }

    func getLessonDetail(lessonId: String) async throws -> LessonDetail {

        print("LOAD LESSON DETAIL:", lessonId)

        return try await APIClient.shared.request(
            LessonsEndpoint.lessonDetail(lessonId)
        )
    }
}
