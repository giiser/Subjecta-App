//
//  SubjectsEndpoint.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation

enum SubjectsEndpoint: Endpoint {

    case getSubjects

    var path: String {

        switch self {
        case .getSubjects:
            return "subjects"
        }
    }

    var method: HTTPMethod {
        .GET
    }

    var body: Data? {
        nil
    }

    var headers: [String: String] {
        [:]
    }

}
