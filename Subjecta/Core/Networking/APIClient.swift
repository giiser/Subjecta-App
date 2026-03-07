//
//  APIClient.swift
//  Subjecta
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

        var components = URLComponents(
            url: NetworkConfiguration.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )!

        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        print("REQUEST URL:", url)
        
        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        endpoint.headers.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }

        // Attach access token automatically
        if let token = AuthStore.shared.accessToken() {

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

            print("STATUS CODE:", http.statusCode)
            print("RAW RESPONSE:", String(data: data, encoding: .utf8) ?? "nil")

            throw APIError.serverError(http.statusCode)
        }

//        return try JSONDecoder().decode(T.self, from: data)
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("DECODING ERROR:", error)
            print("RAW JSON:", String(data: data, encoding: .utf8) ?? "")
            throw error
        }
    }

    private func refreshToken() async throws {

        guard let refreshToken = AuthStore.shared.refreshToken() else {
            throw APIError.unauthorized
        }

        let authService = AuthService()

        let response = try await authService.refreshToken(refreshToken)

        AuthStore.shared.saveTokens(
            access: response.accessToken,
            refresh: response.refreshToken
        )
    }
}
