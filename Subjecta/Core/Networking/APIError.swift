//
//  APIError.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import Foundation

enum APIError: Error {

    case invalidURL
    case invalidResponse
    case decodingError
    case unauthorized
    case serverError(Int)
    case unknown(Error)

}
