import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {

    @Published var username = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = AuthService()

    func login() async -> Bool {

        isLoading = true
        errorMessage = nil

        do {

            let response = try await service.login(
                username: username,
                password: password
            )

            AuthStore.shared.saveTokens(
                access: response.accessToken,
                refresh: response.refreshToken
            )

            isLoading = false
            return true

        } catch {

            errorMessage = "Login failed"
            isLoading = false
            return false

        }

    }

}
