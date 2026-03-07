//
//  TopicsService.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation

class TopicsService {

    func getTopics(subjectId: String) async throws -> [Topic] {

        try await APIClient.shared.request(
            TopicsEndpoint.topicsBySubject(subjectId)
        )

    }

}
