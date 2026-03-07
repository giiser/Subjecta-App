//
//  Lesson.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation

struct Lesson: Codable, Identifiable, Hashable {

    let id: String
    let topicId: String
    let title: String
    let summary: String?
    let content: String?
    let order: Int?

}
