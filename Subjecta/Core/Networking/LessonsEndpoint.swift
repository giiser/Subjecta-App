import Foundation

enum LessonsEndpoint: Endpoint {

    case lessonsByTopic(String)
    case lessonDetail(String)

    var path: String {

        switch self {

        case .lessonsByTopic:
            return "lessons"

        case .lessonDetail(let lessonId):
            return "lessons/\(lessonId)"

        }
    }

    var queryItems: [URLQueryItem]? {

        switch self {

        case .lessonsByTopic(let topicId):
            return [
                URLQueryItem(name: "topicId", value: topicId)
            ]

        case .lessonDetail:
            return nil
        }
    }

    var method: HTTPMethod { .GET }

    var body: Data? { nil }

    var headers: [String : String] { [:] }
}
