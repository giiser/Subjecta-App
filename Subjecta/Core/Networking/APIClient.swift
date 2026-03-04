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

        let url = NetworkConfiguration
            .baseURL
            .appendingPathComponent(endpoint.path)

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        endpoint.headers.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        switch httpResponse.statusCode {

        case 200...299:
            return try JSONDecoder().decode(T.self, from: data)

        case 401:
            throw APIError.unauthorized

        case 500...599:
            throw APIError.serverError(httpResponse.statusCode)

        default:
            throw APIError.invalidResponse
        }
    }
}
