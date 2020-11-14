//
//  AuthToken.swift
//  WhatsNext
//
//  Created by remi mestdagh on 14/11/2020.
//

import Foundation
struct AuthToken: Decodable {
  let accessToken: String
  let tokenType: String

  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
  }
}
