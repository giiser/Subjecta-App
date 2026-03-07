//
//  AuthStore.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 07.03.2026.
//

import Foundation

class AuthStore {

    static let shared = AuthStore()

    private let accessKey = "access_token"
    private let refreshKey = "refresh_token"

    func saveTokens(access: String, refresh: String) {

        UserDefaults.standard.set(access, forKey: accessKey)
        UserDefaults.standard.set(refresh, forKey: refreshKey)

    }

    func accessToken() -> String? {

        UserDefaults.standard.string(forKey: accessKey)

    }

    func refreshToken() -> String? {

        UserDefaults.standard.string(forKey: refreshKey)

    }

    func clear() {

        UserDefaults.standard.removeObject(forKey: accessKey)
        UserDefaults.standard.removeObject(forKey: refreshKey)

    }

}
