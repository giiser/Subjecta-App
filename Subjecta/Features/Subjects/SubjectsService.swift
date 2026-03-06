//
//  SubjectsService.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation

class SubjectsService {

    func getSubjects() async throws -> [Subject] {

        try await APIClient.shared.request(
            SubjectsEndpoint.getSubjects
        )

    }

}
