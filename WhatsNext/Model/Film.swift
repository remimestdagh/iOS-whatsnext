//
//  Film.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation

struct Film {
    var id:Int
    var titel:String
    var regisseur: String
    var year: Int
    var score:Int
    var acteurs: [String]
    var titleImage:String
    var runtime:Int
    
    enum CodingKeys: String, CodingKey{
        case id
        case titel
        case regisseur
        case year
        case score
        case acteurs
        case titleImage
        case runtime
    }
}
extension Film: Decodable{
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self,forKey:.id)
        titel = try container.decode(String.self,forKey:.titel)
        regisseur = try container.decode(String.self,forKey:.regisseur)
        year = try container.decode(Int.self,forKey:.year)
        score = try container.decode(Int.self,forKey:.score)
        acteurs = try container.decode([String].self,forKey:.id)
        titleImage = try container.decode(String.self,forKey:.id)
        runtime = try container.decode(Int.self,forKey:.id)
    }
    
}
