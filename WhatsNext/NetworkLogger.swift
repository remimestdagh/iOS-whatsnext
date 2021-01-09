//
//  NetworkLogger.swift
//  WhatsNext
//
//  Created by remi mestdagh on 08/11/2020.
//

import Foundation
import Alamofire

/// provides logging functionality to api, prints objects in console
class NetworkLogger: EventMonitor {

  func requestDidFinish(_ request: Request) {
    print(request.description)
  }

  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard let data = response.data else {
      return
    }
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      print(json)
    }
  }
}
