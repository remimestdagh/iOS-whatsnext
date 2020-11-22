//
//  NetworkRouter.swift
//  WhatsNext
//
//  Created by remi mestdagh on 10/11/2020.
//

import Foundation
import Alamofire

enum NetworkRouter {
    case fetchFavourites
    case login
    case getNextFilms(String)

    var baseURL: String { return "http://192.168.1.37:45455/api/" }

    var path: String {
        switch self {
        case .fetchFavourites:
            return "Films/GetFavourites"
        case .login:
        return "Account"
        case .getNextFilms:
            return "Films/GetNextFilms"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .fetchFavourites:
            return .get
        case .login:
            return .post
        case .getNextFilms:
            return .get

        }
    }
    var parameters: [String: String]? {
      switch self {
      case .fetchFavourites:
        return nil
      case .login:
        return [
            "email": "student@hogent.be",
            "password": "P@ssword123"

        ]
      case .getNextFilms(let skip):
        return ["skip": skip]

      }
    }

}
extension NetworkRouter: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
    let newUrl = try baseURL.asURL().appendingPathComponent(path)
    var request = URLRequest(url: newUrl)
    request.method = method
    if method == .get {
      request = try URLEncodedFormParameterEncoder()
        .encode(parameters, into: request)
    } else if method == .post {
      request = try JSONParameterEncoder().encode(parameters, into: request)
      request.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    return request
  }
}
