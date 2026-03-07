//
//  Subjecta_AppApp.swift
//  Subjecta-App
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import SwiftUI

@main
struct SubjectaApp: App {

    @StateObject private var authManager = AuthManager()
    @StateObject private var router = Router()

    var body: some Scene {

        WindowGroup {

            RootView()
                .environmentObject(authManager)
                .environmentObject(router)

        }
    }
}
