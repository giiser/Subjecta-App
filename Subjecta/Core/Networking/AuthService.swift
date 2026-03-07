import Foundation

class AuthService {

    func login(username: String, password: String) async throws -> LoginResponse {

        let request = LoginRequest(
            username: username,
            password: password
        )

        return try await APIClient.shared.request(
            AuthEndpoint.login(request)
        )
    }

    func refreshToken(_ refreshToken: String) async throws -> LoginResponse {

        return try await APIClient.shared.request(
            AuthEndpoint.refresh(refreshToken)
        )
    }
}
