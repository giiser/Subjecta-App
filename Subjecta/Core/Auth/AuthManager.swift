//
//  AuthManager.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import Foundation
import Combine

class AuthManager: ObservableObject {

    @Published var isAuthenticated = false
    @Published var accessToken: String?

    func login(token: String) {
        accessToken = token
        isAuthenticated = true
    }

    func logout() {
        accessToken = nil
        isAuthenticated = false
    }

}
