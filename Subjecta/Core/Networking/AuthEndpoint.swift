import Foundation

enum AuthEndpoint: Endpoint {

    case login(LoginRequest)
    case refresh(String)

    var path: String {

        switch self {

        case .login:
            return "auth/login"

        case .refresh:
            return "auth/refresh"
        }
    }

    var method: HTTPMethod { .POST }

    var body: Data? {

        switch self {

        case .login(let request):
            return try? JSONEncoder().encode(request)

        case .refresh(let token):
            return try? JSONEncoder().encode(
                ["refreshToken": token]
            )
        }
    }

    var headers: [String : String] {
        ["Content-Type": "application/json"]
    }
}
