//
//  Subject.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation

struct Subject: Codable, Identifiable, Hashable {

    let id: String
    let title: String
    let description: String?
    let themeColor: String?

}
