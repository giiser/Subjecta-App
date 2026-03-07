import SwiftUI

struct LoginView: View {

    @EnvironmentObject var authManager: AuthManager
    @StateObject private var viewModel = LoginViewModel()

    @FocusState private var focusedField: Field?

    enum Field {
        case username
        case password
    }

    var body: some View {

        VStack(spacing: 24) {

            Text("Subjecta")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(spacing: 16) {

                TextField("Username", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .keyboardType(.asciiCapable)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .username)
                    .onSubmit {
                        focusedField = .password
                    }

                SecureField("Password", text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .submitLabel(.go)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        login()
                    }

            }

            if let error = viewModel.errorMessage {

                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)

            }

            Button {

                login()

            } label: {

                if viewModel.isLoading {

                    ProgressView()

                } else {

                    Text("Login")
                        .frame(maxWidth: .infinity)

                }

            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)

        }
        .padding(32)
        .task {

            focusedField = .username

        }

    }

    private func login() {

        Task {

            let success = await viewModel.login()

            if success {

                authManager.isAuthenticated = true

            }

        }

    }

}
