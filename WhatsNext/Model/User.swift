//
//  User.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation
/// struct to store user information
struct User {
  var username: String?
  var password: String?
  var token: String?

  init(username: String?, password: String?, token: String? = nil) {
    self.username = username
    self.password = password
    self.token = token
  }
}
