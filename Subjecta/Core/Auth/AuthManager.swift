//
//  AuthManager.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import Foundation
import Combine

@MainActor
class AuthManager: ObservableObject {

    @Published var isAuthenticated = false
    @Published var accessToken: String?

    private let keychain = KeychainManager.shared

    init() {

        if let token = keychain.get(key: "accessToken") {
            accessToken = token
            isAuthenticated = true
        }

    }

    func login(accessToken: String, refreshToken: String) {

        keychain.save(key: "accessToken", value: accessToken)
        keychain.save(key: "refreshToken", value: refreshToken)

        self.accessToken = accessToken
        self.isAuthenticated = true
    }

    func logout() {

        keychain.save(key: "accessToken", value: "")
        keychain.save(key: "refreshToken", value: "")

        accessToken = nil
        isAuthenticated = false
    }

}
