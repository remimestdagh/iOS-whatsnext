//
//  AuthRequestInterceptor.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
import Alamofire
import UberCore

class AuthRequestInterceptor: RequestInterceptor{
    let retryLimit = 3
    let retryDelay: TimeInterval = 10
    
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
      ) {
        var urlRequest = urlRequest
        if let token = TokenManager.fetchToken() {
          urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
      }
      //3
      func retry(
        _ request: Alamofire.Request,
        for session: Session,
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

