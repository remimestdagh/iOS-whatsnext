//
//  FilmFavouritesViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 10/11/2020.
//
import UIKit

class FilmFavouritesViewController: UITableViewController {
    var films: [Film] = []
    var moreFilms : [Film] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFilms()
        getNextFilms()
    }

    func fetchFilms() {

        Network.shared.getFavouriteFilms {
            [self] films in
            self.films = films

            tableView.reloadData()
            print(films)
        }
    }
    func getNextFilms() {
        Network.shared.getNextFilms(skip: "100") {
            [self] moreFilms in
            self.moreFilms = moreFilms
            print(moreFilms)

        }
    }

}
