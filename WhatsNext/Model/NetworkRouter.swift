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
    case login(login: Login)
    case getNextFilms(String)
    case addToWatchlist(String)
    case addToWatched(String)
    case register(register: Register)

    var baseURL: String { return "http://192.168.1.37:45455/api/" }

    var path: String {
        switch self {
        case .fetchFavourites:
            return "Films/GetFavourites"
        case .login:
        return "Account"
        case .register:
            return "Account/Register"
        case .getNextFilms:
            return "Films/GetNextFilms"
        case .addToWatchlist(let id):
            return "Films/AddToWatchlist/\(id)"
        case .addToWatched(let id):
            return "Films/AddToWatched/\(id)"
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
        case .addToWatched:
            return .post
        case .addToWatchlist:
            return .post
        case .register:
            return .post

        }
    }
    var parameters: [String: String]? {
      switch self {
      case .fetchFavourites:
        return nil
      case .login(let login):
        return [
            "email": login.email,
            "password": login.password
        ]
      case .register(let register):
        return [
            "email": register.email,
            "password": register.password,
            "passwordConfirmation": register.passwordConfirmation,
            "lastName": register.lastName,
            "firstName": register.firstName

        ]

      case .getNextFilms(let skip):
        return ["skip": skip]
      case .addToWatched:
        return nil
      case .addToWatchlist(let id):
        return ["id": id]

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
