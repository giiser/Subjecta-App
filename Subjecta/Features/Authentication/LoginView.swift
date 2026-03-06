//
//  LoginView.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()

    @EnvironmentObject var authManager: AuthManager

    var body: some View {

        VStack(spacing: 20) {

            Text("Subjecta")
                .font(.largeTitle)

            TextField("Username", text: $viewModel.username)
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            Button("Login") {

                Task {
                    await viewModel.login(authManager: authManager)
                }

            }

            if viewModel.isLoading {
                ProgressView()
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

        }
        .padding()
    }
}
