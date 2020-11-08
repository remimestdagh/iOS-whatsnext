//
//  AccountController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation
import UberCore
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

    let loginO = Login(email: "test@test.test", password: "testPassword")

    func login(login: Login)  {
        
        AF.request("http://192.168.1.37:45455/api/Account",
    method: .post,
    parameters: login,
    encoder:JSONParameterEncoder.default).response {
        response in
        debugPrint(response)
        }
    }
}
