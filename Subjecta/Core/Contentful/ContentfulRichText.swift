//
//  ContentfulRichText.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 10.03.2026.
//

import Foundation

struct RichTextDocument: Codable {

    let nodeType: String
    let content: [RichNode]

}

struct RichNode: Codable {

    let nodeType: String
    let content: [RichNode]?
    let value: String?
    let marks: [RichMark]?
    let data: RichData?

}

struct RichMark: Codable {

    let type: String

}

struct RichData: Codable {

    let uri: String?

}
