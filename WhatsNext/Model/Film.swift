//
//  Film.swift
//  WhatsNext
//
//  Created by remi mestdagh on 07/11/2020.
//

import Foundation

/// struct for film
struct Film {

    var id: Int
    var titel: String
    var regisseur: String
    var year: Int
    var score: Int
    var titleImage: String
    var runtime: Int
    var description: String

    enum CodingKeys: String, CodingKey {

        case id
        case titel
        case regisseur
        case year
        case score
        case titleImage
        case runtime
        case description
    }
}
extension Film: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        titel = try container.decode(String.self, forKey: .titel)
        regisseur = try container.decode(String.self, forKey: .regisseur)
        year = try container.decode(Int.self, forKey: .year)
        score = try container.decode(Int.self, forKey: .score)
        titleImage = try container.decode(String.self, forKey: .titleImage)
        runtime = try container.decode(Int.self, forKey: .runtime)
        description = try container.decode(String.self, forKey: .description)
    }

}
