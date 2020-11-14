//
//  FilmFavouritesViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 10/11/2020.
//
import UIKit

class FilmFavouritesViewController: UITableViewController {
    var films: [Film] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFilms()
    }

    func fetchFilms() {

        Network.shared.getFilms {
            [self] films in
            self.films = films
            tableView.reloadData()
        }
    }

}
