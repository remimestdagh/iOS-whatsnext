//
//  AuthRequestInterceptor.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
import Alamofire
import UberCore

protocol AccessTokenStorage: class {
    typealias JWT = String
    var accessToken: JWT { get set }
}
final class AuthRequestInterceptor: Alamofire.RequestInterceptor{
    private let storage: AccessTokenStorage
    let retryLimit = 3
    let retryDelay: TimeInterval = 10
    
    init(storage: AccessTokenStorage) {
            self.storage = storage
        }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
            guard urlRequest.url?.absoluteString.hasPrefix("https://api.authenticated.com") == true else {
                /// If the request does not require authentication, we can directly return it as unmodified.
                return completion(.success(urlRequest))
            }
            var urlRequest = urlRequest

            /// Set the Authorization header value using the access token.
            urlRequest.setValue("Bearer " + storage.accessToken, forHTTPHeaderField: "Authorization")

            completion(.success(urlRequest))
        }
      func retry(
        _ request: Alamofire.Request,
        for session: Alamofire.Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
      ) {
        let response = request.task?.response as? HTTPURLResponse
        //Retry for 5xx status codes
        if
          let statusCode = response?.statusCode,
          (500...599).contains(statusCode),
          request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else {
          return completion(.doNotRetry)
        }
      }
}

