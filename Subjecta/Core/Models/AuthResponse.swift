//
//  AuthResponse.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 07.03.2026.
//

import Foundation

struct AuthResponse: Codable {

    let accessToken: String
    let refreshToken: String

}
