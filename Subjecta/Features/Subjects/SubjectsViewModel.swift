//
//  SubjectsViewModel.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation
import Combine

@MainActor
class SubjectsViewModel: ObservableObject {

    @Published var subjects: [Subject] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = SubjectsService()

    func loadSubjects() async {

        isLoading = true
        errorMessage = nil

        do {

            subjects = try await service.getSubjects()

        } catch {

            errorMessage = "Failed to load subjects"
        }

        isLoading = false
    }
}
