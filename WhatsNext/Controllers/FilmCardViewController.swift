//
//  FilmCardViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 21/11/2020.
//

import Foundation
import UIKit
class FilmCardViewController: UIViewController {
    var films: [Film] = []

    func getNextFilms() {
        Network.shared.getNextFilms(skip: "100") {
            [self] films in
            self.films = films
            print(films)

        }
    }

}
