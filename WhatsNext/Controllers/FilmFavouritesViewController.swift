//
//  FilmFavouritesViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 10/11/2020.
//
import UIKit

/// minimalist tableview to display already watched films
class FilmFavouritesViewController: UITableViewController {
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    var films: [Film] = []
    var currentFilm: Film?
    let loadingIndicator = UIActivityIndicatorView(style: .large)

    /// logout button, returns to login screen
    /// - Parameter sender: the logout button
    @IBAction func didPressLogoutButton(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()

        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

        let mySceneDelegate: SceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        mySceneDelegate.window?.rootViewController = loginVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchFilms()
    }

    /// fetches films from api, includes loading animation
    func fetchFilms() {
        loadingIndicator.startAnimating()
        Network.shared.getFavouriteFilms { [self] films in
            self.films = films
            loadingIndicator.stopAnimating()
            tableView.reloadData()
        }
    }

    /// method to render a cell of a tableview
    /// - Parameters:
    ///   - tableView: the tableview
    ///   - indexPath: index of the cell in the tableview
    /// - Returns: the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath)
        cell.textLabel?.text = films[indexPath.row].titel
        cell.detailTextLabel?.text = films[indexPath.row].regisseur
        return cell
    }

}

extension FilmFavouritesViewController {
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    currentFilm = films[indexPath.row]
    return indexPath
  }
}

extension FilmFavouritesViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return films.count
  }
}
