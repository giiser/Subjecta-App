//
//  AuthService.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation

class AuthService {

    func login(username: String, password: String) async throws -> LoginResponse {

        let endpoint = AuthEndpoint.login(
            LoginRequest(username: username, password: password)
        )

        return try await APIClient.shared.request(endpoint)
    }
    
    func refreshToken() async throws -> LoginResponse {

        guard let refreshToken = TokenManager.shared.getRefreshToken() else {
            throw APIError.unauthorized
        }

        let endpoint = AuthEndpoint.refresh(refreshToken)

        let response: LoginResponse = try await APIClient.shared.request(endpoint)

        TokenManager.shared.save(
            accessToken: response.accessToken,
            refreshToken: response.refreshToken
        )

        return response
    }

}
