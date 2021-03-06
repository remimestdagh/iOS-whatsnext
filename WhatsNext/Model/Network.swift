//
//  AccountController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation
import Alamofire

/// incorperates networkrouter, logger, interceptor to provide api functionality
class Network {
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
      let responseCacher = ResponseCacher(behavior: .modify { _, response in
        let userInfo = ["date": Date()]
        return CachedURLResponse(
          response: response.response,
          data: response.data,
          userInfo: userInfo,
          storagePolicy: .notAllowed
        )
      })

      let networkLogger = NetworkLogger()
      let interceptor = AuthRequestInterceptor()

      return Session(
        configuration: configuration,
        interceptor: interceptor,
        cachedResponseHandler: responseCacher,
        eventMonitors: [networkLogger])
    }()

    static let shared = Network()
    let baseURL = URL(string: "http://192.168.1.37:45455/api/")!

    func login(login: Login, completion: @escaping (Bool) -> Void) {

        AF.request("http://192.168.1.37:45455/api/Account",
    method: .post,
    parameters: login,
    encoder: JSONParameterEncoder.default).validate().responseString { [self] response in

        switch response.result {

        case .success(let data):
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self.saveAccessCode(accessCode: data)
            completion(true)

        case .failure:
            UserDefaults.standard.set(false, forKey: "isLoggedIn")

            completion(false)

        }

    }
    }

    func register(register: Register, completion: @escaping (Bool) -> Void) {

        AF.request("http://192.168.1.37:45455/api/Account/Register",
    method: .post,
    parameters: register,
    encoder: JSONParameterEncoder.default).validate().responseString { [self] response in
        switch response.result {

        case .success(let data):
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self.saveAccessCode(accessCode: data)
            completion(true)

        case .failure:
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            completion(false)

        }

    }

    }
    func saveAccessCode(accessCode: String) {
        TokenManager.shared.saveAccessToken(authToken: accessCode)
        }
    func getFavouriteFilms(completion: @escaping ([Film]) -> Void) {
        sessionManager.request(
            NetworkRouter.fetchFavourites as URLRequestConvertible).validate().responseDecodable(of: [Film].self) { response in
                guard let films = response.value
                else {

                    return completion([])
            }

                completion(films)
        }

    }
    func getWatchlist(completion: @escaping ([Film]) -> Void) {
        sessionManager.request(
            NetworkRouter.fetchWatchlist as
                URLRequestConvertible).validate().responseDecodable(of: [Film].self) { response in
                    guard let films = response.value
                    else {

                        return completion([])
                    }

                    completion(films)

        }
    }
    func getNextFilms(skip: Int, completion: @escaping ([Film]) -> Void) {
        sessionManager.request(
            NetworkRouter.getNextFilms(String(skip)) as
                URLRequestConvertible).validate().responseDecodable(of: [Film].self) { response in
                    guard let films = response.value
                    else {

                        return completion([])
                    }

                    completion(films)
    }
  }

    func addToWatchlist(id: String, completion: @escaping (Bool) -> Void) {
        sessionManager.request(NetworkRouter.addToWatchlist(id) as URLRequestConvertible
        ).validate().response { response in
            let result = response.result
            switch result {
            case .success:
                completion(true)

            case .failure:
                completion(false)

            }

        }
                }
    func addToWatched(id: String, completion: @escaping (Bool) -> Void) {
        sessionManager.request(NetworkRouter.addToWatched(id) as URLRequestConvertible
        ).validate().response { response in
            let result = response.result
            switch result {
            case .success:
                completion(true)

            case .failure:
                completion(false)

            }

        }
    }
}
