//
//  TopicsViewModel.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation
import Combine

@MainActor
class TopicsViewModel: ObservableObject {

    @Published var topics: [Topic] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = TopicsService()

    func loadTopics(subjectId: String) async {

        isLoading = true
        errorMessage = nil

        do {

            topics = try await service.getTopics(subjectId: subjectId)

        } catch {

            errorMessage = "Failed to load topics"
        }

        isLoading = false
    }

}
