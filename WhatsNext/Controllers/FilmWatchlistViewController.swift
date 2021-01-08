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
class FilmWatchlistViewController: UITableViewController {

    var films: [Film] = []
    var currentFilm: Film?
    let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let filmDetailViewController = segue.destination as! FilmDetailViewController
        let indexPath = tableView.indexPathForSelectedRow
        filmDetailViewController.film = self.films[indexPath!.row]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchFilms()
    }

    func fetchFilms() {
        loadingIndicator.startAnimating()
        Network.shared.getWatchlist { [self] films in
            self.films = films
            loadingIndicator.stopAnimating()
            tableView.reloadData()
            print(self.films.count)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell

        let imageURL = URL(string: films[indexPath.row].titleImage)!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                cell.posterImg.image = image
            }
        }
        cell.titleLbl.text = films[indexPath.row].titel

        return cell
    }

}

extension FilmWatchlistViewController {
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    currentFilm = films[indexPath.row]
    return indexPath
  }
}

extension FilmWatchlistViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return films.count
  }

}
