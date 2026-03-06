//
//  AuthModels.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation

struct LoginRequest: Codable {

    let username: String
    let password: String

}

struct LoginResponse: Codable {

    let accessToken: String
    let refreshToken: String

}
