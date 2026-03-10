//
//  Route.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation

enum Route: Hashable {

    case topics(Subject)
    case lessons(Topic)
    case lesson(String)
    case quiz(String)
}
