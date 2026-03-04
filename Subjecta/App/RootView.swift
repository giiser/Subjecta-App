//
//  RootView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject var authManager: AuthManager

    var body: some View {

        Group {

            if authManager.isAuthenticated {
                SubjectsView()
            } else {
                LoginView()
            }

        }
    }
}
