//
//  AuthRequestInterceptor.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
import Alamofire
/// interceptor for api, inserts auth token
class AuthRequestInterceptor: RequestInterceptor {
  let retryLimit = 5
    let retryDelay: TimeInterval = 10
    /// inserts token when calling api
    /// - Parameters:
    ///   - urlRequest: url of request
    ///   - session: current session
    ///   - completion: indicates success
  func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void
  ) {
    var urlRequest = urlRequest
    if let token = TokenManager.shared.fetchAccessToken() {
      urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    completion(.success(urlRequest))
  }
    /// retries request when error == server error
    /// - Parameters:
    ///   - request: request
    ///   - session: current session
    ///   - error: thrown error by server
    ///   - completion: success or not
  func retry(
    _ request: Alamofire.Request,
    for session: Session,
    dueTo error: Error,
    completion: @escaping (RetryResult) -> Void
  ) {
    let response = request.task?.response as? HTTPURLResponse
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
