//
//  RichTextParser.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//

import Foundation

struct RichTextParser {

    static func parse(_ raw: String?) -> RichTextDocument? {

        guard let raw else { return nil }

        guard let data = raw.data(using: .utf8) else {
            return nil
        }

        return try? JSONDecoder().decode(RichTextDocument.self, from: data)
    }

}
