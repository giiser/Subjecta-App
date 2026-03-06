//
//  AuthEndpoint.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//
import Foundation

enum AuthEndpoint: Endpoint {

    case login(LoginRequest)
    case refresh(String)

    var path: String {

        switch self {
        case .login:
            return "auth/login"

        case .refresh:
            return "auth/refresh"
        }

    }

    var method: HTTPMethod {
        .POST
    }

    var body: Data? {

        switch self {

        case .login(let request):
            return try? JSONEncoder().encode(request)

        case .refresh(let token):

            let request = ["refreshToken": token]
            return try? JSONSerialization.data(withJSONObject: request)

        }

    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }

}
