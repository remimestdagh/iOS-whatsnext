//
//  FilmWatchlistViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 29/11/2020.
//

import Foundation
import UIKit
class FilmCell: UITableViewCell {
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
}
class FilmWatchlistViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var films: [Film] = []
    var filteredFilms: [Film]!
    var currentFilm: Film?
    let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        searchBar.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let filmDetailViewController = segue.destination as! FilmDetailViewController
        let indexPath = tableView.indexPathForSelectedRow
        filmDetailViewController.film = self.filteredFilms[indexPath!.row]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchFilms()
        filteredFilms = films

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {

            filteredFilms = films
            tableView.reloadData()
            return
        }
      filteredFilms = films.filter { (film: Film) -> Bool in
        return film.titel.lowercased().contains(searchText.lowercased())
      }

      tableView.reloadData()
    }
    func fetchFilms() {
        loadingIndicator.startAnimating()
        Network.shared.getWatchlist { [self] films in
            self.films = films
            self.filteredFilms = films
            loadingIndicator.stopAnimating()
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell

        let imageURL = URL(string: filteredFilms[indexPath.row].titleImage)!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell.posterImg.image = image
            }
        }
        cell.titleLbl.text = filteredFilms[indexPath.row].titel
        return cell
    }

}

extension FilmWatchlistViewController {
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    currentFilm = filteredFilms[indexPath.row]
    return indexPath
  }
}

extension FilmWatchlistViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredFilms.count
  }
}
