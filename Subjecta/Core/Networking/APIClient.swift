//
//  APIClient.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import Foundation

final class APIClient {

    static let shared = APIClient()

    private init() {}

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {

        do {
            return try await performRequest(endpoint)

        } catch APIError.unauthorized {

            try await refreshToken()

            return try await performRequest(endpoint)
        }
    }
    
    private func performRequest<T: Decodable>(_ endpoint: Endpoint) async throws -> T {

        let url = NetworkConfiguration
            .baseURL
            .appendingPathComponent(endpoint.path)

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        endpoint.headers.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }

        if let token = TokenManager.shared.getAccessToken() {

            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        if http.statusCode == 401 {
            throw APIError.unauthorized
        }

        if http.statusCode >= 400 {

            if let errorResponse = try? JSONDecoder().decode(ApiErrorResponse.self, from: data) {

                print("SERVER ERROR:", errorResponse.message)

            } else {

                print("SERVER ERROR RAW:", String(data: data, encoding: .utf8) ?? "")
            }

            throw APIError.serverError(http.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private func refreshToken() async throws {

        let authService = AuthService()
        _ = try await authService.refreshToken()

    }
}
