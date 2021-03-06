//
//  Register.swift
//  WhatsNext
//
//  Created by remi mestdagh on 29/11/2020.
//

import Foundation

/// struct to pass paramters to register method
struct Register: Encodable {
    let email: String
    let password: String
    let passwordConfirmation: String
    let firstName: String
    let lastName: String

}
