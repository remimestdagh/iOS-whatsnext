//
//  Film.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation

struct Film: Codable {
    var titel:String
    var regisseur: String
    var releaseDatum: Date
    var score:Int
}
