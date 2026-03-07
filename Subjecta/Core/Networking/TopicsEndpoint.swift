//
//  TopicsEndpoint.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation

enum TopicsEndpoint: Endpoint {

    case topicsBySubject(String)

    var path: String {

        switch self {

        case .topicsBySubject(let subjectId):
            return "subjects/\(subjectId)/topics"

        }

    }

    var method: HTTPMethod {
        .GET
    }

    var body: Data? {
        nil
    }

    var headers: [String : String] {
        [:]
    }
}
