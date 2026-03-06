//
//  TokenManager.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 05.03.2026.
//

import Foundation

class TokenManager {

    static let shared = TokenManager()

    private let keychain = KeychainManager.shared

    func getAccessToken() -> String? {
        keychain.get(key: AuthKeys.accessToken)
    }

    func getRefreshToken() -> String? {
        keychain.get(key: AuthKeys.refreshToken)
    }

    func save(accessToken: String, refreshToken: String) {

        keychain.save(key: AuthKeys.accessToken, value: accessToken)
        keychain.save(key: AuthKeys.refreshToken, value: refreshToken)

    }

}
