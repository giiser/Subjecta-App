//
//  ApiErrorResponse.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 06.03.2026.
//

import Foundation

struct ApiErrorResponse: Codable {

    let status: Int
    let error: String
    let message: String
    let timestamp: String

}
