//
//  LoginService.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//
import Foundation
protocol LoginService {
  func login(username: String, password: String, success: @escaping (User, String) -> Void, failure: @escaping (Error?) -> Void)
}
