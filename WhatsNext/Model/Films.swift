//
//  Films.swift
//  WhatsNext
//
//  Created by remi mestdagh on 22/11/2020.
//

/// struct to decode api calls into array of film
struct Films: Decodable {
    let items: [Film]
}
