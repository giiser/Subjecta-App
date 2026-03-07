//
//  LessonWithAccess.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 07.03.2026.
//

import Foundation

struct LessonWithAccess: Codable, Identifiable {

    let lesson: Lesson
    let locked: Bool

    var id: String {
        lesson.id
    }

}
