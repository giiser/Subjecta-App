//
//  Topic.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation

struct Topic: Codable, Identifiable, Hashable {

    let id: String
    let subjectId: String
    let title: String
    let description: String?

}
