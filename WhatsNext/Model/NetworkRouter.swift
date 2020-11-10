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
    
    var baseURL:String { return "http://192.168.1.37:45455/api/"}
    
    var path: String {
        switch self {
        case .fetchFavourites:
            return "Film/GetFavourites"
        case .login:
        return "Account"
        }
    }
    var method:HTTPMethod {
        switch self {
        case .fetchFavourites:
            return .get
        case .login:
            return .post
            
        }
    }
    var parameters: [String: String]? {
      switch self {
      case .fetchFavourites:
        return ["":""]
      case .login:
        return [
            "email":"student@hogent.be",
            "password":"P@ssword123"
        
        ]
        
      }
    }
    
    
}
extension NetworkRouter: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
    let url = try baseURL.asURL().appendingPathComponent(path)
    var request = URLRequest(url: url)
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
