//
//  Endpoint.swift
//  Subjecta
//
//  Created by Sergii Ignatov on 04.03.2026.
//

import Foundation

enum HTTPMethod: String {

    case GET
    case POST
    case PUT
    case DELETE

}

protocol Endpoint {

    var path: String { get }

    var method: HTTPMethod { get }

    var body: Data? { get }

    var headers: [String:String] { get }

    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {

    var queryItems: [URLQueryItem]? {
        nil
    }

}
