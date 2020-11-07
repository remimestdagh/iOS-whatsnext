//
//  AccountController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation

class AccountController {
    static let shared = AccountController()
    let baseURL = URL(string: "http://192.168.1.37:45455/api/")!
    
    func login(){
        let loginURL = baseURL.appendingPathComponent("Account/login")
        let task = URLSession.shared.dataTask(with: loginURL){(data,response,error) in
            //verwerk teruggegeven JWT token
        }
        
    }
    
    
}
