//
//  AccountController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation
import Alamofire

class Network {
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.requestCachePolicy = .returnCacheDataElseLoad
      let responseCacher = ResponseCacher(behavior: .modify { _, response in
        let userInfo = ["date": Date()]
        return CachedURLResponse(
          response: response.response,
          data: response.data,
          userInfo: userInfo,
          storagePolicy: .allowed)
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

    func login(login: Login) {

        AF.request("http://192.168.1.37:45455/api/Account",
    method: .post,
    parameters: login,
    encoder: JSONParameterEncoder.default).responseString { [self] response in
        debugPrint(response)
        self.saveAccessCode(accessCode: response.value!)
        }

    }
    func saveAccessCode(accessCode: String) {
        TokenManager.shared.saveAccessToken(authToken: accessCode)
        }
    func getFavouriteFilms(completion: @escaping ([Film]) -> Void) {
        sessionManager.request(
            NetworkRouter.fetchFavourites).responseDecodable(of: [Film].self) {
            response in guard let films = response.value else { return completion([])
            }
        completion(films)
        }

    }
    func getNextFilms(skip: String, completion: @escaping ([Film]) -> Void) {
        sessionManager.request(
            NetworkRouter.getNextFilms(skip) as
                URLRequestConvertible).responseDecodable(of: [Film].self) { response in
                    guard let films = response.value
                    else {
                        print("mislukt")
                        return completion([])
                    }
                    print("gelukt")
                    completion(films)



    }
}
}
