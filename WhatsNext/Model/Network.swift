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
