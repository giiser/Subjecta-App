//
//  LoginViewModel.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {

    @Published var username = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let authService = AuthService()

    func login(authManager: AuthManager) async {

        isLoading = true
        errorMessage = nil

        do {

            let response = try await authService.login(
                username: username,
                password: password
            )

            authManager.login(
                accessToken: response.accessToken,
                refreshToken: response.refreshToken
            )

        } catch {

            print(error)
            errorMessage = error.localizedDescription
//            errorMessage = "Login failed"

        }

        isLoading = false
    }
}
