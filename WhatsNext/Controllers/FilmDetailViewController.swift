//
//  FilmDetailViewController.swift
//  WhatsNext
//
//  Created by remi mestdagh on 25/12/2020.
//

import Foundation
import UIKit
import Cards

class FilmDetailViewController: UIViewController {
    var film: Film?
    var safeArea: UILayoutGuide!
    @IBOutlet var card: CardArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupCard()
    }
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.card.backgroundImage = image
            }
        }
    }
    func setupCard() {

        card = CardArticle(frame: CGRect(x: 10, y: 30, width: 200, height: 300))

        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
        card.title = self.film!.titel
        card.textColor = UIColor.white
        card.subtitle = self.film!.description
        card.category = ""
        card.subtitleSize = 20

        card.hasParallax = false
        if let film = film {
            setImage(from: film.titleImage)
        }

        card.hasParallax = true

        view.addSubview(card)
        card.center = view.center

    }

}
